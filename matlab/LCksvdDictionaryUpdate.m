function dataInfo=LCksvdDictionaryUpdate(dataInfo)
    X = dataInfo.X;
    D = dataInfo.D;
    A = cell(1,length(X));
    H_train = dataInfo.lambda;
    disp(H_train);
    param.iternum = 20;
    param.dictsize = size(D{1},2);
    param.memusage = 'high'; 
    sparsitythres = 30; % sparsity prior
    sqrt_alpha = 4; % weights for label constraint term
    sqrt_beta = 2; % weights for classification err term
    %sqrt_alpha = 0; 
    %sqrt_beta = 0;
    dictsize = 60; % dictionary size
    iterations = 50; % iteration number
    iterations4ini = 20; % iteration number for initialization
    size(cell2mat(X))
    [Dinit,Tinit,Winit,Q_train] = ...
    initialization4LCKSVD(cell2mat(X),H_train,dictsize,iterations4ini,sparsitythres);
    [D1,X1,T1,W1] = labelconsistentksvd1(cell2mat(X), Dinit,Q_train,Tinit,H_train,iterations,sparsitythres,sqrt_alpha);
    for i=1:length(X)
        D{i}=D1(:,(i-1)*10+1:i*10);
    end
    dataInfo.D = D;
end