function [P,rdata] = pcaDimensionReduction(data,dim)
    data = data-ones(size(data,1),1)*mean(data);
    coeff = pca(data);
    P = coeff(:,1:dim);
    rdata = data*P;
end