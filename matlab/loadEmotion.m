clear all
close all
imagepath='/media/hwlee/Data/dataset/CohnKanade+/emotionImgs/';
%%
emotions = {'anger','contempt','disgust','fear','happy','sadness','surprise'}
clc%%
sn = StateNet();
usedImgIdx = cell(1,7);
%cropped_size = [];
for i = 1:length(emotions)
    load([imagepath,emotions{i}]);
    usedImgIdx{i}=sn.addStateSeq(emotions{i}, images, labels, 3, 16);
    %eval(['sn.addStateSeq(''', emotions{i}, ''',', emotions{i},'_images,',emotions{i},'_labels, 3, 15);']);
    %for j=1:length(images)
     %   cropped_size = [cropped_size; size(images{i})];
    %end
    %eval(['clear ', emotions{i}, '_images']);
    %eval(['clear ', emotions{i}, '_labels']);
    clear images;
    clear labels;
end
%%
clear i
sn.mergeState({'anger1','contempt1','disgust1','fear1','happy1','sadness1','surprise1'},'neutral');