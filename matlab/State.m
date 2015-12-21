classdef State < handle
    
properties
    stateName;
    images;
    imgVec;
    subspaceInfo;
end

methods    
    function stateObj = State(images, stateName, subspaceDimension)
            stateObj.images = images;
            stateObj.imgVec = State.images2vectors(images);
            stateObj.stateName = stateName;
            stateObj.subspaceInfo.nData = length(stateObj.images);
            stateObj.subspaceInfo.mu = mean(stateObj.imgVec,2);
            stateObj.subspaceInfo.subspace = stateObj.generateSubspace(stateObj.imgVec, subspaceDimension);
    end
    
    function showImgHorizontal(obj,maxPhoto)
        if maxPhoto>length(obj.images)
           maxPhoto = length(obj.images);
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
    
    function img=getImage(obj,i)
        img = obj.images{i};
    end
    
    function subspace = getSubspace(obj)
        subspace = obj.subspaceInfo.subspace;
    end
    
    function similarity=vec2SubspaceSim(obj, vec, distanceMeasure)
        similarity = distanceMeasure(obj.subspaceInfo, vec);
    end
    
    function imgVec=getImageVectors(obj)
        imgVec = obj.imgVec;
    end
    function numImg=getNumImg(obj)
        numImg = length(obj.images);
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
   
    function P=generateSubspace(vec,dimension)
        %dimension
        %P = kernelpca(vec, dimension);
        P=pca(vec');
        %size(P)
        P = P(:,1:dimension);
    end
end

end
