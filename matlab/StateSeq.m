classdef StateSeq < handle

properties 
    States;
    StateName;
end

methods
%State Sequence Class Constructor
%images: assume a cell array, each element is a gray image
%idx: there are multiple sequence of state transform, idx indicating which
%       sequence an image belongs to
%numStates: specifies how many states to be generate from these image
%subspaceDimension: indicating the dimension of subspace representing each state
    function StateSeqObj = StateSeq(StateName, images, idx, numStates, subspaceDimension)
        StateSeqObj.StateName = StateName;
        StateSeqObj.States = cell{1,numStates};
        sampledIdx = self.sampleImageSeq(idx,numStates);
        for i=1:numStates
            StateSeqObj.States{i} = State(images(sampledIdx(:,i)), stateName, i, subspaceDimension)
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
end
end

end