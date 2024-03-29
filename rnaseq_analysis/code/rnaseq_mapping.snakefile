#########################################
# Snakemake pipeline for paired-end RNA-Seq analysis
# Brian Do
# 220515
# Adapted from https://github.com/BleekerLab/snakemake_rnaseq 
#########################################


###########
# Libraries
###########
import pandas as pd

###############
# Configuration
###############
configfile: "config/bd327_config.yaml" # where to find parameters
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
BAM_FILES = expand(RESULT_DIR + "star/{sample}_Aligned.sortedByCoord.out.bam", sample = SAMPLES)


# rule all:
#     input:
#         BAM_FILES, 
#         RESULT_DIR + "raw_counts.parsed.tsv",
#         RESULT_DIR + "scaled_counts.tsv"
#     message:
#         "RNA-seq pipeline run complete!"
#     shell:
#         "cp config/config.yaml {RESULT_DIR};"
#         "cp config/samples.tsv {RESULT_DIR};"

rule all:
    input:
        BAM_FILES, 
        RESULT_DIR + "raw_counts.tsv",
    message:
        "RNA-seq pipeline run complete!"
#######
# Rules
#######


###########################
# Genome reference indexing
###########################

rule star_index:
    input:
        fasta = config["refs"]["genome"],
        gtf =   config["refs"]["gtf"]
    output:
         genome_index = [config["refs"]["dir"] + "STAR/" + f for f in ["chrLength.txt","chrNameLength.txt","chrName.txt","chrStart.txt","Genome","genomeParameters.txt","SA","SAindex"]]
    message:
        "generating STAR genome index"
    params:
        genome_dir = config["refs"]["dir"] + "STAR/",
        sjdb_overhang = config["star_index"]["sjdbOverhang"],
        limit_genome_generate_ram = config["star_index"]["limitGenomeGenerateRAM"],
        run_thread_n = config["star_index"]["runThreadN"]
    threads: config["star_index"]["runThreadN"]
    resources: mem_mb=100000
    shell:
        "mkdir -p {params.genome_dir}; " # if directory not created STAR will ask for it
        "STAR --runThreadN {threads} "
        "--runMode genomeGenerate "
        "--genomeDir {params.genome_dir} "
        "--genomeFastaFiles {input.fasta} "
        "--sjdbGTFfile {input.gtf} "
        "--sjdbOverhang {params.sjdb_overhang} "
        "--limitGenomeGenerateRAM {params.limit_genome_generate_ram} "


#########################
# RNA-Seq read alignment
#########################

rule map_to_genome_using_STAR:
    input:
        unpack(get_fastq)
    output:
        RESULT_DIR + "star/{sample}_Aligned.sortedByCoord.out.bam",
        RESULT_DIR + "star/{sample}_Log.final.out"
    message:
        "mapping {wildcards.sample} reads to genome"
    params:
        sample_name           =  "{sample}",
        genome_index          =  config["refs"]["dir"] + "STAR/",
        prefix                =  RESULT_DIR + "star/{sample}_",
        maxmismatches         =  config["star"]["mismatches"],
        unmapped              =  config["star"]["unmapped"]   ,
        multimappers          =  config["star"]["multimappers"],
        outSamType            =  config["star"]["samtype"], 
        threads               =  config["star"]["runThreadN"]
    threads: int(config["star"]["runThreadN"])
    resources: cpus=10
    shell:
        "STAR --genomeDir {params.genome_index} --readFilesIn {input.forward_read} {input.reverse_read} \
        --readFilesCommand zcat --outFilterMultimapNmax {params.multimappers} \
        --outFilterMismatchNmax {params.maxmismatches} --outTmpDir /tmp/{params.sample_name}  \
        --runThreadN {params.threads}  --outReadsUnmapped {params.unmapped} \
        --outFileNamePrefix {params.prefix} --outSAMtype {params.outSamType}"


##################################
# Produce table of raw gene counts
##################################

rule create_counts_table:
    input:
        bams = expand(RESULT_DIR + "star/{sample}_Aligned.sortedByCoord.out.bam", sample = SAMPLES),
        gtf  = config["refs"]["gtf"]
    output:
        RESULT_DIR + "raw_counts.tsv"
    params:
        threads = 10
    message: "Producing the table of raw counts"
    shell:
        "featureCounts -T {params.threads} -p -s 2 --primary -t exon -g gene_id -a {input.gtf} -o {output} {input.bams}"
