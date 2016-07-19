from FileLoader import *
import sys
import pdb
#labelsDir=FileLoader(sys.argv[1])
imgsDir=FileLoader(sys.argv[1])
#for path in labelsDir.getRelativeFilePaths():
#    print path
imgsDir.filterByExt(sys.argv[2])
for path in imgsDir.getFilePaths():
    print path
