#! /bin/bash

# Request "/bin/bash" as shell
#$ -S /bin/bash

# Start the job from the current working directory
#$ -cwd

# Merge standard output and standard error
#$ -j y


###############################################################################


# to load gsl library fro NPStat


#non lasciare spazio
nome2=$TMPDIR"/ciao"


##auto remove of file in TEMPDIR

awk '{if($5=="Y") {if($4=="C") {print $1"\t"$2"\tT"} else {print $1"\t"$2"\tC"}} else if($5=="R") {if($4=="G") {print $1"\t"$2"\tA"} else {print $1"\t"$2"\tG"}} else if($5=="W") {if($4=="A") {print $1"\t"$2"\tT"} else {print $1"\t"$2"\tA"}} else if($5=="S") {if($4=="C") {print $1"\t"$2"\tG"} else {print $1"\t"$2"\tC"}} else if($5=="K") {if($4=="G") {print $1"\t"$2"\tT"} else {print $1"\t"$2"\tG"}} else if($5=="M") {if($4=="C") {print $1"\t"$2"\tA"} else {print $1"\t"$2"\tC"}} else {print $1"\t"$2"\t"$5}}' $varscan > $nome2".snpdat"

perl $bin_dir"SNPdat_v1.0.5.pl" -i $nome2".snpdat" -f $fasta -g $gff -s $nome2"_sum" -o $nome2"_out"


awk '{if($5=="Y") {if($4=="C") {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\tT"} else {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\tC"}} else if($5=="R") {if($4=="G") {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\tA"} else {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\tG"}} else if($5=="W") {if($4=="A") {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\tT"} else {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\tA"}} else if($5=="S") {if($4=="C") {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\tG"} else {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\tC"}} else if($5=="K") {if($4=="G") {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\tT"} else {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\tG"}} else if($5=="M") {if($4=="C") {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\tA"} else {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\tC"}} else {print $2"\t"$6"\t"$7"\t"$8"\t"$4"\t"$5}}' $varscan | sort -n > $nome2"_freq"

awk '{if($3=="Y") {if($6=="CDS") {print $2"\t"$6"\t"$11"\t"$13"\t"$16"\t"$20"\t"$21"\t"$22} else {print $2"\t"$6"\t"$11"\t"$13"\t"$16"\tNA\tNA\tNA"}} else {print $2"\tintergenic\tNA\tNA\tNA\tNA\tNA\tNA"}}' $nome2"_out" | sed 1d | sort | uniq | sort -n > $nome2"_anno"

join  $nome2"_freq" $nome2"_anno" | awk '{if($7=="CDS") {if($10=="-") {if($6=="A") {due="T"} else if($6=="T") {due="A"} else if($6=="C") {due="G"} else if($6=="G") {due="C"}} else {due=$6}; tre=$11; gsub("[A-Z?]*\\[[A-Z?]/","",tre); gsub("\\][A-Z?]*","",tre); if(due==tre) {print $0}} else {print $0}}' > $nome_out

echo "Fine"
