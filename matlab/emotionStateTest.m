loadEmotion
%%
g=sn.showNNgraph(2);
%%
neutral = sn.getState('neutral');
%%
sn.removeState('neutral');
%%
sn.addState(neutral)
%%
for i = 1:length(emotions)
        sn.removeState([emotions{i},num2str(2)]);
end
%%
anger2 = sn.getState('anger2');
contempt2 = sn.getState('contempt2');
disgust2 = sn.getState('disgust2');
fear2 = sn.getState('fear2');
happy2 = sn.getState('happy2');
sadness2 = sn.getState('sadness2');
surprise2 = sn.getState('surprise2');
%%
sn.mergeState({'anger2','contempt2','disgust2','fear2','happy2','sadness2','surprise2'},'tmp');
sn.removeState('tmp');
%%
sn.addState(anger2);
sn.addState(contempt2);
sn.addState(disgust2);
sn.addState(fear2);
sn.addState(happy2);
sn.addState(sadness2);
sn.addState(surprise2);
%%
sn.renameState('anger1','neutral')
%%

%g=sn.constructRelationGraph();
%%
%happyStates = StateSeq('happy',happy_images,happy_labels,5,10);

%%
%d=happyStates.computeDistances()
%%
%for i = 1:5
    %happyStates.states{i}.showImgHorizontal(5)
%end
%dlmwrite('dist_happy_640_480.csv',d)
hogFeature=cell(0);
for i=1:length(sn.nodeNames)
    for j=1:length(sn.getState(sn.nodeNames{i}).getNumImg())
    img = sn.getState(sn.nodeNames{i}).getImage(j);
    hogFeature{i,j} = extractHOGFeatures(img);
    end
end
%%
imgToShow=cell(1,15);
for i=1:length(sn.nodeNames)
    imgToShow{i}=sn.getState(sn.nodeNames{i}).getImage(1);
end
showImageHorizontal(imgToShow,15)