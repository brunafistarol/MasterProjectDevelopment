load('Housing.txt');
to_predict_idx = [5,14];
features_idx = setdiff(1:14,to_predict_idx);
lambda = 1e-8;
w_PI = PI_regmodel(Housing(:,features_idx),Housing(:,to_predict_idx)) %compute the weights using the close form
a = zeros(13,100); %to save the weigths and compare if they change and how they change after coputing the graient descent

for (i=1:100) %here we use the bucle for to compare the weigths reruning the gradient descent with the same inputs
w_GDNOX = GD_regmodel(Housing(:,features_idx),Housing(:,5),lambda);
w_GDMEDV = GD_regmodel(Housing(:,features_idx),Housing(:,14),lambda);
a(:,i) = w_GDNOX;
end
%we can appreciate that the weights are differents, the learned througt
%gradiente descent tend to aproximate to 0 if we compare it with the closed
%form
w_GD = [w_GDNOX w_GDMEDV]
figure;
subplot(2,2,1);
hist(a(1,:));
title('Bias');
subplot(2,2,2);
hist(a(6,:));
title('Weigth: Average Number of Rooms');
subplot(2,2,3);
hist(a(9,:));
title('Weigths: Tax of the property');
subplot(2,2,4);
hist(a(13,:));
title('Weights: Median Value');
%we can see that the final weigths for every feature change but is not random, each of them tend to a value, you can try to plot the histogram for others values to see if they are limited too (spoiler, they are)

%lets see the effect of chaging lambda in the training.

lambda = 1e-4;
err = [];
figure
for (i=1:4)
[~,err] = GD_regmodel(Housing(:,features_idx),Housing(:,5),lambda);
subplot(2,2,i);
plot(err);
ylabel('Error'); xlabel('Iteration');
lambda = lambda/100;
end

[train_set,test_set] = TvsT(Housing); %divide the dataset into training and testing
%reruning of the weights only using the train set
w_PI = PI_regmodel(train_set(:,features_idx),train_set(:,to_predict_idx));
w_GDNOX = GD_regmodel(train_set(:,features_idx),train_set(:,5),5e-8);
w_GDMEDV = GD_regmodel(train_set(:,features_idx),train_set(:,14),1e-8);

%build the matrix for the predictions (add a column of ones for the bias)
A_train = [ones(size(train_set(:,features_idx),1),1), train_set(:,features_idx)];
A_test = [ones(size(test_set(:,features_idx),1),1), test_set(:,features_idx)];
%
pred_PI_train = A_train*w_PI;
pred_GDNOX_train = A_train*w_GDNOX;
pred_GDMEDV_train = A_train*w_GDMEDV;

pred_PI_test = A_test*w_PI;
pred_GDNOX_test = A_test*w_GDNOX;
pred_GDMEDV_test = A_test*w_GDMEDV;

[SSE_PINOX_train,RMS_PINOX_train] = erro(train_set(:,5),pred_PI_train(:,1));
[SSE_PIMEDV_train,RMS_PIMEDV_train] = erro(train_set(:,14),pred_PI_train(:,2));

[SSE_GDNOX_train,RMS_GDNOX_train] = erro(train_set(:,5),pred_GDNOX_train);
[SSE_GDMEDV_train,RMS_GDMEDV_train] = erro(train_set(:,14),pred_GDMEDV_train);

[SSE_PINOX_test,RMS_PINOX_test] = erro(test_set(:,5),pred_PI_test(:,1));
[SSE_PIMEDV_test,RMS_PIMEDV_test] = erro(test_set(:,14),pred_PI_test(:,2));

[SSE_GDNOX_test,RMS_GDNOX_test] = erro(test_set(:,5),pred_GDNOX_test);
[SSE_GDMEDV_test,RMS_GDMEDV_test] = erro(test_set(:,14),pred_GDMEDV_test);

figure
subplot(2,2,1)
bar(categorical(["PI","GD"]),[RMS_PINOX_train,RMS_PINOX_test;RMS_GDNOX_train,RMS_GDNOX_test])
title("RMS NOX")
subplot(2,2,2)
bar(categorical(["PI","GD"]),[SSE_PINOX_train,SSE_PINOX_test;SSE_GDNOX_train,SSE_GDNOX_test])
title("SSE NOX")
legend('Train','Test')
subplot(2,2,3)
bar(categorical(["PI","GD"]),[RMS_PIMEDV_train,RMS_PIMEDV_test;RMS_GDMEDV_train,RMS_GDMEDV_test])
title("RMS MEDV")
subplot(2,2,4)
bar(categorical(["PI","GD"]),[SSE_PIMEDV_train,SSE_PIMEDV_test;SSE_GDMEDV_train,SSE_GDMEDV_test])
title("SSE MEDV")





