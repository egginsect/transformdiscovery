#!/usr/bin/env python
from FileLoader import *
import sys
import pdb
import numpy as np
imgsDir=FileLoader(sys.argv[1])
imgsDir.filterByExt('.jpg')
with open ('imageFiles.txt','w') as f:
    f.write("\n".join(imgsDir.getFilePaths())) 

label = list()
for path in imgsDir.getFilePaths(): 
    tmp=path.split('/')
    tmp1 = tmp[-1].split('_')
    label.append(tmp1[0]+' '+tmp1[1])

with open ('imageLabels.txt','w') as g:
    g.write("\n".join(label))
