from FileLoader import *
import sys
import pdb
import numpy as np
labelsDir=FileLoader('/media/hwlee/Data/dataset/CohnKanade+/Emotion')
imgsDir=FileLoader('/media/hwlee/Data/dataset/CohnKanade+/cohn-kanade-images')
content = labelsDir.loadAllFiles()
Emotionlabels=[]
for num in content:
    Emotionlabels.append(int(float(num[0])))
Emotions4imgsTable=dict(zip(labelsDir.getRelativeParentFolderPaths(),Emotionlabels))
labels = []
count=0
for path in imgsDir.getRelativeParentFolderPaths():
   try: 
       labels.append(Emotions4imgsTable[path]) 
       count=count+1
   except:
       imgsDir.removeFile(count)
imgsDir.setLabel(labels)
pdb.set_trace()
