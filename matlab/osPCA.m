function similarity=osPCA(subspaceInfo, v)
    beta=0.9;
    ratio = 1/((subspaceInfo.nData+1)*beta);
    d=0.0001;
    u=subspaceInfo.subspace(:,1);
    v=double(v);
    mu_new = (subspaceInfo.mu+ratio*v)/(1+ratio);
    v=v-mu_new;
    [w]=Track_w(v', u, d, beta);
    w=w/norm(w);
    similarity = w'*u;
end

function [w d] = Track_w(x, w, d, beta)
y = x*w;
d = beta*d+y^2;
e = x'-w*y;
w = w + (y*e)/d;
end