# all in /net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/notebooks/230715_heatmaps
# outputs: /Users/briando/Dropbox (MIT)/MVH_Code/brq/data/230107_633_atac_k27_homer

### for ER cells
nohup computeMatrix reference-point -S \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/cutandrun_analysis/results/bigwigs/63.3_DMSO_H3K4me1_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/221218Van/results/bigwigs/H3K27ac_DMSO_24h_rep1_normdup_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/221218Van/results/bigwigs/H3K27ac_BRQ_2uM_24h_rep1_normdup_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/221218Van/results/bigwigs/H3K27ac_E2wd_24h_rep1_normdup_norm.bw  \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/633_BRQ0_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/633_BRQ24_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/633_E2wd24_rep1_ATACseq.bw \
-R  230620_633_k27_up_shared.bed 230620_633_k27_up_b24.bed 230620_633_k27_up_e24.bed --maxThreshold 100 \
--referencePoint center -a 2000 -b 2000 -p 8 -o 231224_633_k27ac_with_k4me1.gz \
--outFileNameMatrix 231224_633_k27ac_with_k4me1.tab &

plotProfile -m 230715_633_k27ac.gz -o 230715_633_k27ac_profile.pdf \
--yMin 0 --yMax 1.5 1.5 1.5 25 25 25 \
--regionsLabel "Shared up" "Up in BRQ" "Up in -E2" \
--samplesLabel "H3K27ac DMSO" "H3K27ac BRQ" "H3K27ac -E2" "ATAC DMSO" "ATAC BRQ" "ATAC -E2" \
--yMin 0 &


plotHeatmap -m 230715_633_k27ac.gz -o 230715_633_k27ac.png \
--dpi 300 --yMin 0 --yMax 1.5 1.5 1.5 25 25 25 \
--zMin 0 --zMax 1 1 1 12 12 12 \
--colorMap viridis viridis viridis magma magma magma \
--sortRegions descend \
--interpolationMethod bicubic \
--samplesLabel "H3K27ac DMSO" "H3K27ac BRQ" "H3K27ac -E2" "ATAC DMSO" "ATAC BRQ" "ATAC -E2" \
--regionsLabel "Shared up" "Up in BRQ" "Up in -E2" &


# plotting K27ac and ATAC separately
nohup computeMatrix reference-point -S \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/221218Van/results/bigwigs/H3K27ac_DMSO_24h_rep1_normdup_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/221218Van/results/bigwigs/H3K27ac_BRQ_2uM_24h_rep1_normdup_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/221218Van/results/bigwigs/H3K27ac_E2wd_24h_rep1_normdup_norm.bw  \
-R  230620_633_k27_up_shared.bed 230620_633_k27_up_b24.bed 230620_633_k27_up_e24.bed --maxThreshold 100 \
--referencePoint center -a 2000 -b 2000 -p 8 -o 230715_633_k27acup_k27only.gz \
--outFileNameMatrix 230715_633_k27acup_k27only.tab &

nohup computeMatrix reference-point -S \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/633_BRQ0_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/633_BRQ24_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/633_E2wd24_rep1_ATACseq.bw \
-R  230620_633_k27_up_shared.bed 230620_633_k27_up_b24.bed 230620_633_k27_up_e24.bed --maxThreshold 100 \
--referencePoint center -a 2000 -b 2000 -p 8 -o 230715_633_k27acup_atac.gz \
--outFileNameMatrix 230715_633_k27acup_atac.tab &

plotProfile -m 230715_633_k27acup_k27only.gz -o 230715_633_k27acup_k27only_profile_pergroup.pdf \
--yMin 0 --yMax 1.5 \
--colors "#4D4D4D" "#F8766D" "#00BFC4" \
--regionsLabel "Up in both" "Up in BRQ" "Up in -E2" \
--samplesLabel "DMSO" "BRQ" "\-E2" \
--perGroup --numPlotsPerRow 1 --outFileNameData 230715_633_k27acup_k27only_profile_pergroup.txt &

plotProfile -m 230715_633_k27acup_atac.gz -o 230715_633_k27acup_atac_profile_pergroup.pdf \
--yMin 0 --yMax 25 \
--colors "#4D4D4D" "#F8766D" "#00BFC4" \
--regionsLabel "Up in both" "Up in BRQ" "Up in -E2" \
--samplesLabel "DMSO" "BRQ" "\-E2" \
--perGroup --numPlotsPerRow 1 --outFileNameData 230715_633_k27acup_atac_profile_pergroup.txt &

plotProfile -m 230715_633_k27acup_k27only.gz -o 230715_633_k27acup_k27only_profile.pdf \
--yMin 0 --yMax 1.5 \
--colors gray red blue \
--regionsLabel "Up in both" "Up in BRQ" "Up in -E2" \
--samplesLabel "DMSO" "BRQ" "\-E2" &

plotProfile -m 230715_633_k27acup_atac.gz -o 230715_633_k27acup_atac_profile.pdf \
--yMin 0 --yMax 25 \
--colors gray red blue \
--regionsLabel "Up in both" "Up in BRQ" "Up in -E2" \
--samplesLabel "DMSO" "BRQ" "\-E2" &

# no shared
cat 230620_633_k27_up_shared.bed 230620_633_k27_up_b24.bed > 230620_633_k27_up_b24_and_shared.bed
cat 230620_633_k27_up_shared.bed 230620_633_k27_up_e24.bed > 230620_633_k27_up_e24_and_shared.bed

nohup computeMatrix reference-point -S \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/cutandrun_analysis/results/bigwigs/63.3_DMSO_H3K4me1_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/221218Van/results/bigwigs/H3K27ac_DMSO_24h_rep1_normdup_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/221218Van/results/bigwigs/H3K27ac_BRQ_2uM_24h_rep1_normdup_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/221218Van/results/bigwigs/H3K27ac_E2wd_24h_rep1_normdup_norm.bw  \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/633_BRQ0_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/633_BRQ24_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/633_E2wd24_rep1_ATACseq.bw \
-R  230620_633_k27_up_b24_and_shared.bed 230620_633_k27_up_e24_and_shared.bed \
--maxThreshold 100 --missingDataAsZero \
--referencePoint center -a 2000 -b 2000 -p 8 -o 231224_633_k27ac_with_k4me1_noshared.gz \
--outFileNameMatrix 231224_633_k27ac_with_k4me1_noshared.tab &

plotProfile -m 231224_633_k27ac_with_k4me1_noshared.gz -o 231224_633_k27ac_with_k4me1_noshared_profile.pdf \
--yMin 0 --yMax 0.5 1.5 1.5 1.5 20 20 20 \
--regionsLabel "Up in BRQ" "Up in -E2" \
--samplesLabel "H3K4me1 DMSO" "H3K27ac DMSO" "H3K27ac BRQ" "H3K27ac -E2" "ATAC DMSO" "ATAC BRQ" "ATAC -E2" \
--yMin 0 &

plotHeatmap -m 231224_633_k27ac_with_k4me1_noshared.gz -o 231224_633_k27ac_with_k4me1_noshared.pdf \
--dpi 100 --yMin 0 --yMax 0.5 1.5 1.5 1.5 20 20 20 \
--zMin 0 --zMax 0.5 1 1 1 12 12 12 \
--colorMap cividis viridis viridis viridis magma magma magma \
--sortRegions descend --sortUsingSamples 5 \
--interpolationMethod bicubic \
--samplesLabel "H3K4me1 DMSO" "H3K27ac DMSO" "H3K27ac BRQ" "H3K27ac -E2" "ATAC DMSO" "ATAC BRQ" "ATAC -E2" \
--regionsLabel "Up in BRQ" "Up in -E2" \
--heatmapWidth 4 --heatmapHeight 25 &











### for THP cells 
nohup computeMatrix reference-point -S \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/cutandrun_analysis/results/bigwigs/THP_DMSO_H3K27ac_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/cutandrun_analysis/results/bigwigs/THP_BRQ_24h_H3K27ac_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/cutandrun_analysis/results/bigwigs/THP_PMA_24h_H3K27ac_norm.bw  \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/THP1_DMSO_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/THP1_BRQ24_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/THP1_PMA24_rep1_ATACseq.bw \
-R  230620_thp1_k27_up_shared24.bed 230620_thp1_k27_up_b24.bed 230620_thp1_k27_up_p24.bed --maxThreshold 100 \
--referencePoint center -a 2000 -b 2000 -p 8 -o 230715_thp1_k27ac.gz \
--outFileNameMatrix 230715_thp1_k27ac.tab &

plotProfile -m 230715_thp1_k27ac.gz -o 230715_thp1_k27ac_profile.pdf \
--yMin 0 --yMax 2 2 2 35 35 35 \
--samplesLabel "H3K27ac DMSO" "H3K27ac BRQ" "H3K27ac PMA" "ATAC DMSO" "ATAC BRQ" "ATAC PMA" \
--regionsLabel "Shared up" "Up in BRQ" "Up in PMA" &

plotHeatmap -m 230715_thp1_k27ac.gz -o 230715_thp1_k27ac.png \
--dpi 300 --yMin 0 --yMax 2 2 2 35 35 35 \
--zMin 0 --zMax 1 1 1 30 30 30 \
--colorMap viridis --sortRegions descend \
--colorMap viridis viridis viridis magma magma magma \
--interpolationMethod bicubic \
--samplesLabel "H3K27ac DMSO" "H3K27ac BRQ" "H3K27ac PMA" "ATAC DMSO" "ATAC BRQ" "ATAC PMA" \
--regionsLabel "Shared up" "Up in BRQ" "Up in PMA" &


# plotting K27ac and ATAC separately
nohup computeMatrix reference-point -S \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/cutandrun_analysis/results/bigwigs/THP_DMSO_H3K27ac_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/cutandrun_analysis/results/bigwigs/THP_BRQ_24h_H3K27ac_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/cutandrun_analysis/results/bigwigs/THP_PMA_24h_H3K27ac_norm.bw  \
-R  230620_thp1_k27_up_shared24.bed 230620_thp1_k27_up_b24.bed 230620_thp1_k27_up_p24.bed --maxThreshold 100 \
--referencePoint center -a 2000 -b 2000 -p 8 -o 230715_thp1_k27acup_k27only.gz \
--outFileNameMatrix 230715_thp1_k27acup_k27only.tab &

nohup computeMatrix reference-point -S \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/THP1_DMSO_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/THP1_BRQ24_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/THP1_PMA24_rep1_ATACseq.bw \
-R  230620_thp1_k27_up_shared24.bed 230620_thp1_k27_up_b24.bed 230620_thp1_k27_up_p24.bed --maxThreshold 100 \
--referencePoint center -a 2000 -b 2000 -p 8 -o 230715_thp1_k27acup_ataconly.gz \
--outFileNameMatrix 230715_thp1_k27acup_ataconly.tab &

plotProfile -m 230715_thp1_k27acup_k27only.gz -o 230715_thp1_k27acup_k27only_pergroup.pdf \
--yMin 0 --yMax 2 \
--colors "#4D4D4D" "#F8766D" "#00BFC4" \
--regionsLabel "Up in both" "Up in BRQ" "Up in PMA" \
--samplesLabel "DMSO" "BRQ" "PMA" \
--perGroup --numPlotsPerRow 1 --outFileNameData 230715_thp1_k27acup_k27only_pergroup.txt &

plotProfile -m 230715_thp1_k27acup_ataconly.gz -o 230715_thp1_k27acup_ataconly_pergroup.pdf \
--yMin 0 --yMax 35 \
--colors "#4D4D4D" "#F8766D" "#00BFC4" \
--regionsLabel "Up in both" "Up in BRQ" "Up in PMA" \
--samplesLabel "DMSO" "BRQ" "PMA" \
--perGroup  --numPlotsPerRow 1  --outFileNameData 230715_thp1_k27acup_ataconly_pergroup.txt &

plotProfile -m 230715_thp1_k27acup_k27only.gz -o 230715_thp1_k27acup_k27only.pdf \
--yMin 0 --yMax 2 \
--colors gray red blue \
--regionsLabel "Up in both" "Up in BRQ" "Up in PMA" \
--samplesLabel "DMSO" "BRQ" "PMA" &

plotProfile -m 230715_thp1_k27acup_ataconly.gz -o 230715_thp1_k27acup_ataconly.pdf \
--yMin 0 --yMax 35 \
--colors gray red blue \
--regionsLabel "Up in both" "Up in BRQ" "Up in PMA" \
--samplesLabel "DMSO" "BRQ" "PMA" &


# no shared
cat 230620_thp1_k27_up_shared24.bed 230620_thp1_k27_up_b24.bed > 230620_thp1_k27_up_b24_and_shared.bed
cat 230620_thp1_k27_up_shared24.bed 230620_thp1_k27_up_p24.bed > 230620_thp1_k27_up_p24_and_shared.bed


nohup computeMatrix reference-point -S \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/cutandrun_analysis/results/bigwigs/THP_DMSO_H3K27ac_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/cutandrun_analysis/results/bigwigs/THP_BRQ_24h_H3K27ac_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/cutandrun_analysis/results/bigwigs/THP_PMA_24h_H3K27ac_norm.bw  \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/THP1_DMSO_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/THP1_BRQ24_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/THP1_PMA24_rep1_ATACseq.bw \
-R  230620_thp1_k27_up_b24_and_shared.bed 230620_thp1_k27_up_p24_and_shared.bed --maxThreshold 100 \
--referencePoint center -a 2000 -b 2000 -p 8 -o 230715_thp1_k27ac_noshared.gz \
--outFileNameMatrix 230715_thp1_k27ac_noshared.tab &

plotProfile -m 230715_thp1_k27ac_noshared.gz -o 230715_thp1_k27ac_noshared_profile.pdf \
--yMin 0 --yMax 2 2 2 35 35 35 \
--samplesLabel "H3K27ac DMSO" "H3K27ac BRQ" "H3K27ac PMA" "ATAC DMSO" "ATAC BRQ" "ATAC PMA" \
--regionsLabel "Up in BRQ" "Up in PMA" &

plotHeatmap -m 230715_thp1_k27ac_noshared.gz -o 230715_thp1_k27ac_noshared_profile.pdf \
--dpi 300 --yMin 0 --yMax 2 2 2 35 35 35 \
--zMin 0 --zMax 1 1 1 30 30 30 \
--colorMap viridis --sortRegions descend \
--colorMap viridis viridis viridis magma magma magma \
--interpolationMethod bicubic \
--samplesLabel "H3K27ac DMSO" "H3K27ac BRQ" "H3K27ac PMA" "ATAC DMSO" "ATAC BRQ" "ATAC PMA" \
--whatToShow "heatmap and colorbar" \
--regionsLabel "Up in BRQ" "Up in PMA" \
--heatmapWidth 1.5 --heatmapHeight 10 &




# 10/16/23 CUT&RUN peaks 

nohup computeMatrix reference-point -S \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/221218Van/results/bigwigs/H3K27ac_DMSO_24h_rep1_normdup_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/221218Van/results/bigwigs/H3K27ac_BRQ_2uM_24h_rep1_normdup_norm.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/files/221218Van/results/bigwigs/H3K27ac_E2wd_24h_rep1_normdup_norm.bw  \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/633_BRQ0_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/633_BRQ24_rep1_ATACseq.bw \
/net/bmc-pub17/mirror/lab/vanderheiden/briando/differentiation_manuscript/atacseq_analysis/results/norm_bigwigs/633_E2wd24_rep1_ATACseq.bw \
-R  230620_633_k27_up_shared.bed 230620_633_k27_up_b24.bed 230620_633_k27_up_e24.bed --maxThreshold 100 \
--referencePoint center -a 2000 -b 2000 -p 8 -o 230715_633_k27ac.gz \
--outFileNameMatrix 230715_633_k27ac.tab &

