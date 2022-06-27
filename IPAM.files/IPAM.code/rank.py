import math
import sys
f1=open(sys.argv[1])
f2=open(sys.argv[2],'w')
gene=[]
for line in f1.readlines()[1:]:
	lines=line.strip().split("\t")
	gene.append(float(lines[1]))
f1.seek(0)
gene_uniq=[]
for i in gene:
	if not i in gene_uniq:
		gene_uniq.append(i)
K=float(len(gene))/float(len(gene_uniq))
sort=sorted(gene_uniq)
assign=enumerate(sort)
d=dict((y, x) for x, y in assign)
title=f1.readline()
f1.seek(0)
f2.write(title)
for line in f1.readlines()[1:]:
	lines=line.strip().split("\t")
	f2.write(lines[0]+"\t"+str(math.floor(float(d.get(float(lines[1]),lines[1]))/10)*10+1)+"\n")
f1.close()
f2.close()
