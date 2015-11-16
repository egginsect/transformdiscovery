clear all
close all
imagepath='/media/hwlee/Data/dataset/CohnKanade+/emotionImages/';
%%
emotions = {'anger','contempt','disgust','fear','happy','sadness','surprise'}
%%
sn = StateNet();
for i = 1:length(emotions)
    load([imagepath,emotions{i}])
    eval(['sn.addStateSeq(''', emotions{i}, ''',', emotions{i},'_images,',emotions{i},'_labels, 3, 10);']);
    eval(['clear ', emotions{i}, '_images']);
    eval(['clear ', emotions{i}, '_labels']);
end
%%
%sn.computeMutualDist()
%g=sn.showNNgraph(3);
%%
sn.mergeState({'anger1','contempt1','disgust1','fear1','happy1','sadness1','surprise1'},'Neutral');
%%
g=sn.showNNgraph(2);
%%
for i = 1:length(emotions)
    if i~=1
        sn.removeState([emotions{i},num2str(1)]);
    end
end
%%
anger1 = sn.getState('anger1');
contempt1 = sn.getState('contempt1');
disgust1 = sn.getState('disgust1');
fear1 = sn.getState('fear1');
happy1 = sn.getState('happy1');
sadness1 = sn.getState('sadness1');
surprise1 = sn.getState('surprise1');
%%
sn.addState(anger1);
sn.addState(contempt1);
sn.addState(disgust1);
sn.addState(fear1);
sn.addState(happy1);
sn.addState(sadness1);
sn.addState(surprise1);
%%
sn2.addState(anger1);
sn2.addState(contempt1);
sn2.addState(disgust1);
sn2.addState(fear1);
sn2.addState(happy1);
sn2.addState(sadness1);
sn2.addState(surprise1);
sn2.addState(sn.getState('Neutral'));
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