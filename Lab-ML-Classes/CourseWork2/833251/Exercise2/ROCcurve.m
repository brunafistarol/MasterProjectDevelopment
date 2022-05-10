function ROCcurve(data, w_h1, w_h2, w_output)

features = normalize(data(:,1:end-1));
class = data(:, end);

S1 = features*w_h1;
Z1 = sigmoid(S1);
S2 = Z1*w_h2;
Z2 = sigmoid(S2);
S3 = Z2*w_output;
Z3 = sigmoid(S3);

[X, Y] = perfcurve(class, Z3, 1);
plot(X,Y)
xlabel('False positive rate') 
ylabel('True positive rate')
title('ROC for Classification by MLP')