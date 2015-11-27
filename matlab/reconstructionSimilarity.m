function similarity = reconstructionSimilarity(subspaceInfo,v)
    S=subspaceInfo.subspace(:,1:10);
    v=double(v);
    v=v-subspaceInfo.mu;
    coeff=v'*S;
    v_hat=S*coeff';
    similarity = -norm(v-v_hat);
end