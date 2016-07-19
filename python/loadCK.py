#!/usr/bin/env python
from FileLoader import *
import sys
import pdb
import numpy as np
emotions=dict({0:'neutral', 1:'anger', 2:'contempt', 3:'disgust', 4:'fear', 5:'happy', 6:'sadness', 7:'surprise'})
labelsDir=FileLoader('/media/hwlee/DATA/dataset/CohnKanade+/Emotion')
imgsDir=FileLoader('/media/hwlee/DATA/dataset/CohnKanade+/cohn-kanade-images')
content = labelsDir.loadAllFiles()
Emotionlabels=[]
for num in content:
    Emotionlabels.append(int(float(num[0])))
Emotions4imgsTable=dict(zip(labelsDir.getRelativeParentFolderPaths(),Emotionlabels))
personLabel = [lab.split('/')[0] for lab in labelsDir.getRelativeParentFolderPaths()]
labels = []
count=0
for path in imgsDir.getRelativeParentFolderPaths():
   try: 
       print path
       labels.append(emotions[Emotions4imgsTable[path]]+' '+path.split('/')[0])

       count=count+1
   except:
       imgsDir.removeFile(count)
imgsDir.setLabel(labels)
#pdb.set_trace()

with open ('imageFiles.txt','w') as f:
    f.write("\n".join(imgsDir.getFilePaths()))

with open ('imageLabels.txt','w') as g:
    g.write("\n".join(labels))