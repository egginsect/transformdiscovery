clear all
close all
imagepath='/media/hwlee/Data/dataset/CohnKanade+/emotionImages/';
%%
emotions = {'anger','contempt','disgust','fear','happy','sadness','surprise'};
%%
usedImgIdx = cell(1,7);
sn = StateNet();
for i = 1:length(emotions)
    load([imagepath,emotions{i}])
    eval(['usedImgIdx{i}=sn.addStateSeq(''', emotions{i}, ''',', emotions{i},'_images,',emotions{i},'_labels, 3, 10);']);
    eval(['clear ', emotions{i}, '_images']);
    eval(['clear ', emotions{i}, '_labels']);
end
%%
%sn.computeMutualDist()
%g=sn.showNNgraph(3);
%%
sn.mergeState({'anger1','contempt1','disgust1','fear1','happy1','sadness1','surprise1'},'Neutral');