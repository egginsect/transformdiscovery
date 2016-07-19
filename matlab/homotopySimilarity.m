function similarity = homotopySimilarity(subspaceInfo,v)
    S=subspaceInfo.subspace;
    v=double(v);
    v=v-subspaceInfo.mu;
    size(subspaceInfo.mu);
    x = SolveHomotopy(S, v, 'lambda', 1e-3, 'tolerance',...
    1e-5, 'maxiteration', 1000, 'isnonnegative', false, 'groundtruth', normc(ones(size(S,2),1)));
    v_hat=S*x;
    similarity = -norm(v-v_hat);
end