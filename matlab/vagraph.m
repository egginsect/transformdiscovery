load xyVAgraph
for i=1:size(xyVAgraph,1)
    for j=i+1:size(xyVAgraph,1)
        dVAgraph(i,j) = norm(xyVAgraph(i,:)-xyVAgraph(j,:));
        dVAgraph(j,i) = dVAgraph(i,j);
    end
end
%%
nNeighbor=3
adjVAgraph = zeros(size(dVAgraph));
nearestNeighbor = zeros(size(xyVAgraph,1),nNeighbor);
for i = 1:size(xyVAgraph,1)
    dists = dVAgraph;
    [sorted idx] = sort(dists);
    nearestNeighbor(i,:) = idx(2:nNeighbor+1);
end
for i=1:size(nearestNeighbor,1)
    for j=1:size(nearestNeighbor,2)
    	adjVAgraph(i,nearestNeighbor(i,j))=dVAgraph(i,nearestNeighbor(i,j));
    end
end
%%
g=biograph(adjVAgraph,sn.nodeNames);
view(g)