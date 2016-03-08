import os
class FileLoader(object):
    def __init__(self, directory):
        self.root = directory
        self.filePaths = self.parseFolder(directory) 
        self.labels = []

    def parseFolder(self, directory):
        file_paths = []
        for root, directories, files in os.walk(directory):
            for filename in files:
					# Join the two strings in order to form the full filepath.
                filepath = os.path.join(root, filename)
                file_paths.append(filepath)  # Add it to the list.
        return file_paths

    def getFilePaths(self):
        return self.filePaths

    def getRelativeFilePaths(self):
        relativePath=[]
        for path in self.filePaths:
            relativePath.append(os.path.relpath(path,self.root))
        return relativePath 

    def getRelativeParentFolderPaths(self):
        relParentFolderPath = []
        for path in self.filePaths:
            relParentFolderPath.append(os.path.relpath(os.path.split(path)[0],self.root))
        return relParentFolderPath

    def loadAllFiles(self):
        content = []
        for path in self.filePaths:
            lines = [line.rstrip('\n') for line in open(path)] 
            content.append(lines)
        return content

    def setLabel(self,labels):
        if(len(labels) != len(self.filePaths)):
            raise ValueError('Length of label and file mismatch') 
        else:
            self.labels.append(labels)

    def removeFile(self,idx):
        del self.filePaths[idx]

    def filterByExt(self,ext):
        self.filePaths = [path for path in self.filePaths if path.endswith(ext)]
