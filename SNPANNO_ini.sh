#! /bin/bash

###############################################################################

##INPUT

bin_dir="/scicore/home/williy/fracasse/pipe_bin/"
n_threads=1


scaf_num=(scaffold_1 scaffold_2 scaffold_3 scaffold_4 scaffold_5 scaffold_6 scaffold_7 scaffold_8)



fasta_ly=(/scicore/home/williy/fracasse/Genome/lyr_th_scaf/scaffold_1.fa /scicore/home/williy/fracasse/Genome/lyr_th_scaf/scaffold_2.fa /scicore/home/williy/fracasse/Genome/lyr_th_scaf/scaffold_3.fa /scicore/home/williy/fracasse/Genome/lyr_th_scaf/scaffold_4.fa /scicore/home/williy/fracasse/Genome/lyr_th_scaf/scaffold_5.fa /scicore/home/williy/fracasse/Genome/lyr_th_scaf/scaffold_6.fa /scicore/home/williy/fracasse/Genome/lyr_th_scaf/scaffold_7.fa /scicore/home/williy/fracasse/Genome/lyr_th_scaf/scaffold_8.fa)

gff_all=(/scicore/home/williy/fracasse/Genome/file_gff/Alyr_allfeat_s1.gff /scicore/home/williy/fracasse/Genome/file_gff/Alyr_allfeat_s2.gff /scicore/home/williy/fracasse/Genome/file_gff/Alyr_allfeat_s3.gff /scicore/home/williy/fracasse/Genome/file_gff/Alyr_allfeat_s4.gff /scicore/home/williy/fracasse/Genome/file_gff/Alyr_allfeat_s5.gff /scicore/home/williy/fracasse/Genome/file_gff/Alyr_allfeat_s6.gff /scicore/home/williy/fracasse/Genome/file_gff/Alyr_allfeat_s7.gff /scicore/home/williy/fracasse/Genome/file_gff/Alyr_allfeat_s8.gff)



#fold_pops=(07C 07D 07E 07F 07G 07J 07K 07L 07M 07N 07O 07P 07Q 07R 11C 11AA 11AB 11AC 11AE 11AG 11AH 11AJ 11B 11G 11H 11J 11K 11L_F0 11L_F1 11M 11N 11O 11P 11Q 11S 11T 11U 11W 11X 11Z 11D 11V 11R 11A 11E 11F 11Y 14A 14B 14C 14D 14E 07H 13ARE Ha21 Ha31)



fold_pops=(07C 07D 07E 07F 07G 11L_F1 11M 11N 11O 11P Ha21 Ha31)

folder="/scicore/home/williy/fracasse/snp_tot/"


j=0
len_pop=${#fold_pops[*]}
while [ $j -lt $len_pop ]; do

  #############################################################################
  
  mkdir "p"${fold_pops[$j]}"_all"
  
  
  i=0
  len=${#scaf_num[*]}
  while [ $i -lt $len ]; do
    qsub -v nome_out="p"${fold_pops[$j]}"_all/"${scaf_num[$i]},bin_dir=$bin_dir,varscan=$folder"p"${fold_pops[$j]}"_tot_SNP_scaf/"${scaf_num[$i]}".varscan",fasta=${fasta_ly[$i]},gff=${gff_all[$i]} -pe smp $n_threads -o "p"${fold_pops[$j]}"_"$i"_all.out" -N  "p"${fold_pops[$j]}"_"$i"_all" -q long.q SNPANNO_anno.sh

    
  let i++
  done
  
let j++
done



