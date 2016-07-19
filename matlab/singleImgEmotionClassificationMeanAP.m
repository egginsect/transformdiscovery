%%
% tic
% meanAp=zeros(16);
% lambda1=1:linspace(1,100,4);
% lambda2=1:linspace(1,100,4);
% for i=1:4
%     for j=1:4

%         sn.updateSubspace(@geodesicFlowConstrainedDictionaryUpdate,lambda1(i),lambda2(j));
%         testScript
%         meanAp(i,j) = mean(precision);
%         save meanAp.mat meanAp
%     end
% end
% toc
%model = libsvmtrain(cell2mat(values(currentHashTable, trainLabels)), trainImgs, '-c 1 -g 0.07 -t 3');
%sn.updateSubspace(@geodesicFlowConstrainedDictionaryUpdate,30,50);
%testScript
precision4Save=zeros(15,8);
%%
for testRound=1:1
    %numPerson = testRound;
    loadEmotion
    imgStateHashTable=containers.Map(sn.nodeNames,1:length(sn.nodeNames));
    currentHashTable = imgStateHashTable;
    sampleTestIMage
    [trainImgs, trainLabels]=sn.getTestImage();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
    currentClasses = unique(cell2mat(values(currentHashTable,keys(currentHashTable))));
    %%
     testSVM;
     precision4Save(testRound,1:2)=[mean(precision_svm(1,:)),mean(precision_svm_train(1,:))];
     testPCA;
     precision4Save(testRound,3:4)=[mean(precision), mean(precision_train)];
     testDL;
     precision4Save(testRound,5:6)=[mean(precision), mean(precision_train)];
     testGFDL;
     precision4Save(testRound,7:8)=[mean(precision), mean(precision_train)];
     %dlmwrite('precision4Save.csv',precision4Save);
  end
%%
% tt_dat=zeros(length(testImgs),prod(size(testImgs{1})));
% for j=1:length(testLabels)
%     tt_dat(j,:) = double(testImgs{j}(:))';
% end
% ttls=cell2mat(values(currentHashTable,testLabels));
% save('testSampled3.mat', 'tt_dat', 'ttls');
% %%
% tr_dat=trainImgs;
% trls=cell2mat(values(currentHashTable,trainLabels));
% save('train3.mat', 'tr_dat', 'trls');