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
     tmp=cell(1,size(sampledIdx,2));
     for i=1:size(sampledIdx,2)
        tmp2=cell2mat(sampledIdx(:,i));
        tmp{i}=tmp2(:);
     end
     sampledIdx = tmp;
    end