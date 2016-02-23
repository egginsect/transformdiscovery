close all
dist=sn.distMat;
%yData=tsne_d(exp(dist)/100-eye(size(dist,2)),1:size(dist,2));
yData=tsne_d(dist,1:size(dist,2));
hold on
%yData=tsne(imgs,label);
 for i=1:length(sn.nodeNames)
     text(yData(i,1),yData(i,2),sn.nodeNames{i})
 end
 %%
TRI = delaunay(yData(:,1),yData(:,2));
triplot(TRI,yData(:,1),yData(:,2));