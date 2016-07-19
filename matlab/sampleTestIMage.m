testImgs=cell(0);
testLabels = cell(0);
for emotionIdx=1:length(emotions)
load([imagepath,emotions{emotionIdx}]);
%idx=partitionImageSeqs(labels,3);
%idx=sampleImageSeq(labels, 3, 4, Inf);
%idx=sampleImageSeq(labels, 3, 4, Inf,usedImgIdx{emotionIdx});
idx=sampleImageSeq(labels, 3, 4, Inf);
%idx=cell(1,size(idxtmp,2));
%  for i=1:size(idxtmp,2)
%      idx{i} = cell2mat(idxtmp(:,i));
%  end
for j=1:size(idx,2)
    c=ismember(idx{j},usedImgIdx{emotionIdx});
    idx{j}(find(c))=[];
    Imgs = images(idx{j});
    for i=1:length(Imgs)
        Imgs{i} = imresize(Imgs{i},[30,30]);
    end
    testImgs = [testImgs,Imgs];
    if(j==1)
        testLabels = [testLabels; repmat({'neutral'},length(Imgs),1)];
    else
    testLabels = [testLabels; repmat({[emotions{emotionIdx},num2str(j)]},length(Imgs),1)];
    end
end

clear images
clear labels
end
tmp=zeros(length(testImgs),prod(size(testImgs{1})));
%tmp=zeros(length(testImgs), 3776);
for i=1:length(testImgs)
    tmp(i,:)=testImgs{i}(:)';
    %tmp(i,:)=extractLBPFeatures(testImgs{i},'CellSize',[35,35]);
end
testImgs=tmp;
clear tmp
%testImgs = zscore(testImgs);
%testImgs = normalize2Norm(testImgs);