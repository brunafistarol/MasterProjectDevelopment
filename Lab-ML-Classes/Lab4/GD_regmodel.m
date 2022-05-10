function[w_new,SSE] = GD_regmodel(in,out,alpha)
%PI_regmodel take a dataset where 'in' contain examples in each row and
%features as column, and 'out' contain the values of the feature we want o predict for
%each datapoints. The function compute 'w_new', the weigths of the
%regression model, and SSE, a vector whih contains teh error of the model
%in every iteration

[m,n] = size(in); %m is the number of examples, and n is the numbr of features

w_ant = 0.001*randn(n+1,1); %we initialize the weights
SSE = []; 
RMS = [];
A = [ones(m,1) in];
for (j=1:10) %we go trougth all the instances 5 times
    for (i = 1:m)
        w_new = w_ant + alpha*(out(i,:) - A(i,:)*w_ant)*A(i,:)'; %actualize the wheights gicen the error of the model
        w_ant = w_new;
        SSE = [SSE; 0.5*sum((out - A*w_new).^2)]; %save the Sum of Squares Error on each iteration of the weights
    end
end

