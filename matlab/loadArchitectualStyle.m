labelFile = '/home/hwlee/Develop/Dataset/fileLabels.txt';
f = fopen(labelFile);
C = textscan(f, '%s');
stateLabel = C{1};
feature = dlmread('/home/hwlee/Develop/Dataset/features.csv');
feature(numel(stateLabel)+1:end,:)=[];
sn = StateNet();
%%
preDefinedStates = unique(stateLabel);
imgStateHashTable=containers.Map(preDefinedStates,1:length(preDefinedStates));
currentHashTable = imgStateHashTable;
currentClasses = unique(cell2mat(values(currentHashTable,keys(currentHashTable))));
trainIdx = containers.Map();
testIdx = containers.Map();
%%
for i=1:length(preDefinedStates)
    idx = findStrInCell(stateLabel,preDefinedStates{i});
    idxCount(i)=numel(idx);
end
%%
for i=1:length(preDefinedStates)
    disp(preDefinedStates{i})
    idx = findStrInCell(stateLabel,preDefinedStates{i});
    [trainIdx(preDefinedStates{i}), testIdx(preDefinedStates{i})] = partitionTrainTest(idx,0.7);
    tmpState = State(feature(trainIdx(preDefinedStates{i}),:), preDefinedStates{i}, 20)
    sn.addState(tmpState)
    clear tmpState idx
end
%%
trainImgs = feature(cell2mat(values(trainIdx, keys(trainIdx))'),:);
trainLabels = stateLabel(cell2mat(values(trainIdx, keys(trainIdx))'),:);
testImgs = feature(cell2mat(values(testIdx, keys(testIdx))'),:);
testLabels = stateLabel(cell2mat(values(testIdx, keys(testIdx))'),:);