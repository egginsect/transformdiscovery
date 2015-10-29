classdef State < handle
    
properties
    stateName;
    stateLevel;
    images;
    imgVec;
    subspace;
end

methods    
    function stateObj = State(images, stateName, stateLevel, subspaceDimension)
        stateObj.stateName = stateName;
        stateObj.stateLevel = stateLevel;
        stateObj.images = images;
        [stateObj.subspace, stateObj.imgVec] = stateObj.generateSubspace(stateObj.images,subspaceDimension);
    end
    
    function showImgHorizontal(obj,maxPhoto)
        if maxPhoto>length(obj.images)
           maxPhoto = length(obj.images)
        end
        [colDim, rowDim] = size(obj.images{1});
        alignedImg = zeros(colDim,rowDim*maxPhoto);
        for i=1:maxPhoto
            size(alignedImg(:,(i-1)*rowDim+1:i*rowDim))
            size(obj.images{i})
            alignedImg(:,(i-1)*rowDim+1:i*rowDim) = obj.images{i};
        end
        figure;
        imshow(alignedImg,[]);
    end
    
    function subspace = getSubspace(obj)
        subspace = obj.subspace;
    end
end
methods(Static)  
    function imgVec = images2vectors(images)
        %image is a 1-by-n vector
        imgVec = zeros(prod(size(images{1})),length(images));
        for i = 1:length(images)
            %[num2str(i),' th image']
            %size(imgVec(:,i))
            %size(images{i}(:))
            imgVec(:,i) = images{i}(:);
        end
    end
    
    function [P,imgVec]=generateSubspace(images,dimension)
        imgVec = State.images2vectors(images);
        P = pca(imgVec');
        %size(P)
        P = P(:,1:dimension);
    end
    
end

end
