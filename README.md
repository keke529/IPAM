[Pipeline]

IPAM
  - Individualized pathway activity measurement (IPAM) that based on the ranking of gene expression levels in individual sample.

[Article]
  Individualized pathway activity algorithm identifies oncogenic pathways in pan-cancer analysis.

-------------------------------------------------------------------------------------------------------------------------------

[Author]

  Xin Ke, Hao Wu, Yi-Xiao Chen, Yan Guo, Shi Yao, Ming-Rui Guo, Yuan-Yuan Duan, Nai-Ning Wang, Wei Shi, Zhijun Dai, Tie-Lin Yang

-------------------------------------------------------------------------------------------------------------------------------

[Contact]

  kexin520290@163.com
  
  1269880460@qq.com

-------------------------------------------------------------------------------------------------------------------------------

[Update time]

  2021.06

-------------------------------------------------------------------------------------------------------------------------------

[Introduction]

  Individualized pathway activity measurement (IPAM) is a individualized pathway activity measurement tool that based on the ranking of gene expression levels in individual sample. IPAM allows users to calculate pathway activity from individual transcriptome data.


-------------------------------------------------------------------------------------------------------------------------------

[Install]

  - Unzip the IPAM software under any path: "unzip IPAM-main.zip".
  - Enter the IPAM folder: "cd IPAM-main/"
  - Run "sh IPAM.install", and if you change the path of IPAM software, please run "sh IPAM.install" again.
  
-----------------------------------------------------------------------------------------------------------------------------

[USAGE]

  sh IPAM --rank --file data_folder --pathway pathway_folder
  
  sh IPAM --dup_rank --file data_folder --pathway pathway_folder

--rank - If you choose this parameter, IPAM will rank the expression values directly in each sample without consideration of duplication of gene expression.

--dup_rank - If you choose this parameter, IPAM will rank all unique gene expression values and then assign the rank to each gene (recommended).
  
--file data_folder
  - The path of the input data, both absolute and relative path are allowed. All files in the folder will be read automatically. Each file in the folder is a gene expression matrix (genes vs samples). The example data is in IPAM.files/IPAM.test.
  
--pathway pathway_folder
  - The path of the pathway input, all pathways in the folder will be read automatically and calculated in this analysis, each pathway contains the gene symbol list in the pathway, The example data are in IPAM.files/IPAM.KEGG.

  Pathway activity of input data will be calculated and deposited in IPAM.result/


-----------------------------------------------------------------------------------------------------------------------------

[EXAMPLE]

  sh IPAM --rank --file IPAM.files/IPAM.test --pathway IPAM.files/IPAM.KEGG
  
  The gene expression values of each sample in IPAM.test will be ranked directly. The result contain the pathway activity of 318 KEGG pathways for each sample and will be deposited in IPAM.result.


  sh IPAM --dup_rank --file IPAM.files/IPAM.test --pathway IPAM.files/IPAM.KEGG
  
  The unique gene expression values of each sample in IPAM.test will be ranked, and then the rank will be assign to each gene. The result contain the pathway activity of 318 KEGG pathways for each sample and will be deposited in IPAM.result.

  
-----------------------------------------------------------------------------------------------------------------------------
  
  
  NOTE:the KEGG pathways data were download from KEGG database in May, 2019, which contains 318 KEGG pathways.
  In the analysis of IPAM article, we used the TCGA gene expression matrix calculated by UCSC Toil RNAseq Recompute Compendium (https://xenabrowser.net/datapages/?dataset=tcga_RSEM_gene_fpkm&host=https%3A%2F%2Ftoil.xenahubs.net&removeHub=http%3A%2F%2F127.0.0.1%3A7222). The TCGA data can be downloaded at https://toil-xena-hub.s3.us-east-1.amazonaws.com/download/tcga_RSEM_gene_fpkm.gz. In our analysis, to reduce the effect of sequencing, we only focused on protein-coding genes, which were selected according to gencode.v23.annotation.
  We used default parameters for iPAS, Pathifier, PLAGE, IndividPath, and ssGSEA in the manuscript.


===========================================================================
