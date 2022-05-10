function X_rec = recovery(x, data_mean)
%this function put the projection into the original space

X_rec = x + repmat(data_mean, size(x, 1), 1); 
