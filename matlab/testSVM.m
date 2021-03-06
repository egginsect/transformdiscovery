
%precision_train=zeros(1,length(currentClasses));
precision_svm = zeros(3,length(currentClasses));

%testImgs_svm = (testImgs_svm-0.5)*2;
%%
%data=zscore([trainImgs;testImgs]);
%%
%[P, trainImgs_svm] = pcaDimensionReduction(trainImgs,20);
%testImgs_svm = (testImgs-ones(size(testImgs,1),1)*mean(trainImgs))*P;
trainImgs_svm = trainImgs;
testImgs_svm = testImgs;
%%
model = libsvmtrain(cell2mat(values(currentHashTable, trainLabels)), trainImgs_svm, '-g 0.07 -t 0 -c 1');
confusionMat = zeros(length(currentClasses)); 
%%
for i=1:length(currentClasses)
    currentTestIdx = find(cell2mat(values(currentHashTable,testLabels))==currentClasses(i));
    [predict_label, precision_svm(:,i), dec_values] = ...
        libsvmpredict(cell2mat(values(currentHashTable,testLabels(currentTestIdx))), testImgs_svm(currentTestIdx,:), model);
    for j=1:length(currentClasses)
        confusionMat(i,j) = numel(find(predict_label==currentClasses(j)))/length(predict_label);
    end
end
precision_svm_train=zeros(3,length(currentClasses));
for i=1:length(currentClasses)
    currentTestIdx = find(cell2mat(values(currentHashTable,trainLabels))==currentClasses(i));
    [predict_label, precision_svm_train(:,i), dec_values] = ...
        libsvmpredict(cell2mat(values(currentHashTable,trainLabels(currentTestIdx))), trainImgs_svm(currentTestIdx,:), model);
end
mean(precision_svm(1,:),2)
mean(precision_svm_train(1,:),2)