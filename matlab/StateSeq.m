classdef StateSeq < handle

properties 
    states;
    stateType;
    numStates;
    sampledIdx;
end

methods
%State Sequence Class Constructor
%images: assume a cell array, each element is a gray image
%idx: there are multiple sequence, each sequence represents state transform for one person, 
%       idx indicating which sequence an image belongs to
%numStates: specifies how many states to be generate from these image
%subspaceDimension: indicating the dimension of subspace representing each state
    function stateSeqObj = StateSeq(stateType, images, idx, numStates, subspaceDimension)
        stateSeqObj.stateType = stateType;
        stateSeqObj.states = cell(1,numStates);
        stateSeqObj.numStates = numStates;
        stateSeqObj.sampledIdx = stateSeqObj.sampleImageSeq(idx, numStates, subspaceDimension+1);
        
        for i=1:numStates
            %[num2str(i),' th state']
            %sampledIdx(:,i)
            stateSeqObj.states{i} = State(images(stateSeqObj.sampledIdx(:,i)), [stateType,num2str(i)], subspaceDimension);
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
            error(['Invalid State Number for State ',obj.stateType]);
        else
            state = obj.states{i};
        end
    end
    

end


methods(Static)
    function sampledIdx = sampleImageSeq(idx, numStates, numPerson)
    if numPerson > unique(idx)
        numPerson = length(unique(idx));
    end
    sampledIdx = zeros(length(unique(idx))*numStates,1);
    objectLabel = unique(idx);
    for i=1:length(objectLabel)
        croppedIdx = find(idx==objectLabel(i));
        minIdx = min(croppedIdx);
        maxIdx = max(croppedIdx);
        sampledIdx((i-1)*numStates+(1:numStates))=[minIdx, minIdx+round((maxIdx-minIdx)*((1:numStates-2)/(numStates-1))), maxIdx]';
    end
    sampledIdx = reshape(sampledIdx,numStates,numPerson)';
    p = randperm(size(sampledIdx,1));
    sampledIdx = sampledIdx(p(1:numPerson),:);
    end
    
end

end