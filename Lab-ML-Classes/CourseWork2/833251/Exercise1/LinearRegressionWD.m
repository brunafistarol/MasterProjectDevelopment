function test_error = LinearRegressionWD(n, lambda, t)
%input
    %n: learning rate
    %lambda: weight decay parameter
    %t:threshold
%output
    %test_error: vector of test error
    
data = load('housing.txt');
idx = randperm(size(data, 1), ceil(9*size(data, 1)/10)); %training set index
features = data(idx, 1:13); %training set
MEDV = data(idx, 14);
 
[x, y] = size(features);
w_i = 0.001*randn(y+1,1);
A = [ones(x, 1) features];
error = [0.5*sum((MEDV - A*w_i).^2) + t + 1; 0.5*sum((MEDV - A*w_i).^2)];

while abs(error(end)-error(end-1))>t
    for i = 1:x
        w = w_i + n*((MEDV(i) - A(i, :)*w_i)*A(i, :)' - lambda*w_i);
        w_i = w;
        error = [error; 0.5*sum((MEDV - A*w).^2)];
    end
end

test_idx = setdiff(1:size(data, 1), idx);
test_features = data(test_idx, 1:13);
test_MEDV = data(test_idx, 14);
[x, ~] = size(test_features);
A = [ones(x, 1) test_features];
test_error = 0.5*sum((test_MEDV - A*w_i).^2);

plot(error)
ylabel('Error'); xlabel('Iteration')