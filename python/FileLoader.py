import os
class FileLoader(object):
    def __init__(self, directory):
        self.root = directory
        self.filePaths = self.parseFolder(directory) 

    def parseFolder(self, directory):
        file_paths = []
        for root, directories, files in os.walk(directory):
            for filename in files:
					# Join the two strings in order to form the full filepath.
                filepath = os.path.join(root, filename)
                file_paths.append(filepath)  # Add it to the list.
        return file_paths
    def getRelativePaths(self):
        relativePath=[]
        for path in self.filePaths:
            relativePath.append(os.path.relpath(path,self.root))
        return relativePath 
