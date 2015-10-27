classdef State < handle
    
properties
    stateName;
    stateLevel;
    images;
    subspace;
end

methods    
    function stateObj = State(images, stateName, stateLevel, subspaceDimension)
        stateObj.stateName = stateName;
        stateObj.stateLevel = stateLevel;
        stateObj.images = images;
        stateObj.subspace = stateObj.generateSubspace(stateObj.images,subspaceDimension);
    end
    
    function showImgHorizontal(obj,maxPhoto)
        if maxPhoto>length(obj.images)
           maxPhoto = length(obj.images)
        end
        [colDim, rowDim] = size(obj.images{1});
        alignedImg = zeros(colDim,rowDim*maxPhoto);
        for i=1:maxPhoto
            alignedImg(:,(i-1)*rowDim+1:i*rowDim) = obj.images{i};
        end
        figure;
        imshow(alignedImg,[]);
    end
end
methods(Static)  
    function imgVec = images2vectors(images)
        %image is a 1-by-n vector
        imgVec = zeros(prod(size(images{1})),length(images));
        for i = 1:length(images)
            imgVec(:,i) = images{i}(:);
        end
        imgVec=normc(imgVec);
    end
    
    function P=generateSubspace(images,dimension)
        imgVec = State.images2vectors(images);
        P = pca(imgVec);
        %P = P(:,1:dimension);
    end
    
end

end
