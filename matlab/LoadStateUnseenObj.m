labelFile = '/home/hwlee/Develop/caffe/examples/6states/features/imageLabels.txt';
load('/home/hwlee/Develop/caffe/examples/6states/features/feature.mat')
f = fopen(labelFile);
C = textscan(f, '%s %s');
stateLabel = C{1};
objectLabel = C{2};
feature(numel(stateLabel)+1:end,:)=[];
sn = StateNet();
%%
preDefinedStates = unique(stateLabel);
imgStateHashTable = containers.Map(preDefinedStates,1:length(preDefinedStates));
currentHashTable = imgStateHashTable;
currentClasses = unique(cell2mat(values(currentHashTable,keys(currentHashTable))));
trainIdx = containers.Map();
testIdx = containers.Map();
%apple lemon
excludeIdx = findStrInCell(objectLabel,'apple');
excludeIdx = [excludeIdx; findStrInCell(objectLabel,'lemon')];
for i=1:length(preDefinedStates)
    disp(preDefinedStates{i})
    idx = findStrInCell(stateLabel,preDefinedStates{i});
    %[trainIdx(preDefinedStates{i}), testIdx(preDefinedStates{i})] = partitionTrainTest(idx,0.5);
    tmp = idx;
    tmp(find(ismember(tmp,excludeIdx))) = [];
    trainIdx(preDefinedStates{i}) = tmp;
    tmpState = State(feature(trainIdx(preDefinedStates{i}),:), preDefinedStates{i}, 20)
    sn.addState(tmpState)
    clear tmpState idx
end
%%
trainImgs = feature(cell2mat(values(trainIdx, keys(trainIdx))'),:);
trainLabels = stateLabel(cell2mat(values(trainIdx, keys(trainIdx))'),:);
%testImgs = feature(cell2mat(values(testIdx, keys(testIdx))'),:);
%testLabels = stateLabel(cell2mat(values(testIdx, keys(testIdx))'),:);
testImgs = feature(excludeIdx,:);
testLabels = stateLabel(excludeIdx,:);