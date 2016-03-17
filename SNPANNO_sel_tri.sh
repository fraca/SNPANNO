#! /bin/bash

###############################################################################

##INPUT

# select only SNP in CDS, trascript 1 and only biallelic.


scaf_num=(scaffold_1 scaffold_2 scaffold_3 scaffold_4 scaffold_5 scaffold_6 scaffold_7 scaffold_8)



fold_pops=(07C 07D 07E 07F 07G 07J 07K 07L 07M 07N 07O 07P 07Q 07R 11C 11AA 11AB 11AC 11AE 11AG 11AH 11AJ 11B 11G 11H 11J 11K 11L_F0 11L_F1 11M 11N 11O 11P 11Q 11S 11T 11U 11W 11X 11Z 11D 11V 11R 11A 11E 11F 11Y 14A 14B 14C 14D 14E 07H 13ARE Ha21 Ha31)



#fold_pops=(07C 07D)

folder="/home/marco/pool_first/snp_anno"
type="ly_cds"

j=0
len_pop=${#fold_pops[*]}
while [ $j -lt $len_pop ]; do

  #############################################################################
  
  
  mkdir "p"${fold_pops[$j]}"_"$type
  
  i=0
  len=${#scaf_num[*]}
  while [ $i -lt $len ]; do
    grep CDS $folder"/p"${fold_pops[$j]}"_all/"${scaf_num[$i]} | grep t1 | awk '!seen[$1]++ {cont[i++]=$1; lines[j++]=$0} END {for (i in cont) if (seen[cont[i]]==1) print lines[i]}' | sort -n > "p"${fold_pops[$j]}"_"$type"/"${scaf_num[$i]}
    
  let i++
  done
  
let j++
done



