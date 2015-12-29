sourceDirStr='/media/hwlee/Data/dataset/CohnKanade+/cohn-kanade-images/';
targetDirStr='/media/hwlee/Data/dataset/CohnKanade+/cohn-kanade-images_face_cropped/';
sourceDir=subdir(sourceDirStr);
%%
faceDetector = vision.CascadeObjectDetector();
imageLocations={sourceDir.name}';
for i=1:length(imageLocations)
    disp(['Processing image',num2str(i)])
    img = imread(imageLocations{i});
    if(ndims(img)>2)
        img=rgb2gray(img);
    end
    bbox = step(faceDetector, img); 
    crop_img = imcrop(img, [bbox(1), bbox(2), bbox(3), bbox(4)]);
    targetLocation=strrep(imageLocations{i},sourceDirStr,targetDirStr);
    [pathstr,name,ext]=fileparts(targetLocation);
    if(~exist(pathstr,'dir'))
    mkdir(pathstr);
    end
    imwrite(crop_img,targetLocation);
end