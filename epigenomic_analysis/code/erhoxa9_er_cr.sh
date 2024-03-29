nohup macs2 callpeak -t bowtie2_bam/ER_cst8644_DMSO_aligned_sorted_rmdup.bam \
-c bowtie2_bam/IgG_dsDNA_Mixed_aligned_sorted_rmdup.bam \
-f BAM -g mm \
-n ER_cst8644_DMSO \
--outdir macs2 &

nohup macs2 callpeak -t bowtie2_bam/ER_cst8644_BRQ24_aligned_sorted_rmdup.bam \
-c bowtie2_bam/IgG_dsDNA_Mixed_aligned_sorted_rmdup.bam \
-f BAM -g mm \
-n ER_cst8644_BRQ24 \
--outdir macs2 &

nohup macs2 callpeak -t bowtie2_bam/ER_cst8644_BRQ8_aligned_sorted_rmdup.bam \
-c bowtie2_bam/IgG_dsDNA_Mixed_aligned_sorted_rmdup.bam \
-f BAM -g mm \
-n ER_cst8644_BRQ8 \
--outdir macs2 &

nohup macs2 callpeak -t bowtie2_bam/ER_cst8644_E2wd8_aligned_sorted_rmdup.bam \
-c bowtie2_bam/IgG_dsDNA_Mixed_aligned_sorted_rmdup.bam \
-f BAM -g mm \
-n ER_cst8644_E2wd8 \
--outdir macs2 &

nohup macs2 callpeak -t bowtie2_bam/ER_cst8644_E2wd24_aligned_sorted_rmdup.bam \
-c bowtie2_bam/IgG_dsDNA_Mixed_aligned_sorted_rmdup.bam \
-f BAM -g mm \
-n ER_cst8644_E2wd24 \
--outdir macs2 &

# remaking the ER-Hoxa9 CUT&RUN heatmap

nohup computeMatrix reference-point -S \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/211201Van/results/bigwigs/ER_cst8644_DMSO_aligned_sorted_rmdup_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/211201Van/results/bigwigs/ER_cst8644_BRQ24_aligned_sorted_rmdup_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/211201Van/results/bigwigs/ER_cst8644_E2wd24_aligned_sorted_rmdup_norm.bw \
-R  ../macs2/ER_cst8644_DMSO_peaks.narrowPeak \
--referencePoint center -a 1000 -b 1000 -p 8 -o 231016_er_erhoxa9.gz \
--outFileNameMatrix 231016_er_erhoxa9.tab &


plotHeatmap -m 231016_er_erhoxa9.gz -o 231016_er_erhoxa9.pdf \
--dpi 300 --yMin 0 \
--zMin 0 \
--colorMap viridis \
--sortRegions descend \
--interpolationMethod bicubic \
--regionsLabel "940 ER-Hoxa9 peaks" \
--samplesLabel "DMSO" "BRQ 24h" "-E2 24h" --heatmapWidth 2 --heatmapHeight 8

