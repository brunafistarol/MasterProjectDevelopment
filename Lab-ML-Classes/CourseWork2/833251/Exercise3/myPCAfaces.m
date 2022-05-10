function myPCAfaces(k)

load ('pcafaces.mat');

%displaying original figure (100 first faces)
figure()
displayData(X(1:100, :))

%normalize data subtracting the mean
X_norm = normalize(X, 'center');
X_mean = mean(X);

%calculating principal components
V= myPCA(X_norm);

% projecting normalized data on k first principal components
projection = project(X_norm, V(:, 1:k));

%recovering data by mean addition
recovery_data = recovery(projection, X_mean);

%our recovered data!
figure()
displayData(recovery_data(1:100, :))