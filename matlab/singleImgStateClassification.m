loadEmotionNet
%%
testImgs=cell(0);
testEmotionLabels=[];
for emotionIdx=1:length(emotions)
N=50;
current_emotion = emotions{emotionIdx}
load([imagepath,current_emotion]);
idx=partitionImageSeqs(labels,3);
c=ismember(idx{end},usedImgIdx{emotionIdx});
idx{end}(find(c))=[];
Imgs = images(idx{end});
p = randperm(length(Imgs));
testImgs = [testImgs,Imgs(p(1:N))];
testEmotionLabels = [testEmotionLabels; emotionIdx*ones(N,1)];
clear images
clear labels
end
%%
for emotionIdx=1:7
%for emotionIdx=1:length(emotions)
count=0;
pcount=0;
    for j=1:length(testImgs)
     str = sn.findRelevantState(Imgs{j}(:));
     if(findstr(str,current_emotion))
         if(testEmotionLabels(j)==emotionIdx)
             count=count+1;
             pcount=pcount+1;
         end
     else
         if(testEmotionLabels(j)~=emotionIdx)
             count=count+1;
         end
     end
    end
 %end
accuracy(emotionIdx) =count/length(testImgs)*100;
precision(emotionIdx) =pcount/N*100;
end
%%