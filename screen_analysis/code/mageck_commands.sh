# ER-Hoxa9 screens
# paired; basically counts each replicate as a completely different set of sgRNAs
# with negative control sgRNAs
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 	.txt -t DMSO_CD11b_high_rep1,DMSO_CD11b_high_rep2 -c DMSO_CD11b_low_rep1,DMSO_CD11b_low_rep2 --paired -n DMSO_CD11b --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t DMSO_GFP_high_rep1,DMSO_GFP_high_rep2 -c DMSO_GFP_low_rep1,DMSO_GFP_low_rep2 --paired -n DMSO_GFP --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t HU_CD11b_high_rep1,HU_CD11b_high_rep2 -c HU_CD11b_low_rep1,HU_CD11b_low_rep2 --paired -n HU_CD11b --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t HU_GFP_high_rep1,HU_GFP_high_rep2 -c HU_GFP_low_rep1,HU_GFP_low_rep2 --paired -n HU_GFP --control-sgrna 230408_bd354_neg_ctrl_guides.txt "
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t APH_CD11b_high_rep1,APH_CD11b_high_rep2 -c APH_CD11b_low_rep1,APH_CD11b_low_rep2 --paired -n APH_CD11b --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t APH_GFP_high_rep1,APH_GFP_high_rep2 -c APH_GFP_low_rep1,APH_GFP_low_rep2 --paired -n APH_GFP --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t E2wd_CD11b_high_rep1,E2wd_CD11b_high_rep2 -c E2wd_CD11b_low_rep1,E2wd_CD11b_low_rep2 --paired -n E2wd_CD11b --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t E2wd_GFP_high_rep1,E2wd_GFP_high_rep2 -c E2wd_GFP_low_rep1,E2wd_GFP_low_rep2 --paired -n E2wd_GFP --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t HU_GFP_high_rep1,HU_GFP_high_rep2,APH_GFP_high_rep1,APH_GFP_high_rep2 -c HU_GFP_low_rep1,HU_GFP_low_rep2,APH_GFP_low_rep1,APH_GFP_low_rep2 --paired -n HA_GFP --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t HU_CD11b_high_rep1,HU_CD11b_high_rep2,APH_CD11b_high_rep1,APH_CD11b_high_rep2 -c HU_CD11b_low_rep1,HU_CD11b_low_rep2,APH_CD11b_low_rep1,APH_CD11b_low_rep2 --paired -n HA_CD11b --control-sgrna 230408_bd354_neg_ctrl_guides.txt"

# unpaired; with negative control sgRNAs
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t DMSO_CD11b_high_rep1,DMSO_CD11b_high_rep2 -c DMSO_CD11b_low_rep1,DMSO_CD11b_low_rep2 -n DMSO_CD11b_unpaired --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t DMSO_GFP_high_rep1,DMSO_GFP_high_rep2 -c DMSO_GFP_low_rep1,DMSO_GFP_low_rep2 -n DMSO_GFP_unpaired --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t HU_CD11b_high_rep1,HU_CD11b_high_rep2 -c HU_CD11b_low_rep1,HU_CD11b_low_rep2 -n HU_CD11b_unpaired --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t HU_GFP_high_rep1,HU_GFP_high_rep2 -c HU_GFP_low_rep1,HU_GFP_low_rep2 -n HU_GFP_unpaired --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t APH_CD11b_high_rep1,APH_CD11b_high_rep2 -c APH_CD11b_low_rep1,APH_CD11b_low_rep2 -n APH_CD11b_unpaired --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t APH_GFP_high_rep1,APH_GFP_high_rep2 -c APH_GFP_low_rep1,APH_GFP_low_rep2 -n APH_GFP_unpaired --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t E2wd_CD11b_high_rep1,E2wd_CD11b_high_rep2 -c E2wd_CD11b_low_rep1,E2wd_CD11b_low_rep2 -n E2wd_CD11b_unpaired --control-sgrna 230408_bd354_neg_ctrl_guides.txt"	
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t E2wd_GFP_high_rep1,E2wd_GFP_high_rep2 -c E2wd_GFP_low_rep1,E2wd_GFP_low_rep2 -n E2wd_GFP_unpaired --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t HU_GFP_high_rep1,HU_GFP_high_rep2,APH_GFP_high_rep1,APH_GFP_high_rep2 -c HU_GFP_low_rep1,HU_GFP_low_rep2,APH_GFP_low_rep1,APH_GFP_low_rep2 -n HA_GFP_unpaired --control-sgrna 230408_bd354_neg_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t HU_CD11b_high_rep1,HU_CD11b_high_rep2,APH_CD11b_high_rep1,APH_CD11b_high_rep2 -c HU_CD11b_low_rep1,HU_CD11b_low_rep2,APH_CD11b_low_rep1,APH_CD11b_low_rep2 -n HA_CD11b_unpaired --control-sgrna 230408_bd354_neg_ctrl_guides.txt"

# unpaired day 2 dmso vs day 0
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230408_bd354_counts_mageck.txt -t DMSO_all_all_rep1,DMSO_all_all_rep2 -c Day0_all_all_rep1,Day0_all_all_rep2 -n DMSO_d2_vs_d0_unpaired --control-sgrna 230408_bd354_neg_ctrl_guides.txt"

# MAGECK for Wang et al. screens
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230512_wang2021_cd11b_scores.txt -t cd11b_top -c cd11b_bottom -n wang2021_cd11b --control-sgrna 230512_wang2021_negative_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230512_wang2021_cd14_scores.txt -t cd14_top -c cd14_bottom -n wang2021_cd14 --control-sgrna 230512_wang2021_negative_ctrl_guides.txt"

sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230512_wang2021_cd11b_scores.txt -t cd11b_top -c cd11b_bottom -n wang2021_cd11b_noctrl"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230512_wang2021_cd14_scores.txt -t cd14_top -c cd14_bottom -n wang2021_cd14_noctrl"

# MAGECK for my own THP-1 screens
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230512_bd191_rawcounts_for_mageck.txt -t cd11b_rep1_up,cd11b_rep2_up -c cd11b_rep1_down,cd11b_rep2_down --paired -n bd191_cd11b_paired --control-sgrna 230512_bd191_negative_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230512_bd191_rawcounts_for_mageck.txt -t cd11b_rep1_up,cd11b_rep2_up -c cd11b_rep1_down,cd11b_rep2_down -n bd191_cd11b_unpaired --control-sgrna 230512_bd191_negative_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230512_bd191_rawcounts_for_mageck.txt -t cd14_up -c cd14_down -n bd191_cd14 --control-sgrna 230512_bd191_negative_ctrl_guides.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230512_bd191_rawcounts_for_mageck.txt -t cd11b_rep1_up,cd11b_rep2_up -c cd11b_rep1_down,cd11b_rep2_down --paired -n bd191_cd11b_paired_noctrl"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230512_bd191_rawcounts_for_mageck.txt -t cd11b_rep1_up,cd11b_rep2_up -c cd11b_rep1_down,cd11b_rep2_down -n bd191_cd11b_unpaired_noctrl"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230512_bd191_rawcounts_for_mageck.txt -t cd14_up -c cd14_down -n bd191_cd14_noctrl"

# MAGECK for secondary screens
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t K562_DMSO_CD235a_High -c K562_DMSO_CD235a_Low -n k562_cd235a_dmso_hilo --control-sgrna 230727_bd246_negative_controls.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t K562_BRQ_CD235a_High -c K562_BRQ_CD235a_Low -n k562_cd235a_brq_hilo --control-sgrna 230727_bd246_negative_controls.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t K562_HU_CD235a_High -c K562_HU_CD235a_Low -n k562_cd235a_hu_hilo --control-sgrna 230727_bd246_negative_controls.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t K562_DMSO_CD61_High -c K562_DMSO_CD61_Low -n k562_cd61_dmso_hilo --control-sgrna 230727_bd246_negative_controls.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t K562_PMA_CD235a_High -c K562_PMA_CD235a_Low -n k562_cd235a_pma_hilo --control-sgrna 230727_bd246_negative_controls.txt"


sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t "THP-1_DMSO_CD11b_High" -c "THP-1_DMSO_CD11b_Low" -n thp1_cd11b_dmso_hilo --control-sgrna 230727_bd246_negative_controls.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t "THP-1_DMSO_CD14_High" -c "THP-1_DMSO_CD14_Low" -n thp1_cd14_dmso_hilo --control-sgrna 230727_bd246_negative_controls.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t "THP-1_BRQ_CD11b_High" -c "THP-1_BRQ_CD11b_Low" -n thp1_cd11b_brq_hilo --control-sgrna 230727_bd246_negative_controls.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t "THP-1_BRQ_CD14_High" -c "THP-1_BRQ_CD14_Low" -n thp1_cd14_brq_hilo --control-sgrna 230727_bd246_negative_controls.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t "THP-1_HU_CD11b_High" -c "THP-1_HU_CD11b_Low" -n thp1_cd11b_hu_hilo --control-sgrna 230727_bd246_negative_controls.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t "THP-1_HU_CD14_High" -c "THP-1_HU_CD14_Low" -n thp1_cd14_hu_hilo --control-sgrna 230727_bd246_negative_controls.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t "THP-1_PMA_CD11b_High" -c "THP-1_PMA_CD11b_Low" -n thp1_cd11b_pma_hilo --control-sgrna 230727_bd246_negative_controls.txt"
sbatch -N 1 -n 1 -x c[5-22] --wrap "mageck test -k 230727_bd246_counts_mageck.txt -t "THP-1_PMA_CD14_High" -c "THP-1_PMA_CD14_Low" -n thp1_cd14_pma_hilo --control-sgrna 230727_bd246_negative_controls.txt"

