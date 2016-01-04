loadEmotion
%%
imgStateHashTable=containers.Map(sn.nodeNames,1:length(sn.nodeNames));
%imgEmotionHashTable=containers.Map(sn.nodeNames(1:7),1:length(emotions));
%imgEmotionHashTable('neutral')=15;
%%
testImgs=cell(0);
testStateLabels = cell(0);
for emotionIdx=1:length(emotions)
load([imagepath,emotions{emotionIdx}]);
idx=partitionImageSeqs(labels,3);
%idx=sampleImageSeq(labels, 3);
%idx = mat2cell(idx,size(idx,1),[1,1,1]);
for j=1:size(idx,2)
    
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
currentHashTable = imgStateHashTable;
%%
[trainImgs, trainLabels]=sn.getTestImage();
%model = libsvmtrain(cell2mat(values(currentHashTable, trainLabels)), trainImgs, '-c 1 -g 0.07 -t 3');
%%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
currentClasses = unique(cell2mat(values(currentHashTable,keys(currentHashTable))));
precision_train=zeros(1,length(currentClasses));
precision=zeros(1,length(currentClasses));
%precision_svm=zeros(3,length(currentClasses));

for i=1:length(currentClasses)
    count=0;
    currentTestIdx = find(cell2mat(values(currentHashTable,trainLabels))==currentClasses(i));
    for j=1:length(currentTestIdx)
     str = sn.findRelevantState(trainImgs(currentTestIdx(j),:)');
      if(currentHashTable(str)==currentHashTable(trainLabels{currentTestIdx(j)}))
         count=count+1;
      end   
    end
    precision_train(i)=count/length(currentTestIdx)*100;
    
    count=0;
    currentTestIdx = find(cell2mat(values(currentHashTable,testStateLabels))==currentClasses(i));
    for j=1:length(currentTestIdx)
     str = sn.findRelevantState(testImgs{currentTestIdx(j)}(:));
      if(currentHashTable(str)==currentHashTable(testStateLabels{currentTestIdx(j)}))
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
    %svmImgVec(j,:) = double(testImgs{currentTestIdx(j)}(:))';
end
%[predict_label, precision_svm(:,i), dec_values] = libsvmpredict(cell2mat(values(currentHashTable,testStateLabels(currentTestIdx))), svmImgVec, model);

end
%%
% tt_dat=zeros(length(testImgs),prod(size(testImgs{1})));
% for j=1:length(testStateLabels)
%     tt_dat(j,:) = double(testImgs{j}(:))';
% end
% ttls=cell2mat(values(currentHashTable,testStateLabels));
% save('testSampled3.mat', 'tt_dat', 'ttls');
% %%
% tr_dat=trainImgs;
% trls=cell2mat(values(currentHashTable,trainLabels));
% save('train3.mat', 'tr_dat', 'trls');