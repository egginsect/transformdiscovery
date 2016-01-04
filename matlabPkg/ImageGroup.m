classdef ImageGroup < handle
properties
    filePath
    label
end
methods
    function imageSetObj = ImageGroup(filePath,label)
        imageSetObj.filePath = filePath;
        if exist('label', 'var')
            imageSetObj.label = label;
        end
    end
    
    function images = loadImage(self, idx)
        filePaths = {self.imageDir(idx)}';
        images = cell(size(idx(:)));
        for i=1:length(filePaths)
            images{i}=im2double(imread(filePaths{i}));
        end
    end
    
    function encodeLabel(map)
        label=cell(numel(imageDir),1);
        for i=unique(label(:,1))
            currentMap = map(num2str(i));
            for j=unique(label(:,2))   
                label(find(label(:,1)==i & label(:,2)==j)) = currentMap(j);
            end
        end
%         for i = 1:numel(unique(imageDir.idx1))
%             for j=1:numel(unique(imageDir.idx2))
%                 
%                 label(find(idx1==i & idx2==j))=repmat({}
%             end
%         end
    end
end
end