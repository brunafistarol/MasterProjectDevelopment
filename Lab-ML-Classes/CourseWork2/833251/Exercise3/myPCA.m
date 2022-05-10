function V = myPCA(X)

cov = (X'*X)/size(X, 1);
[V, D] = eig(cov);

[~,  pos] = sort(diag(D), 'descend');
V = V(:,pos);