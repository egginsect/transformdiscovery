labelFile = '/home/hwlee/Develop/caffe/examples/_temp/imageLabels.txt';
load('/home/hwlee/Develop/caffe/examples/_temp/feature1000.mat')
f = fopen(labelFile);
C = textscan(f, '%s %s');
stateLabel = C{1};
objectLabel = C{2};
feature(numel(stateLabel)+1:end,:)=[];
%%
feature(findStrInCell(stateLabel,'cut'),:)=[];
removeIdx = findStrInCell(stateLabel,'cut');
stateLabel(removeIdx)=[];
objectLabel(removeIdx)=[];
%%
feature(findStrInCell(stateLabel,'mashed'),:)=[];
removeIdx = findStrInCell(stateLabel,'mashed');
stateLabel(removeIdx)=[];
objectLabel(removeIdx)=[];
%%
feature(findStrInCell(stateLabel,'squished'),:)=[];
removeIdx = findStrInCell(stateLabel,'squished');
stateLabel(removeIdx)=[];
objectLabel(removeIdx)=[];
sn = StateNet();
%%
preDefinedStates = unique(stateLabel);
imgStateHashTable=containers.Map(preDefinedStates,1:length(preDefinedStates));
currentHashTable = imgStateHashTable;
currentClasses = unique(cell2mat(values(currentHashTable,keys(currentHashTable))));
trainIdx = containers.Map();
testIdx = containers.Map();
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