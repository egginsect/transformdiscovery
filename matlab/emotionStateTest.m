clear all
close all
addpath(genpath('/media/hwlee/Data/dataset/CohnKanade+/emotionImages'));
%%
emotions = {'anger','contempt','disgust','fear','happy','sadness','surprise'}
%%
sn = StateNet();
for i = 1:length(emotions)
    load(emotions{i})
    eval(['sn.addStateSeq(''', emotions{i}, ''',', emotions{i},'_images,',emotions{i},'_labels, 3, 10);']);
    eval(['clear ', emotions{i}, '_images']);
    eval(['clear ', emotions{i}, '_labels']);
end
%%
sn.computeMutualDist()
%%
g=sn.constructNNgraph(6);
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