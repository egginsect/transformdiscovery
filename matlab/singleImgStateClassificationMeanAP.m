loadEmotion
%%
imgStateHashTable=containers.Map(sn.nodeNames,1:length(sn.nodeNames));
%imgEmotionHashTable=containers.Map(sn.nodeNames(1:14),reshape([1:length(emotions);1:length(emotions)],1,2*length(emotions)));
imgEmotionHashTable=containers.Map(sn.nodeNames(1:7),1:length(emotions));
%imgEmotionHashTable('neutral')=0;
%%
testImgs=cell(0);
testStateLabels = cell(0);
for emotionIdx=1:length(emotions)
load([imagepath,emotions{emotionIdx}]);
idx=partitionImageSeqs(labels,2);
idx=sampleImageSeq(labels, 2);
idx = mat2cell(idx,size(idx,1),[1,1]);
for j=2:size(idx,2)
    c=ismember(idx{j},usedImgIdx{emotionIdx});
    idx{j}(find(c))=[];
    Imgs = images(idx{j});
    testImgs = [testImgs,Imgs];
    if(j==1)
        testStateLabels = [testStateLabels; repmat({'neutral'},length(Imgs),1)];
    else
    testStateLabels = [testStateLabels; repmat({[emotions{emotionIdx},num2str(j)]},length(Imgs),1)];
    end
end
clear images
clear labels
end
%%
currentHashTable = imgEmotionHashTable;
[trainImgs, trainLabels]=sn.getTestImage();
model = libsvmtrain(cell2mat(values(currentHashTable, trainLabels)), trainImgs, '-c 1 -g 0.07 -t 3');
%%
currentClasses = unique(cell2mat(values(currentHashTable,keys(currentHashTable))));

precision=zeros(1,length(currentClasses));
precision_svm=zeros(3,length(currentClasses));

for i=1:length(currentClasses)
    count=0;
    
    currentTestIdx = find(cell2mat(values(currentHashTable,testStateLabels))==currentClasses(i));
    
    for j=1:length(currentTestIdx)
     str = sn.findRelevantState(testImgs{currentTestIdx(j)}(:));
      if(currentHashTable(str)==currentHashTable(testStateLabels{currentTestIdx(j)}))
        %if(strcmp(str, testStateLabels{j}))
         count=count+1;
      end   
    end
 %end
precision(i)=count/length(currentTestIdx)*100;
%dlmwrite('accuracy_dist_to_principal_direction.csv',accuracy)


%trainImgs(findStrInCell(trainLabels,'neutral'),:) = [];
%trainLabels(findStrInCell(trainLabels,'neutral')) = [];
svmImgVec=[];
for j=1:length(currentTestIdx)
    svmImgVec(j,:) = double(testImgs{currentTestIdx(j)}(:))';
end
%[predict_label, accuracy_svm, dec_values] = libsvmpredict(cell2mat(values(imgEmotionHashTable,testStateLabels)), svmImgVec, model);
[predict_label, precision_svm(:,i), dec_values] = libsvmpredict(cell2mat(values(currentHashTable,testStateLabels(currentTestIdx))), svmImgVec, model);
end