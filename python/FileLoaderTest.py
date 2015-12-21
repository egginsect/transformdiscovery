from FileLoader import *
import sys
import pdb
labelsDir=FileLoader(sys.argv[1])
for path in labelsDir.getRelativePaths():
    print path

