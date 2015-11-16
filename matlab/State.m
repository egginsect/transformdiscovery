classdef State < handle
    
properties
    stateName;
    images;
    imgVec;
    subspace;
end

methods    
    function stateObj = State(varargin)
        if(length(varargin)<4)
            %State(images, stateName, subspaceDimension)
            stateObj.images = varargin{1};
            stateObj.imgVec = State.images2vectors(varargin{1});
            stateObj.stateName = varargin{2};
            stateObj.subspace = stateObj.generateSubspace(stateObj.imgVec, varargin{3});
        else
            %State(images, imgVec, stateName, subspaceDimension)
            stateObj.images = varargin{1};
            stateObj.imgVec = varargin{2};
            stateObj.stateName = varargin{3};
            stateObj.subspace = stateObj.generateSubspace(stateObj.imgVec, varargin{4});
        end
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
    
    function P=generateSubspace(imgVec,dimension)
        P = pca(imgVec');
        %size(P)
        P = P(:,1:dimension);
    end
    
end

end
