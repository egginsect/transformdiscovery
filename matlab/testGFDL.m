sn.resetSubspace();
reconstructFunction = @ompSimilarity;
%reconstructFunction = @reconstructionSimilarity;
%%
sn.updateSubspace(@geodesicFlowConstrainedDictionaryUpdate,lambda(testRound));
%%       
[trainImgs, trainLabels]=sn.getTestImage();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
currentClasses = unique(cell2mat(values(currentHashTable,keys(currentHashTable))));
precision_train=zeros(1,length(currentClasses));
precision=zeros(1,length(currentClasses));

for i=1:length(currentClasses)
    count=0;
    currentTestIdx = find(cell2mat(values(currentHashTable,testLabels))==currentClasses(i));
    for j=1:length(currentTestIdx)
        disp(['classifying testing image ', num2str(j), ' of state ', num2str(i)]);
     str = sn.findRelevantState(testImgs(currentTestIdx(j),:)',reconstructFunction);
      if(currentHashTable(str)==currentHashTable(testLabels{currentTestIdx(j)}))
         count=count+1;
      end   
    end
    precision(i)=count/numel(currentTestIdx)*100;
    
    count=0;
    currentTestIdx = find(cell2mat(values(currentHashTable,trainLabels))==currentClasses(i));
    for j=1:length(currentTestIdx)
     disp(['classifying training image ', num2str(j), ' of state ', num2str(i)]);
     str = sn.findRelevantState(trainImgs(currentTestIdx(j),:)',reconstructFunction);
      if(currentHashTable(str)==currentHashTable(trainLabels{currentTestIdx(j)}))
         count=count+1;
      end   
    end
    precision_train(i)=count/numel(currentTestIdx)*100; 
    

%dlmwrite('accuracy_dist_to_principal_direction.csv',accuracy)
%trainImgs(findStrInCell(trainLabels,'neutral'),:) = [];
%trainLabels(findStrInCell(trainLabels,'neutral')) = [];
%svmImgVec=[];
for j=1:numel(currentTestIdx)
    %svmImgVec(j,:) = double(testImgs{currentTestIdx(j)}(:))';
end
%[predict_label, precision_svm(:,i), dec_values] = libsvmpredict(cell2mat(values(currentHashTable,testLabels(currentTestIdx))), svmImgVec, model);

end
disp(['precision ', num2str(mean(precision))]);
disp(['precision_train ', num2str(mean(precision_train))]);