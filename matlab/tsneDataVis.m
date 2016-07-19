label = cell2mat(values(currentHashTable,testLabels));
yData=tsne(testImgs,label,3);