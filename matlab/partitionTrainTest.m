function [idxTrain, idxTest] = partitionTrainTest(idx,ratio)
    shuffled = randperm(numel(idx));
    cut = round(length(shuffled)*ratio);
    idxTrain = idx(shuffled(1:cut-1));
    idxTest = idx(shuffled(cut:end));
end