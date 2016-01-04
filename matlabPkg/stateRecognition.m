CKPlusLoad
%%
numStage=3;
ImagePerStagePerPerson=2;
numPerson=10;
imSeq = ImageSequence(dataSet);
groups=imSeq.getSampledGroup(numStage,ImagePerStagePerPerson,numPerson);
