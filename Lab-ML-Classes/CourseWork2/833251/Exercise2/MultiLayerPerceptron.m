function [w_h1, w_h2, w_output] = MultiLayerPerceptron(t, n)

%input:
    %t: threshold
    %n: learning rate
%output:
    %weights

data = csvread('occupancy_training_set.csv', 1, 0);
X = normalize(data(:, 1:end-1));
Y = data(:, end);

%defining size of hidden layers
size_h1 = 3;
size_h2 = 3;
size_output = 1;

%initial values to weights
w_h1 = 0.1*randn(size(X, 2), size_h1); % m x 3, where m is the number of columns of data
w_h2 = 0.1*randn(size_h1, size_h2); % 3 x 3
w_output = 0.01*randn(size_h2, size_output);
Z3 = [];
error = [t+1 0]; %in this way we enter in the loop and stay in it if the first error is bigger than t

while abs(error(end)-error(end-1))>t
    
    %foward propagation
    S1 = X*w_h1;
    Z1 = sigmoid(S1);
    S2 = Z1*w_h2;
    Z2 = sigmoid(S2);
    S3 = Z2*w_output;
    Z3 = sigmoid(S3);
   
    error = [error 0.5*sum((Y-Z3).^2)];
    
    %backward propagation
    D3 = (Z3 - Y)';
    D2 = (Z2'.*(1-Z2')).*(w_output*D3);
    D1 = (Z1'.*(1-Z1')).*(w_h2*D2);
    
    %weights update
    w_h1 = w_h1 - n*(D1*X)';
    w_h2 = w_h2 - n*(D2*Z1)';   
    w_output = w_output - n*(D3*Z2)';
    
end

plot(error(3:end))
ylabel('Error'); xlabel('Iteration')