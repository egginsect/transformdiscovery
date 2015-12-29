from FileLoader import *
import sys
import pdb
labelsDir=FileLoader(sys.argv[1])
imgsDir=FileLoader(sys.argv[2])
#pdb.set_trace()
for path in labelsDir.getRelativeFilePaths():
    print path
for path in imgsDir.getRelativeFilePaths():
    print path
