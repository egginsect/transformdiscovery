loadEmotionNet
%%
testImgs=cell(0);
testEmotionLabels=[];
Ntrial=10;
accuracy = zeros(Ntrial,length(emotions));
precision = zeros(Ntrial,length(emotions));
recall = zeros(Ntrial,length(emotions));
for trial=1:Ntrial
testImgs=cell(0);
testEmotionLabels=[];
for emotionIdx=1:length(emotions)
N=50;
current_emotion = emotions{emotionIdx};
load([imagepath,current_emotion]);
idx=partitionImageSeqs(labels,5);
c=ismember(idx{end},usedImgIdx{emotionIdx});
idx{end}(find(c))=[];
Imgs = images(idx{end});
p = randperm(length(Imgs));
testImgs = [testImgs,Imgs(p(1:N))];
testEmotionLabels = [testEmotionLabels; emotionIdx*ones(N,1)];
clear images
clear labels
end
%
strs=cell(0);
for emotionIdx=1:7
current_emotion = emotions{emotionIdx};
TpCount=0;
TnCount=0;
pCount=0;
nCount=0;
negativeIdx = find(testEmotionLabels~=emotionIdx);
p=randperm(length(negativeIdx));
NewtestEmotionLabels = [-ones(50,1);ones(50,1)];
NewtestImgs = testImgs([negativeIdx(p(1:50));find(testEmotionLabels==emotionIdx)]);
    for j=1:length(NewtestImgs)
     str = sn.findRelevantState(NewtestImgs{j}(:));
     strs{j,emotionIdx}=str;
     if(findstr(str,current_emotion))
         pCount = pCount+1;
         if(NewtestEmotionLabels(j)==1)
             TpCount=TpCount+1;
         end
     else
         nCount=nCount+1;
         if(NewtestEmotionLabels(j)==-1)
             TnCount=TnCount+1;
         end
     end
     
    end
 %end
accuracy(trial,emotionIdx) =(TpCount+TnCount)/length(NewtestImgs)*100;
precision(trial,emotionIdx) = TpCount/pCount*100;
recall(trial,emotionIdx) = TpCount/N*100;
%dlmwrite('accuracy_dist_to_principal_direction.csv',accuracy)
end
end
dlmwrite('reconstructionSimilarity_no_transient.csv',[mean(accuracy,1);mean(precision,1);mean(recall,1)])