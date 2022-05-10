clc;
clear;
%load the datasets, convert the table to an array
load("DensityEstimationDataset.mat")
GlassClassification = readtable('GlassClassification.csv');
GClass = table2array(GlassClassification);

%split both datasets into train-set and test-set
[D_train,D_test] = TvsT(DensityEstimationDataset);
[G_train,G_test] = TvsT(GClass);

%estimate the single gaussian representation for every class in both
%datasets
[class_means, class_vars, class_prob, class_labels,class_data] = construct_dist(D_train);
[G_class_means, G_class_vars, G_class_prob, G_class_labels,G_class_data] = construct_dist(G_train);
 
%lets take a look into our data
figure;
scatter(class_data{1}(:,1),class_data{1}(:,2));
hold on
scatter(class_data{2}(:,1),class_data{2}(:,2));
hold on;
scatter(class_data{3}(:,1),class_data{3}(:,2));
legend({'class 0','class 1 ','class 2'},'location',"northwest");
hold off
figure;
subplot(3,2,1)
scatter(G_class_data{1}(:,1),G_class_data{1}(:,2));
hold on
scatter(G_class_data{2}(:,1),G_class_data{2}(:,2));
legend({'class 0','class 1 ','class 2'},'location',"northwest");
subplot(3,2,2)
scatter(G_class_data{1}(:,1),G_class_data{1}(:,3));
hold on
scatter(G_class_data{2}(:,1),G_class_data{2}(:,3));
legend({'class 0','class 1 ','class 2'},'location',"northwest");
subplot(3,2,3)
scatter(G_class_data{1}(:,1),G_class_data{1}(:,4));
hold on
scatter(G_class_data{2}(:,1),G_class_data{2}(:,4));
legend({'class 0','class 1 ','class 2'},'location',"northwest");
subplot(3,2,4)
scatter(G_class_data{1}(:,2),G_class_data{1}(:,3));
hold on
scatter(G_class_data{2}(:,2),G_class_data{2}(:,3));
legend({'class 0','class 1 ','class 2'},'location',"northwest");
subplot(3,2,5)
scatter(G_class_data{1}(:,2),G_class_data{1}(:,4));
hold on
scatter(G_class_data{2}(:,2),G_class_data{2}(:,4));
legend({'class 0','class 1 ','class 2'},'location',"northwest");
subplot(3,2,6)
scatter(G_class_data{1}(:,3),G_class_data{1}(:,4));
hold on
scatter(G_class_data{2}(:,3),G_class_data{2}(:,4));
legend({'class 0','class 1 ','class 2'},'location',"northwest");
hold off

%in this case we will use the for bucle because the functions that estimate
%the classes works for an individual point and cant handle multiple points at once 
GDtest_pred = []; %prediction on the test set using single gaussian for the DensityEstimationDataset
GDtrain_pred = []; %prediction on the train set using single gaussian for the DensityEstimationDataset
for (i=1:size(D_test,1))
    GDtest_pred = [GDtest_pred predicted_class(D_test(i,1:end-1),class_means,class_vars,class_prob,class_labels)];
end
for (i=1:size(D_train,1))
    GDtrain_pred = [GDtrain_pred predicted_class(D_train(i,1:end-1),class_means,class_vars,class_prob,class_labels)];
end

GGtest_pred = []; %prediction on the test set using single gaussian for the GlassClassificationDataset
GGtrain_pred = []; %prediction on the train set using single gaussian for the GlassClassificationDataset
for (i=1:size(G_test,1))
    GGtest_pred = [GGtest_pred predicted_class(G_test(i,1:end-1),G_class_means,G_class_vars,G_class_prob,G_class_labels)];
end
for (i=1:size(G_train,1))
    GGtrain_pred = [GGtrain_pred predicted_class(G_train(i,1:end-1),G_class_means,G_class_vars,G_class_prob,G_class_labels)];
end

HDtest_pred = []; %prediction on the test set using the histogram for the DensityEstimationDataset
HDtrain_pred = []; %prediction on the train set using the histogram for the DensityEstimationDataset
for (i=1:size(D_test,1))
    HDtest_pred = [HDtest_pred hist_pred(D_train,D_test(i,1:end-1),5)];
end
for (i=1:size(D_train,1))
    HDtrain_pred = [HDtrain_pred hist_pred(D_train,D_train(i,1:end-1),5)];
end

HGtest_pred = []; %prediction on the test set using the histogram for the GlassClassificationDataset
HGtrain_pred = []; %prediction on the test set using the histogram for the GlassClassificationDataset
for (i=1:size(G_test,1))
    HGtest_pred = [HGtest_pred hist_pred(G_train,G_test(i,1:end-1),5)];
end
for (i=1:size(G_train,1))
    HGtrain_pred = [HGtrain_pred hist_pred(G_train,G_train(i,1:end-1),5)];
end

[a_GDTest,aperclass_GDTest] = accuracy(D_test(:,end),GDtest_pred');
[a_GDTrain,aperclass_GDTrain] = accuracy(D_train(:,end),GDtrain_pred');

[a_GGTest,aperclass_GGTest] = accuracy(G_test(:,end),GGtest_pred');
[a_GGTrain,aperclass_GGTrain] = accuracy(G_train(:,end),GGtrain_pred');

[a_HDTest,aperclass_HDTest] = accuracy(D_test(:,end),HDtest_pred');
[a_HDTrain,aperclass_HDTrain] = accuracy(D_train(:,end),HDtrain_pred');

[a_HGTest,aperclass_HGTest] = accuracy(G_test(:,end),HGtest_pred');
[a_HGTrain,aperclass_HGTrain] = accuracy(G_train(:,end),HGtrain_pred');

figure
subplot(2,2,1);
bar(categorical(["Overall","Class 0","Class 1","Class 2"]),([a_GDTest,aperclass_GDTest;a_GDTrain,aperclass_GDTrain])');
title("Accuracy: Single Gaussian for the DensityEstimationDataset");
ylim([0.5,1]);
subplot(2,2,2);
bar(categorical(["Overall","Class 0","Class 1","Class 2"]),([a_HDTest,aperclass_HDTest;a_HDTrain,aperclass_HDTrain])');
legend("Test","Train");
ylim([0.5,1]);
title("Accuracy: Histogram for the DensityEstimationDataset");
subplot(2,2,3);
bar(categorical(["Overall","Class 1","Class 2"]),([a_GGTest,aperclass_GGTest;a_GGTrain,aperclass_GGTrain])');
title("Accuracy: Single Gaussian for the GlassClassificationDataset");
ylim([0.5,1]);
subplot(2,2,4);
bar(categorical(["Overall","Class 1","Class 2"]),([a_HGTest,aperclass_HGTest;a_HGTrain,aperclass_HGTrain])');
ylim([0.5,1]);
title("Accuracy: Histogram for the GlassClassificationDataset");

%Example of the effect of chages in the loss matrix using the
%DensityEstimationDataset and the Single Gaussian Density Estimation

GDtest_pred_loss = []; %prediction on the test set using single gaussian for the DensityEstimationDataset
GDtrain_pred_loss = []; %prediction on the train set using single gaussian for the DensityEstimationDataset
loss_mod = [0.2;1;1]; %in this way the first class would be less likely to be predicted than with the original way
for (i=1:size(D_test,1))
    GDtest_pred_loss = [GDtest_pred_loss predicted_class(D_test(i,1:end-1),class_means,class_vars,class_prob,class_labels,loss_mod)];
end
for (i=1:size(D_train,1))
    GDtrain_pred_loss = [GDtrain_pred_loss predicted_class(D_train(i,1:end-1),class_means,class_vars,class_prob,class_labels,loss_mod)];
end
[a_GDTest_loss,aperclass_GDTest_loss] = accuracy(D_test(:,end),GDtest_pred_loss');
[a_GDTrain_loss,aperclass_GDTrain_loss] = accuracy(D_train(:,end),GDtrain_pred_loss');
prec_test = sum((D_test(:,end)==class_labels').*(GDtest_pred'==class_labels'))./sum(GDtest_pred'==class_labels'); %proportion of true predicted 0 over all the predicted 0s for the test set
prec_test_loss = sum((D_test(:,end)==class_labels').*(GDtest_pred_loss'==class_labels'))./sum(GDtest_pred_loss'==class_labels'); %proportion of true predicted 0 over all the predicted 0s for the lossvfor the test set
prec_train = sum((D_train(:,end)==class_labels').*(GDtrain_pred'==class_labels'))./sum(GDtrain_pred'==class_labels'); %proportion of true predicted 0 over all the predicted 0s for the train set
prec_train_loss = sum((D_train(:,end)==class_labels').*(GDtrain_pred_loss'==class_labels'))./sum(GDtrain_pred_loss'==class_labels'); %proportion of true predicted 0 over all the predicted 0s for the lossvfor the train set


%to apreciate the decreasing in accuracity and the increasing in te
%precition for the understimate class, in this case de class 0
figure
subplot(2,2,1);
bar(categorical(["Overall","Class 0","Class 1","Class 2"]),([a_GDTest,aperclass_GDTest;a_GDTrain,aperclass_GDTrain])');
ylim([0.6,1]); %to be able to apreciate the diferences
title("Accuracy: Single Gaussian for the DensityEstimationDataset");
legend("Test","Train");
subplot(2,2,2);
bar(categorical(["Overall","Class 0","Class 1","Class 2"]),([a_GDTest_loss,aperclass_GDTest_loss;a_GDTrain_loss,aperclass_GDTrain_loss])');
legend("Test","Train");
ylim([0.6,1]);
title("Accuracy: Single Gaussian for the DensityEstimationDataset understimating Class 0");
subplot(2,2,3);
bar(categorical(["Class 0","Class 1","Class 2"]),([prec_test;prec_test_loss])');
title("Precision: Single Gaussian on the Test Set for the GlassClassificationDataset");
ylim([0.6,1]);
legend("Normal","Class 0 understimated");
subplot(2,2,4);
bar(categorical(["Class 0","Class 1","Class 2"]),([prec_train;prec_train_loss])');
ylim([0.6,1]);
title("Precision: Single Gaussian on the Train Set for the GlassClassificationDataset understimating Class 0");
legend("Normal","Class 0 understimated");

