#! /bin/bash

##all features

mkdir file_gff

scaf_num=(scaffold_1 scaffold_2 scaffold_3 scaffold_4 scaffold_5 scaffold_6 scaffold_7 scaffold_8)


i=0
len=${#scaf_num[*]}
while [ $i -lt $len ]; do
  echo $i
  awk -v scaf=${scaf_num[$i]} ' BEGIN { FS = "\t" } ; NR>14 {if($3!="miRNA" && $3!="transcript" && $1==scaf) {print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8}}' /home/marco/pool_first/Araly1_Genome/version2/Additional_file-2_10Feb2015.gff > All_fea1
  
  awk -v scaf=${scaf_num[$i]} 'BEGIN { FS = "\t" } ; NR>14 {if($1==scaf) {if($3!="miRNA" && $3!="transcript" && $3!="gene" && $3!="miRNA_gene" && $3!="tRNA_gene") {print $3";"$9}; if($3=="gene" || $3=="miRNA_gene" || $3=="tRNA_gene") {gsub("ID=", "gene_id \"") sub(";", "\"; "); print $3";"$9 } }}' /home/marco/pool_first/Araly1_Genome/version2/Additional_file-2_10Feb2015.gff | awk 'BEGIN { FS = ";" } ; {if($1!="gene" && $1!="miRNA_gene" && $1!="tRNA_gene") {gsub("Parent=", "gene_id \"") gsub("ID=", "transcript_id \""); print $3"\"; "$2"\""} else {print $2"; "$4}}' > All_fea2  
  
  awk -v scaf=${scaf_num[$i]} 'BEGIN { FS = "\t" } ; {if($1==scaf) {if($3=="CDS") {print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8}}}' /home/marco/pool_first/Araly1_Genome/version2/Additional_file-2_10Feb2015.gff > All_tp1
  
  awk -v scaf=${scaf_num[$i]} 'BEGIN { FS = "\t" } ; {if($1==scaf) {if($3=="CDS") {print $9}}}' /home/marco/pool_first/Araly1_Genome/version2/Additional_file-2_10Feb2015.gff | awk 'BEGIN { FS = ";" } ; gsub("Parent=", "gene_id \"") gsub("ID=", "transcript_id \"")  {print $2"\"; "$1"\""}' > All_tp2
  
  let i++
  
  paste All_fea1 All_fea2 > "file_gff/Alyr_allfeat_s"$i".gff"
  rm All_fea1
  rm All_fea2
  
  paste All_tp1 All_tp2 > "file_gff/Alyr_CDS_s"$i".gff"
  rm All_tp1
  rm All_tp2


  
done

##only cds









