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
end
methods(Static)
    function P=generateSubspace(images,dimension)
        imgVec = images2vectors(images);
        P = pca(imgVec);
        P = P(:,1:dimension);
    end
    
    function imgVec = images2vectors(images)
        %image is a 1-by-n vector
        imgVec = zeros(prod(size(images{1})),length(images));
        for i = 1:length(images)
            imgVec(:,i) = images{i}(:);
        end
        imgVec=normc(imgVec);
    end
    
    function showImgHorizontal()
        [colDim, rowDim] = size(self.images{1});
        alignedImg = zeros(colDim,rowDim*length(self.images));
        for i=1:length(self.images)
            alignedImg(:,(i-1)*rowDim+1:i*rowDim) = self.images{i};
        end
        figure;
        imshow(alignedImg,[]);
    end
end

end
