function dataInfo=ksvdDictionaryUpdate(dataInfo)
    X = dataInfo.X;
    D = dataInfo.D;
    A = cell(1,length(X));
    param.iternum = 20;
    param.dictsize = size(D{1},2);
    param.memusage = 'high'; 
    param.Tdata = param.dictsize;
    for i=1:length(X)
        param.data = X{i};
        D{i}=ksvd(param,'',0);
        param.initdict = D{i};
    end
end