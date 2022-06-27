#!/usr/bin/env python
# coding: utf-8

import os
import sys
import numpy as np
import pandas as pd
from tqdm import tqdm
tqdm.pandas()

file_path = str(sys.argv[1]) #"/home/KX/IPAM-data/TCGA/x"
out_path = str(sys.argv[2]) #"/home/KX/IPAM-GG/TCGA/y"

if file_path != out_path:
	TCGA_data = pd.read_table(os.path.join(file_path),header=0, index_col=None)
	Len=len(TCGA_data)
	scale = TCGA_data.iloc[:, 1:].apply(lambda cols:  1+(Len-1)*(cols-cols.min())/(cols.max()-cols.min()))
	pd.concat([TCGA_data.gene, scale], axis=1).to_csv(os.path.join(out_path), sep='\t', header=True, index=False, encoding='utf-8',float_format="%.6f")
else:
	print("error, do not same input and output")
	exit()
