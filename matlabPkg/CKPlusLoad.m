clear all
close all
labelDirStr='/media/hwlee/Data/dataset/CohnKanade+/Emotion/';
imageDirStr='/media/hwlee/Data/dataset/CohnKanade+/cohn-kanade-images_face_cropped/';
labelDir=subdir(labelDirStr);
imageDir=subdir(imageDirStr);
%%
%Construct Label Dictionary
labelDict = containers.Map();
for i=1:numel(labelDir)
    [pathstr,name,ext]=fileparts(labelDir(i).name);
    fid = fopen(labelDir(i).name,'rt');
    a = fscanf(fid,'%e');
    fclose(fid);
    labelDict(strrep(pathstr,labelDirStr,''))=a;
end
personDict=containers.Map(keys(labelDict),1:length(keys(labelDict)));
%%
count=1;
for i=1:numel(imageDir)
    [pathstr,name,ext]=fileparts(imageDir(i).name);
    relpathstr=strrep(pathstr,imageDirStr,'');
    if(isKey(labelDict,relpathstr))
        dataSet(count).imagePath=imageDir(i).name;
        dataSet(count).personIdx=personDict(relpathstr);
        dataSet(count).stateIdx=labelDict(relpathstr);
        count=count+1;
    end  
end
save('ckPlusFaceCropped.mat','dataSet');