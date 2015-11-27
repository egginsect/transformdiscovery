    function sampledIdx = sampleImageSeq(idx, numStates, numPerson)

    sampledIdx = zeros(length(unique(idx))*numStates,1);
    objectLabel = unique(idx);
    for i=1:length(objectLabel)
        croppedIdx = find(idx==objectLabel(i));
        minIdx = min(croppedIdx);
        maxIdx = max(croppedIdx);
        sampledIdx((i-1)*numStates+(1:numStates))=[minIdx, minIdx+round((maxIdx-minIdx)*((1:numStates-2)/(numStates-1))), maxIdx]';
    end
    size(sampledIdx)
    sampledIdx = reshape(sampledIdx,numStates,length(unique(idx)))';
    if exist('numPerson', 'var')
        if(numPerson> unique(idx))
        numPerson = length(unique(idx));
        end
        p = randperm(size(sampledIdx,1));
        sampledIdx = sampledIdx(p(1:numPerson),:);
    end
    end