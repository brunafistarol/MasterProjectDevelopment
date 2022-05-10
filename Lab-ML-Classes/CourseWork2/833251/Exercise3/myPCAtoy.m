function myPCAtoy()
k = 1;

load ('pcadata.mat');

%figure 1 - displaying original points
figure()
plot(X(:, 1), X(:, 2), 'bo');
axis equal;
title('Original Datapoints')

%normalize data subtracting the mean
X_norm = normalize(X, 'center');
X_mean = mean(X);

%calculating principal components
V = myPCA(X_norm);

%figure 2
figure()
plot(X_norm(:, 1), X_norm(:, 2), 'k+');
hold on;
p1 = [0 0; V(:, 1)'];
p2 = [0 0; V(:, 2)'];
plot(p1(:,1), p1(:,2), 'r-');
plot(p2(:,1), p2(:,2), 'g-');
axis equal;
title('Datapoints centred and the 2 principal components')
hold off;

% projecting normalized data on first principal component
projection = project(X_norm, V(:, k));

%figure 3
figure()
plot(X_norm(:, 1), X_norm(:, 2), 'k+');
hold on;
plot(projection(:, 1), projection(:, 2), 'r*')
axis equal;
title('Datapoints centred and their projection')
hold off;

%recovering data by mean addition
recovery_data = recovery(projection, X_mean);

%figure 4 - our recovered data!
figure()
plot(X(:, 1), X(:, 2), 'bo');
hold on;
plot(recovery_data(:, 1), recovery_data(:, 2), 'r*')
axis equal;
title('Original datapoints and their reconstruction')
hold off;