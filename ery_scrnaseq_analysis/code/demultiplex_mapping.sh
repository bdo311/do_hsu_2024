# can demultiplex using KITE, then use 230414_bd391_kite_demultiplex.ipynb
# or use 230414_multiseq_demultiplex.r.ipynb (preferred)
kb ref -i mismatch.idx -f1 mismatch.fa -g t2g.txt --workflow kite multiseq_barcodes.txt
kallisto bus -i mismatch.idx -o . -x 10xv3 -t 2 ../fastqs/230322Van_D23-4310_1_sequence.fastq.gz ../fastqs/230322Van_D23-4310_2_sequence_trimmed.fastq.gz

# analyze transcriptome data
kb count -i ~/data/software/kallisto_indices/mus_musculus/transcriptome.idx  -o ery_data -x 10xv3 -t 4 fastqs/230322Van_D23-4580_1_sequence.fastq.gz fastqs/230322Van_D23-4580_2_sequence.fastq.gz fastqs/230412_HMTCW_6181L_L1_1_sequence_unmapped_barcodes.fastq.gz fastqs/230412_HMTCW_6181L_L1_2_sequence_unmapped_barcodes.fastq.gz
