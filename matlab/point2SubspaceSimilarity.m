function similarity=point2SubspaceSimilarity(subspaceInfo,v)
    v=double(v);
    v=v-subspaceInfo.mu;
    similarity = v'*subspaceInfo.subspace(:,1)/norm(v);
end