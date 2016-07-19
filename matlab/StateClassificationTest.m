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
%precision4Save1=zeros(20,8);
%%
confMats = cell(5);
for testRound=1:1
    %numPerson = testRound;
    %LoadStateUnseenObj
    loadArchitectualStyle
    %loadState
     testSVM;
     precision4Save1(testRound,1)=[mean(precision_svm(1,:))];
     confMats{1} = confusionMat;
     testPCA;
     precision4Save1(testRound,2)=[mean(precision)];
     confMats{2} = confusionMat;
     testDL;
     precision4Save1(testRound,3)=[mean(precision)];
     confMats{3} = confusionMat;
     testGFDL;
     precision4Save1(testRound,4)=[mean(precision)];
     confMats{4} = confusionMat;
     %dlmwrite('precision4Save1.csv',precision4Save1);
     %testLCKSVD;
     %precision4Save1(testRound,5)=[mean(precision)];
     %confMats{5} = confusionMat;
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