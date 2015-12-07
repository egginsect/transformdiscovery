function d=stateDist(S1,S2)
     [U,S,V] = svd(S1.getSubspace()'*S2.getSubspace());
     tmp = S(1:size(S,1)+1:end);
     d = length(tmp)-sum(tmp.^2);
end