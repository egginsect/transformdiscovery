classdef StateSeq < handle

properties 
    states;
    stateName;
    numStates;
end

methods
%State Sequence Class Constructor
%images: assume a cell array, each element is a gray image
%idx: there are multiple sequence, each sequence represents state transform for one person, 
%       idx indicating which sequence an image belongs to
%numStates: specifies how many states to be generate from these image
%subspaceDimension: indicating the dimension of subspace representing each state
    function stateSeqObj = StateSeq(stateName, images, idx, numStates, subspaceDimension)
        stateSeqObj.stateName = stateName;
        stateSeqObj.states = cell(1,numStates);
        stateSeqObj.numStates = numStates;
        sampledIdx = stateSeqObj.sampleImageSeq(idx,numStates);
        
        for i=1:numStates
            %[num2str(i),' th state']
            %sampledIdx(:,i)
            stateSeqObj.states{i} = State(images(sampledIdx(:,i)), stateName, i, subspaceDimension);
        end
    end
    
    function d = computeDistances(obj)
        d = zeros(obj.numStates);
        for i = 1:obj.numStates
            for j=(i+1):obj.numStates
                d(i,j)=stateDist(obj.states{i},obj.states{j});
            end
        end
    end
    
    % Return ith-state
    function state = getState(obj,i)
        if(~any(i==1:obj.numStates))
            error(['Invalid State Number for State ',obj.stateName]);
        else
            state = obj.states{i};
        end
    end
end


methods(Static)
    function sampledIdx = sampleImageSeq(idx,numPoints)
    sampledIdx = zeros(length(unique(idx))*numPoints,1);
    objectLabel = unique(idx);
    for i=1:length(objectLabel)
        croppedIdx = find(idx==objectLabel(i));
        minIdx = min(croppedIdx);
        maxIdx = max(croppedIdx);
        sampledIdx((i-1)*numPoints+(1:numPoints))=[minIdx, minIdx+round((maxIdx-minIdx)*((1:numPoints-2)/(numPoints-1))), maxIdx]';
    end
    sampledIdx = reshape(sampledIdx,numPoints,length(sampledIdx)/numPoints)';
    end

end

end