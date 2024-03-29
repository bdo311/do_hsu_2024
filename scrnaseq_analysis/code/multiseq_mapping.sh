# BD128 Analysis

# 9/6
# For pseudoalignment of genes
#https://www.kallistobus.tools/getting_started

# sbatch -N 1 -n 4 --mem=32000 kallisto.sh
kallisto bus -i ~/data/software/kallisto_indices/mus_musculus/transcriptome.idx  -o brq_merged -x 10xv2 -t 4 \
/net/bmc-pub15/data/bmc/public/Vanderheiden/200630Van/D20-2488-4537L/200630Van_D20-2488_1_sequence.fastq \
/net/bmc-pub15/data/bmc/public/Vanderheiden/200630Van/D20-2488-4537L/200630Van_D20-2488_2_sequence.fastq \
/net/bmc-pub15/data/bmc/public/Vanderheiden/200630Van/D20-3269-4585G/200630Van_D20-3269_1_sequence.fastq \
/net/bmc-pub15/data/bmc/public/Vanderheiden/200630Van/D20-3269-4585G/200630Van_D20-3269_2_sequence.fastq

# to get count matrix
mkdir genecount/ tmp/
bustools correct -w ~/data/software/kallisto_indices/10xv3_whitelist.txt -p output.bus | \
bustools sort -T tmp/ -t 4 -p - | bustools count -o genecount/genes \
-g ~/data/software/kallisto_indices/mus_musculus/transcripts_to_genes.txt -e matrix.ec -t transcripts.txt --genecounts -


# to get velocity
# sbatch -N 1 -n 4 --mem=64000 kallisto_velocity.sh
kallisto bus -i ~/data/software/kallisto_indices/mouse_intron_index/cDNA_introns.idx -o brq_merged_intron/ -x 10xv2 -t 4 \
/net/bmc-pub15/data/bmc/public/Vanderheiden/200630Van/D20-2488-4537L/200630Van_D20-2488_1_sequence.fastq \
/net/bmc-pub15/data/bmc/public/Vanderheiden/200630Van/D20-2488-4537L/200630Van_D20-2488_2_sequence.fastq \
/net/bmc-pub15/data/bmc/public/Vanderheiden/200630Van/D20-3269-4585G/200630Van_D20-3269_1_sequence.fastq \
/net/bmc-pub15/data/bmc/public/Vanderheiden/200630Van/D20-3269-4585G/200630Van_D20-3269_2_sequence.fastq

# to get scvelo inputs
cd brq_merged_intron
mkdir cDNA_capture/ introns_capture/ spliced/ unspliced/ tmp/
bustools correct -w ~/data/software/kallisto_indices/10xv3_whitelist.txt -p output.bus | \
bustools sort -o output.correct.sort.bus -T /tmp -t 8 -m 16G -
bustools capture -s -c ~/data/software/kallisto_indices/mouse_intron_index/cDNA_transcripts.to_capture.txt \
-e matrix.ec -t transcripts.txt output.correct.sort.bus -p > cDNA_capture/split.bus
bustools capture -s -c ~/data/software/kallisto_indices/mouse_intron_index/introns_transcripts.to_capture.txt \
-e matrix.ec -t transcripts.txt output.correct.sort.bus -p > introns_capture/split.bus
bustools count -o unspliced/u -g ~/data/software/kallisto_indices/mouse_intron_index/cDNA_introns.t2g.txt \
-e matrix.ec -t transcripts.txt --genecounts introns_capture/split.bus
bustools count -o spliced/s -g ~/data/software/kallisto_indices/mouse_intron_index/cDNA_introns.t2g.txt \
-e matrix.ec -t transcripts.txt --genecounts cDNA_capture/split.bus

