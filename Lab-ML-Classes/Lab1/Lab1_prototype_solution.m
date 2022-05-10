n = 10; %size of dataset
D = 3; %degree of the polynomial

lambda = 0.01; %regression parameter

x = [0:0.001:1]; %range of x (and plots)
y = sin(2*pi*x);

nx = rand(n, 1); %dataset x
ny = sin(2*pi*nx) + randn(n,1)*0.3; %dataset y

%here we make the initial plot, the curve and the points
figure; plot(x, y, '-g'); hold on;
plot(nx, ny, 'bo'); 
grid on;
xlim([-0.2, 1.2]); ylim([-1.4, 1.4]); 
xticks([-0.2: 0.1 : 1.2]); yticks([-1.4: 0.2 : 1.4]);

%calculate the linear regression
%e = ones(n,1) * [0:D];
%A = (nx * ones(1, D+1)) .^ e; % DESIGN MATRIX
%A = repmat(nx, 1, D+1) .^ e; %alternative for calculating A
A = nx .^ [0:D]; % a shorter version from Aldo for calculating the Design Matrix
W = A \ ny
% note that the above is identical to applying the normal equation of
% regression in the least square sense, that is W = inv(A' * A) * A' * ny

%calculate the regularized model
%NOTE: I believe that using the normal equations is the only way here, I
%could not find another way (AP 7/7/21)
Wreg = inv(lambda * eye(D+1) + A' * A) * A' * ny


%calculate both models
% Note: variables named 'm' refer to 'model'
%e = ones(length(x),1) * [0:D];
%Am = (x' * ones(1, D+1)) .^ e; 
%Am = repmat(x', 1, D+1) .^ e; alternative for calculating A
Am = x' .^ [0:D];
ym = Am * W; %simple model
ym_reg = Am * Wreg; %regularized model
 

plot(x, ym, '-r'); %plot the simple model in red
plot(x, ym_reg, '-b'); %plot the regularized model in cyan




