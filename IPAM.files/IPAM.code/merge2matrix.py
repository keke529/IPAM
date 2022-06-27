#!/usr/bin/env python
# coding: utf-8

import os
import sys
import numpy as np
import pandas as pd


TCGA_path = str(sys.argv[1]) #"/home/KX/TCGA-UCSC/cal/READ"
out_path = str(sys.argv[2]) 

#print(os.listdir(TCGA_path)[0])
out_file = pd.read_table(os.path.join(TCGA_path, os.listdir(TCGA_path)[0]),
    header=0, index_col=None)
for file in os.listdir(TCGA_path)[1:]:
    #print(file)
    TCGA_data = pd.read_table(os.path.join(TCGA_path, file),header=0, index_col=None)
    out_file = pd.concat([out_file,TCGA_data.iloc[:,1:]],axis=1)  

out_file.to_csv(os.path.join(out_path), sep='\t', header=True, index=False, encoding='utf-8',float_format="%.6f")

 
