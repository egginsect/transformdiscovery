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
    label.append(tmp[-2])

with open ('imageLabels.txt','w') as f:
    f.write("\n".join(label))
