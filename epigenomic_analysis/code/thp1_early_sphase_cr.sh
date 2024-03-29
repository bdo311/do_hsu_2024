

# 7/1/2023
# recalculate H3K27ac peaks with macs2 
cd intermediate_data
mkdir macs2_h3k27ac
nohup parallel -j 12 "macs2 callpeak -t \
{} -c ../results/bowtie2_bam/BD345_THP1PIP_IgG_Unt_All_r1_aligned_sorted_rmdup_noblacklist.bam \
-f BAMPE -g hs -q 0.01  --nomodel \
-n {/.}_narrow \
--outdir macs2_h3k27ac" ::: ../results/bowtie2_bam/*H3K27ac*_noblacklist.bam &

nohup parallel -j 4 "macs2 callpeak -t \
{} -c ../results/bowtie2_bam/BD345_THP1PIP_IgG_Unt_All_r1_aligned_sorted_rmdup_noblacklist.bam \
-f BAMPE -g hs --broad --broad-cutoff 0.01 --nomodel \
-n {/.}_broad \
--outdir macs2_h3k27ac" ::: ../results/bowtie2_bam/*H3K27ac*_noblacklist.bam &

# combine replicate peaks
bedtools intersect -a BD345_THP1_H3K27ac_Unt_SortedAll_r1_aligned_sorted_rmdup_noblacklist_narrow_peaks.narrowPeak \
-b BD345_THP1_H3K27ac_Unt_SortedAll_r2_aligned_sorted_rmdup_noblacklist_narrow_peaks.narrowPeak -wa | cut -f1-3 | sort | uniq > BD345_THP1_H3K27ac_Unt_SortedAll_r1.comb.bed
bedtools intersect -a BD345_THP1_H3K27ac_Unt_Unsorted_r1_aligned_sorted_rmdup_noblacklist_narrow_peaks.narrowPeak \
-b BD345_THP1_H3K27ac_Unt_Unsorted_r2_aligned_sorted_rmdup_noblacklist_narrow_peaks.narrowPeak -wa | cut -f1-3 | sort | uniq > BD345_THP1_H3K27ac_Unt_Unsorted_r1.comb.bed
bedtools intersect -a BD345_THP1PIP_H3K27ac_HU100_8h_Early_r1_aligned_sorted_rmdup_noblacklist_narrow_peaks.narrowPeak \
-b BD345_THP1PIP_H3K27ac_HU100_8h_Early_r2_aligned_sorted_rmdup_noblacklist_narrow_peaks.narrowPeak -wa | cut -f1-3 | sort | uniq > BD345_THP1PIP_H3K27ac_HU100_8h_Early_r1.comb.bed
bedtools intersect -a BD345_THP1PIP_H3K27ac_HU100_8h_Late_r1_aligned_sorted_rmdup_noblacklist_narrow_peaks.narrowPeak \
-b BD345_THP1PIP_H3K27ac_HU100_8h_Late_r2_aligned_sorted_rmdup_noblacklist_narrow_peaks.narrowPeak -wa | cut -f1-3 | sort | uniq > BD345_THP1PIP_H3K27ac_HU100_8h_Late_r1.comb.bed
bedtools intersect -a BD345_THP1PIP_H3K27ac_Unt_Early_r1_aligned_sorted_rmdup_noblacklist_narrow_peaks.narrowPeak \
-b BD345_THP1PIP_H3K27ac_Unt_Early_r2_aligned_sorted_rmdup_noblacklist_narrow_peaks.narrowPeak -wa | cut -f1-3 | sort | uniq > BD345_THP1PIP_H3K27ac_Unt_Early_r1.comb.bed
bedtools intersect -a BD345_THP1PIP_H3K27ac_Unt_Late_r1_aligned_sorted_rmdup_noblacklist_narrow_peaks.narrowPeak \
-b BD345_THP1PIP_H3K27ac_Unt_Late_r2_aligned_sorted_rmdup_noblacklist_narrow_peaks.narrowPeak -wa | cut -f1-3 | sort | uniq > BD345_THP1PIP_H3K27ac_Unt_Late_r1.comb.bed

# merges the peaks 
cat *comb.bed | sort -k1,1 -k2,2n | bedtools merge | tee BD345_THP1_H3K27ac_merged.bed | wc -l

# Unfortunately the vast majority of peaks come from unt_r1_norm and unt_r2_norm.bw; what if we remove these? 
# drops from 50050 to 41622 
cat BD345_THP1_H3K27ac_Unt_SortedAll_r1.comb.bed BD345_THP1_H3K27ac_Unt_Unsorted_r1.comb.bed \
BD345_THP1PIP_H3K27ac_HU100_8h_Early_r1.comb.bed BD345_THP1PIP_H3K27ac_HU100_8h_Late_r1.comb.bed \
BD345_THP1PIP_H3K27ac_Unt_Late_r1.comb.bed | sort -k1,1 -k2,2n | bedtools merge | tee BD345_THP1_H3K27ac_merged_no_untearly.bed | wc -l


# make two SAF files
awk 'BEGIN {{OFS="\t"; print("GeneID", "Chr", "Start", "End", "Strand")}}; \
      {{print("peak" NR,$1,$2,$3,"+")}}' BD345_THP1_H3K27ac_merged.bed > \
      ../BD345_THP1_H3K27ac_merged.saf
awk 'BEGIN {{OFS="\t"; print("GeneID", "Chr", "Start", "End", "Strand")}}; \
      {{print("peak" NR,$1,$2,$3,"+")}}' BD345_THP1_H3K27ac_merged_no_untearly.bed > \
      ../BD345_THP1_H3K27ac_merged_no_untearly.saf

# featureCounts 
module load subread

cd /home/briando/data/files/220711Van/intermediate_data
featureCounts -T 10 -p -O -M --fraction -F SAF -a \
BD345_THP1_H3K27ac_merged_no_untearly.saf \
-o 230701_BD345_THP1_H3K27ac_merged_no_untearly.txt \
../results/bowtie2_bam/BD345_THP1_H3K27ac_Unt_SortedAll_r1_aligned_sorted_rmdup_noblacklist.bam  \
../results/bowtie2_bam/BD345_THP1_H3K27ac_Unt_SortedAll_r2_aligned_sorted_rmdup_noblacklist.bam  \
../results/bowtie2_bam/BD345_THP1_H3K27ac_Unt_Unsorted_r1_aligned_sorted_rmdup_noblacklist.bam  \
../results/bowtie2_bam/BD345_THP1_H3K27ac_Unt_Unsorted_r2_aligned_sorted_rmdup_noblacklist.bam  \
../results/bowtie2_bam/BD345_THP1PIP_H3K27ac_Unt_Early_r1_aligned_sorted_rmdup_noblacklist.bam  \
../results/bowtie2_bam/BD345_THP1PIP_H3K27ac_Unt_Early_r2_aligned_sorted_rmdup_noblacklist.bam  \
../results/bowtie2_bam/BD345_THP1PIP_H3K27ac_Unt_Late_r1_aligned_sorted_rmdup_noblacklist.bam  \
../results/bowtie2_bam/BD345_THP1PIP_H3K27ac_Unt_Late_r2_aligned_sorted_rmdup_noblacklist.bam  \
../results/bowtie2_bam/BD345_THP1PIP_H3K27ac_HU100_8h_Early_r1_aligned_sorted_rmdup_noblacklist.bam  \
../results/bowtie2_bam/BD345_THP1PIP_H3K27ac_HU100_8h_Early_r2_aligned_sorted_rmdup_noblacklist.bam  \
../results/bowtie2_bam/BD345_THP1PIP_H3K27ac_HU100_8h_Late_r1_aligned_sorted_rmdup_noblacklist.bam  \
../results/bowtie2_bam/BD345_THP1PIP_H3K27ac_HU100_8h_Late_r2_aligned_sorted_rmdup_noblacklist.bam