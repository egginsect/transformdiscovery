precisionTune = zeros(2,9);
lambda = linspace(0.1,1,9);
%%
for tuneRound = 1:9
    testGFDL
    precisionTune(1,tuneRound) = mean(precision);
    precisionTune(2,tuneRound) = mean(precision_train);
end     