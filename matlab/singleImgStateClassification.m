loadEmotionNet
%%
Ntrial=10;
accuracy = zeros(Ntrial,1);
testImgs=cell(0);
testEmotionLabels = [];
testStateLabels = cell(0);
for emotionIdx=1:length(emotions)
N=40;
load([imagepath,emotions{emotionIdx}]);
idx=partitionImageSeqs(labels,3);
%idx=sampleImageSeq(labels, 3, Inf);
for i=2:size(idx,2)
    c=ismember(idx{i},usedImgIdx{emotionIdx});
    idx{i}(find(c))=[];
    Imgs = images(idx{i});
    p = randperm(length(Imgs));
    testImgs = [testImgs,Imgs(p(1:N))];
    testStateLabels = [testStateLabels; repmat({[emotions{emotionIdx},num2str(i)]},N,1)];
    testEmotionLabels = [testEmotionLabels; emotionIdx*ones(N,1)];
end
clear images
clear labels
end
%
%%
%strs=cell(0);
count=0;
    for j=1:length(testImgs)
     str = sn.findRelevantState(testImgs{j}(:));
      if(findstr(str,emotions{testEmotionLabels(j)}))
        %if(strcmp(str, testEmotionLabels{j}))
         count=count+1;
     end   
    end
 %end
accuracy(trial)=count/length(testImgs)*100
%dlmwrite('accuracy_dist_to_principal_direction.csv',accuracy)

%%
imgStateHashTable=containers.Map(unique(testEmotionLabels),1:length(unique(testEmotionLabels)));
%%
trainImgs(findStrInCell(trainLabels,'neutral'),:) = [];
%%
trainLabels(findStrInCell(trainLabels,'neutral')) = [];
%%
model = libsvmtrain(cell2mat(values(imgLabelHashTable, trainLabels)), trainImgs, '-c 1 -g 0.07 -t 3');
%%
svmImgVec=[];
for i=1:length(testImgs)
    svmImgVec(i,:) = double(testImgs{i}(:))';
end
%%
[predict_label, accuracy_svm, dec_values] = libsvmpredict(cell2mat(values(imgLabelHashTable,testEmotionLabels)), svmImgVec, model);