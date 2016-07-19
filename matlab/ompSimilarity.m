function similarity = ompSimilarity(subspaceInfo,v)
    S=subspaceInfo.subspace;
    v=double(v);
    v=v-subspaceInfo.mu;
    size(subspaceInfo.mu);
    x=omp(S'*v, S'*S, 10);
    v_hat=S*x;
    similarity = -norm(v-v_hat);
end 