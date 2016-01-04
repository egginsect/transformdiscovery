classdef ImageSequence < handle
properties
    dataSetDir
end

methods
    function imageSequenceObj = ImageSequence(dataSetDir)
        imageSequenceObj.dataSetDir = dataSetDir;
    end
    
    function groups=getSampledGroup(self, numStage, imgPerStage, numInstances)
         structFields = fields(self.dataSetDir);
         idx=[self.dataSetDir.(structFields{2})];
         idx2=[self.dataSetDir.(structFields{3})];
         groups = cell(length(unique(idx2)),numStage);
         for i=unique(idx2)
             if exist('numInstances', 'var')
                sampledIdx = self.sampleImageSeq(idx(find(idx2==i)),numStage, imgPerStage, numInstances);
             else
                sampledIdx = self.sampleImageSeq(idx(find(idx2==i)),numStage, imgPerStage);
             end
             for j=1:numStage
                 groupIdx=cell2mat(sampledIdx(:,j));
                 filePath={self.dataSetDir(groupIdx).(structFields{1})}';
                 newIdx1=repmat([i],numel(groupIdx),1);
                 newIdx2=repmat([j],numel(groupIdx),1);
%                 dataGroup=cell2struct([filePath, newIdx1, newIdx2],{'filePath','idx1','idx2'},2);
                 groups{i,j}=ImageGroup(filePath,[newIdx1,newIdx2]);
             end
         end
    end
    
    function generateMap(initialStateLabel, transformedStateLanel, numStage)
        map=containers.Map();
        for i=1:length(transformedStateLanel)
            map(num2str(i))=
            for j=2:numStage
                
            end
        end
    end
end

methods(Static)
    function sampledIdx = sampleImageSeq(idx, numStage, imgPerStage, numInstances)
    objectLabel = unique(idx);
    sampledIdx = cell(numel(objectLabel),numStage);
    for i=1:length(objectLabel)
        croppedIdx = find(idx==objectLabel(i));
        minIdx = min(croppedIdx);
        maxIdx = max(croppedIdx);
        step=(maxIdx-minIdx)/(numStage-1);
        sampledIdx{i,1}=minIdx:minIdx+imgPerStage-1;
        for j=2:numStage-1
            if(mod(imgPerStage,2));
                sampledIdx{i,j}=(minIdx+round(step*(j-1))-(imgPerStage-1)/2):(minIdx+round(step*(j-1))+(imgPerStage-1)/2);
            else
                sampledIdx{i,j}=(minIdx+round(step*(j-1))-round(imgPerStage/2)):(minIdx+round(step*(j-1))+round(imgPerStage/2)-1);
            end
        end
        sampledIdx{i,numStage}=maxIdx-(imgPerStage-1):maxIdx;
    end
%     size(sampledIdx)
%     numStates
%     length(unique(idx))
%     sampledIdx = reshape(sampledIdx,numStage,length(unique(idx)))';
     if exist('numInstances', 'var')
         if(numInstances> unique(idx))
         numInstances = length(unique(idx));
         end
         p = randperm(size(sampledIdx,1));
         sampledIdx = sampledIdx(p(1:numInstances),:);
     end
    end
end

end