loadEmotion
%%
Ntrial=10;
accuracy = zeros(Ntrial,1);
testImgs=cell(0);
testEmotionLabels = [];
testStateLabels = cell(0);
for emotionIdx=1:length(emotions)
N=42;
load([imagepath,emotions{emotionIdx}]);
idx=partitionImageSeqs(labels,3);
%idx=sampleImageSeq(labels, 3, Inf);
for i=1:size(idx,2)
    c=ismember(idx{i},usedImgIdx{emotionIdx});
    idx{i}(find(c))=[];
    Imgs = images(idx{i});
    p = randperm(length(Imgs));
    if(i==1)
        N=round(N/length(emotions));
    end
    testImgs = [testImgs,Imgs(p(1:N))];
    if(i==1)
        testStateLabels = [testStateLabels; repmat({'neutral'},N,1)];
    else
    testStateLabels = [testStateLabels; repmat({[emotions{emotionIdx},num2str(i)]},N,1)];
    end
end
clear images
clear labels
end
%%
imgStateHashTable=containers.Map(sn.nodeNames,1:length(unique(testStateLabels)));
imgEmotionHashTable=containers.Map(sn.nodeNames(1:14),reshape([1:length(emotions);1:length(emotions)],1,2*length(emotions)));
imgEmotionHashTable('neutral')=0;
%%
currentHashTable = imgStateHashTable;
%strs=cell(0);
count=0;
    for j=1:length(testImgs)
     str = sn.findRelevantState(testImgs{j}(:));
      if(currentHashTable(str)==currentHashTable(testStateLabels{j}))
        %if(strcmp(str, testStateLabels{j}))
         count=count+1;
     end   
    end
 %end
accuracy=count/length(testImgs)*100
%dlmwrite('accuracy_dist_to_principal_direction.csv',accuracy)
%%
[trainImgs, trainLabels]=sn.getTestImage();
%trainImgs(findStrInCell(trainLabels,'neutral'),:) = [];
%trainLabels(findStrInCell(trainLabels,'neutral')) = [];
%%
model = libsvmtrain(cell2mat(values(currentHashTable, trainLabels)), trainImgs, '-c 1 -g 0.07 -t 3');
%%
svmImgVec=[];
for i=1:length(testImgs)
    svmImgVec(i,:) = double(testImgs{i}(:))';
end
%%
%[predict_label, accuracy_svm, dec_values] = libsvmpredict(cell2mat(values(imgEmotionHashTable,testStateLabels)), svmImgVec, model);
[predict_label, accuracy_svm, dec_values] = libsvmpredict(cell2mat(values(currentHashTable,testStateLabels)), svmImgVec, model);