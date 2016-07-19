function dataInfo = geodesicFlowConstrainedDictionaryUpdate_new(dataInfo)
    X = dataInfo.X;
    D = dataInfo.D;
    B = cell(1,length(X)-1);
    Q = cell(size(B));
    A = cell(1,length(X));
    lambda=dataInfo.lambda;
    [n,p] = size(D{end}); 
    for iter=1:20
    disp(['iteration ',num2str(iter)]);
    O = [D{end},null(D{end}')];
    for i=1:length(B)
         disp(['compute exponential map of geodesic', num2str(i)]);
         %B{i}=compute_velocity_grassmann_efficient(D{end},D{i});
         %Q{i} = O*expm([zeros(p),B{i}';-B{i},zeros(n-p)])*O';
         Q{i} = computeGeodesicRelationMat(D{end},D{i},O);
    end  
    for i=1:length(A)
        disp(['compute sparse coefficient for class ', num2str(i)]);
        A{i} = omp(D{i}'*X{i},D{i}'*D{i},5);
%         A{i} = zeros(size(D{i},2),size(X{i},2));
% 
%         for j=1:size(X{i},2)
%             A{i}(:,j) = SolveHomotopy(D{i}, X{i}(:,j), 'lambda', 1e-3, 'tolerance',...
%     1e-5, 'maxiteration', 1000, 'isnonnegative', false, 'groundtruth', normc(ones(size(D{i},2),1)));
%         end
    end

    D_new = zeros(size(D{1}));
        tmp=zeros(size(D{1},1));
        for l=1:length(B)
            tmp = tmp + Q{l}'*D{l}*D{l}'*Q{l};
        end
%         tmp2=zeros(size(D{1},1));
%         for l=1:length(D)
%             tmp2 = tmp2 + D{l}*D{l}';
%         end
    for i=1:p
        disp(['updating column ',num2str(i), ' of initial dictionary']);
        D{end}(:,i) = (norm(A{end}(i,:))^2*eye(n)-lambda*tmp)\(X{end}-D{end}(:,find(1:p~=i))*A{end}(find(1:p~=i),:))*A{end}(i,:)';
        
        D{end}(:,i) = normc(D{end}(:,i));
        A{end}(i,:) = A{end}(i,:)*norm(D{end}(:,i));
    end
  
    for k=1:length(X)-1
%         tmp=zeros(size(D{1},1));
%         for l=1:length(D)
%             if(l~=k)
%             tmp = tmp + D{l}*D{l}';
%             end
%         end
        for i=1:p
        disp(['updating column ',num2str(i), ' of dictionary ',num2str(k)]);
        D{k}(:,i) = (norm(A{k}(i,:))^2*eye(n)-lambda*Q{k}*D{end}*D{end}'*Q{k}')\(X{k}-D{k}(:,find(1:p~=i))*A{k}(find(1:p~=i),:))*A{k}(i,:)';
        D{k}(:,i) = normc(D{k}(:,i));
        A{k}(i,:) = A{k}(i,:)*norm(D{k}(:,i));
        end
    end
    J(iter) = 0;
    for i=1:length(D)
        J(iter)=J(iter)+norm(X{i}-D{i}*A{i},'fro')^2;
        if i<length(D)
            J(iter)=J(iter)-norm(D{i}'*Q{i}*D{end},'fro')^2;
        end
    end
    end
    dataInfo.D = D;
    dataInfo.J=J;
end


% function O = computeOrthogonalCompletion(P)
%     I_n=eye(size(P,1));
%     J=I_n(:,1:size(P,2));
%     [U,S,V]=svd(P*J');
%     O=V*U';
% endsize(P1,)

% function Q=computeOrthogonalCompletion(P)B{i}
%     In = sparse(eye(size(P,1)));
%     J=In(:,1:size(P,2));
%     Q_t = J/P;
%     Q=Q_t';
% end

function Q=computeGeodesicRelationMat(P1,P2,O)
    [n,p] = size(P1);
    tmp=O'*P2;
    X=tmp(1:p,:);
    Y=tmp(p+1:end,:);
    [U1,U2,V,T,Sig] = gsvd(X,Y,0);
    theta = asin(Sig);
    sinthetas = diag(Sig);
    theta = diag(asin(sinthetas));
    V = U2*theta*U1';
    Q=O*expm([zeros(p),V';-V,zeros(n-p)])*O';
end
