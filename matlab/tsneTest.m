close all
% tmp=[];
% label=[]
% for i=1:length(preDefinedStates)
%     P=sn.getState(stateNames{1}).getSubspace();
%     X=sn.getState(stateNames{1}).getImageVectors;
%     tmp=[tmp;X'*P];
%     label = [label,i*ones(1,size(X,2))];
% end
tmp = sn.distMat;
%dist = tmp-mean(tmp(:))+std(tmp(:));
dist=tmp;
%yData=tsne_d(exp(dist)/100-eye(size(dist,2)),1:size(dist,2));
yData=tsne_d(dist,1:size(dist,2),3);
hold on
%yData=tsne(tmp,label,3);

%[Y] = lle(tmp',length(unique(label)),2)
 %%
% TRI = delaunay(yData(:,1),yData(:,2));
% triplot(TRI,yData(:,1),yData(:,2))
%trisurf(TRI,yData(:,1),yData(:,2),yData(:,3),'facealpha',0);
%%
  for i=1:length(sn.nodeNames)
      %text(yData(i,1),yData(i,2),sn.nodeNames{i})
      text(yData(i,1),yData(i,2),yData(i,3),sn.nodeNames{i})
  end
%%
sn.showNNgraph(1)
 for i=1:length(sn.nodeNames)
     for j=1:length(sn.nodeNames)
     if(sn.adjMat(i,j))>0
         pts = [yData(i,:); yData(j,:)];
         line(pts(:,1), pts(:,2), pts(:,3));
     end
     end
 end