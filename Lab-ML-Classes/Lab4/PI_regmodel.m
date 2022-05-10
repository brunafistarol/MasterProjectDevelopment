function[w] = PI_regmodel(in, out)
%PI_regmodel take a dataset where 'in' contain examples in each row and
%features as column, and 'out' contain the values of certain features for
%each datapoints, the features represented in 'out' are what we want to
%predict given a datapoint with the same features we have in 'in'. The
%function compute 'w', the weigths of the regression model.

[m,n] = size(in); %m is the number of examples, and n is the numbr of features
N = size(out,2); %N is the number of features we want to predict

A = [ones(m,1) in]; %here a column of ones is added for the bias w0
w = inv(A'*A)*A'*out; %here the weights are computed using the Moore-Pensrose pseudo-inverse
end