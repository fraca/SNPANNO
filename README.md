SNPANNO
==============

Several scripts to annotate the SNPs called with VarScan (Koboldt et al. 2012) on the new annotation of *Arabidopsis lyrata* (Rawat et al. 2015).

Software used:

- AWK (Aho et al. 1977)
- Snpdat (Doran et al. 2013)


This pipeline is designed to run on high-performance computing cluster with qsub command.  



##SNPANNO_create_gff.sh   
It split the annotation gff file in scaffolds and convert them for Snpdat.  


##SNPANNO_ini.sh   
It prepare the input files for Snpdat and run it. It call the **SNPANNO_anno.sh**. It create a file for each population and scaffold. Column of output file:

- position in the scaffold
- number of reference reads
- number of variant reads
- frequency of variant allele
- reference allele
- variant allele
- gene name
- transcript name
- codon (only for CDS)
- protein (only for CDS)
- synonymus (Y) non-synonymus (N)  (only for CDS)


##SNPANNO_sel_tri.sh  
It filter the files take only the biallelic SNPs in CDS, the first transcript of each gene.
