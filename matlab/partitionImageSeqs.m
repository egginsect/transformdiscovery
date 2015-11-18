function partitionedIdx = partitionImageSeqs(idx, numStates)
    partitionedIdx = cell(1,numStates);
    partitionedIdx(:)={[]};
    objectLabel = unique(idx);
    for i=1:length(objectLabel)
        croppedIdx = find(idx==objectLabel(i));
        minIdx = min(croppedIdx);
        maxIdx = max(croppedIdx);
        step=length(croppedIdx)/numStates;
        partitionedIdx{1} = [partitionedIdx{1}, minIdx:(minIdx+round(step))];
        for j=2:numStates-1
            partitionedIdx{j} = [partitionedIdx{j}, (minIdx+round(step*(j-1))):(minIdx+round(step*(j)))];
        end
        partitionedIdx{numStates} = [partitionedIdx{numStates}, (maxIdx-round(step)):maxIdx];
    end
end