%I use the Matlab's tool 'Importa Data', to save the data in car.csv into a
%string array 'car'

%split the car datset into trining and testing
[car_train, car_test] = TvsT(car);

[prob_feature_per_class,classes,categorics_per_feature] = NBmodel(car_train(:,1:end-1), car_train(:,end)); %train our model

pred_train=[]; %initialize the predictions over the trainig set
for(i=1:size(car_train,1))
pred_train = [pred_train; NB_predictor(car_train(i,1:end-1),prob_feature_per_class,classes,categorics_per_feature)];
end

pred_test=[]; %initialize the predictions over the testing set
for(i=1:size(car_test,1))
pred_test = [pred_test; NB_predictor(car_test(i,1:end-1),prob_feature_per_class,classes,categorics_per_feature)];
end

[acc_train,acc_perclass_train] = accuracy(car_train(:,7),pred_train);
[acc_test,acc_perclass_test] = accuracy(car_test(:,7),pred_test);

bar(categorical(["Overall","Acceptable","Good","Unacceptable","Very Good"]),[acc_train,acc_perclass_train;acc_test,acc_perclass_test]');
legend("Train","Test")
title("Accuracity")

%pls try using the 'loss_mod' to see how the accuracity change, keep in
%mind the number of data points for class.

%look at the precision formula in lab 3, try to implemented as a function
%and use it to evaluate this problem (precision help us to see how many predicted positives are actual positives)