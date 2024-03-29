#########################################
# Snakemake pipeline for C&R analysis
# Brian Do
# 220612
# Adapted from https://github.com/BleekerLab/snakemake_rnaseq 
#########################################


###########
# Libraries
###########
import pandas as pd

###############
# Configuration
###############
configfile: "config/thp1_cutandrun.yaml" # where to find parameters
WORKING_DIR = config["working_dir"]
RESULT_DIR = config["result_dir"]


########################
# Samples and conditions
########################

# read the tabulated separated table containing the sample, condition and fastq file information∂DE
samples = pd.read_csv(config["sample_sheet"], dtype=str).set_index(["name"], drop=False)
SAMPLES = samples.index.tolist()

###########################
# Input functions for rules
###########################

def get_fastq(wildcards):
    return({"forward_read": config["fastq_dir"] + samples.loc[(wildcards.sample), "filename1"],
            "reverse_read": config["fastq_dir"] + samples.loc[(wildcards.sample), "filename2"]})

#################
# Desired outputs
#################
BAM_FILES = expand(RESULT_DIR + "bowtie2_bam/{sample}_aligned_sorted_rmdup_noblacklist.bam", sample = SAMPLES)
ECOLI_BAM = expand(RESULT_DIR + "bowtie2_bam/{sample}_ecoli_aligned_reads.bam", sample = SAMPLES)
BW_FILES = expand(RESULT_DIR + "bigwigs/{sample}_norm.bw", sample = SAMPLES)

rule all:
    input:
        BAM_FILES, 
        ECOLI_BAM,
        BW_FILES
    message:
        "CUT&RUN run complete!"

#######
# Rules
#######

rule map_to_genome_using_bowtie:
    input:
        unpack(get_fastq)
    output:
        RESULT_DIR + "bowtie2_bam/{sample}_aligned_reads.bam"
    message:
        "mapping {wildcards.sample} reads to genome"
    params:
        sample_name           =  "{sample}",
        genome_index          =  config["genome_index"],
        prefix                =  RESULT_DIR + "bowtie2_bam/{sample}",
        threads               =  config["threads"]
    threads: int(config["threads"])
    resources: 
        cpus = config["threads"]
    shell:
        "mkdir -p logs; "
        "bowtie2 -p {params.threads} --dovetail -I 10 -X 700 --very-sensitive-local --local \
        --phred33 --no-unal -x {params.genome_index} -1 {input.forward_read} -2 {input.reverse_read} 2> logs/{wildcards.sample}_log.bowtie2 | \
        samtools view -bS - > {params.prefix}_aligned_reads.bam"


rule map_to_ecoli_genome_using_bowtie:
    input:
        unpack(get_fastq)
    output:
        RESULT_DIR + "bowtie2_bam/{sample}_ecoli_aligned_reads.bam"
    message:
        "mapping {wildcards.sample} reads to genome"
    params:
        sample_name           =  "{sample}",
        genome_index          =  config["ecoli_genome_index"],
        prefix                =  RESULT_DIR + "bowtie2_bam/{sample}",
        threads               =  config["threads"]
    threads: int(config["threads"])
    resources: 
        cpus = config["threads"]
    shell:
        "mkdir -p logs; "
        "bowtie2 -p {params.threads} --dovetail -I 10 -X 700 --very-sensitive-local --local \
        --phred33 --no-unal -x {params.genome_index} -1 {input.forward_read} -2 {input.reverse_read} 2> logs/{wildcards.sample}_ecoli_log.bowtie2 | \
        samtools view -bS - > {params.prefix}_ecoli_aligned_reads.bam"

rule sort_rmdup_bowtie_and_index:
    input:
        RESULT_DIR + "bowtie2_bam/{sample}_aligned_reads.bam"
    output:
        sorted_output = RESULT_DIR + "bowtie2_bam/{sample}_aligned_sorted_rmdup.bam",
        sorted_index = RESULT_DIR + "bowtie2_bam/{sample}_aligned_sorted_rmdup.bam.bai"
    params:
        working_dir = WORKING_DIR,
        tmp = WORKING_DIR + "{sample}"
    shell:
        "mkdir -p {params.working_dir}; samtools view -h -f 0x2 {input} | samtools collate -o - - | samtools fixmate -m - - | \
        samtools sort -T {params.tmp} -o - - | samtools markdup -r - {output.sorted_output} && samtools index {output.sorted_output}"

rule remove_blacklist:
    input:
        RESULT_DIR + "bowtie2_bam/{sample}_aligned_sorted_rmdup.bam"
    output:
        RESULT_DIR + "bowtie2_bam/{sample}_aligned_sorted_rmdup_noblacklist.bam"
    params:
        blacklist = config["blacklist"]
    shell:
        "bedtools intersect -v -abam {input} -b {params.blacklist} > {output} && samtools index {output}"

rule normalize_and_make_tracks:
    input:
        RESULT_DIR + "bowtie2_bam/{sample}_aligned_sorted_rmdup_noblacklist.bam"
    output:
        RESULT_DIR + "bigwigs/{sample}_norm.bw"
    params:
        threads = config["threads"],
        aligned_rmdup = RESULT_DIR + "bowtie2_bam/{sample}_aligned_sorted_rmdup.bam"
    shell:
        "bamCoverage -b {input} -o {output} --normalizeUsing CPM -p {params.threads} -bs 1 -e 200 && "
        "rm -f {params.aligned_rmdup}"

