function [assigned_class] = predicted_class(point,class_mean,class_var,class_prob,class_labels,loss_mod)

%this function predicted_class take as an imput a vector, parameters for a
%single gaussian density representation(class_mean,class_var and
%prob_class), and loss_mod is optional, it's function is to modify the
%values on the matrix loss function and should be a column vector with
%weights for each class in the dataset, low weights indicate than that
%class is less likely to be predicted
    if ~exist('loss_mod','var')
     % sixth parameter does not exist, so default it to something
      loss_mod = ones(length(class_labels),1); %all the weights are the same
    end
    point_prob_class = zeros(size(class_prob,1),1);
    for i = 1:size(class_prob,1)

        point_prob_class(i) = x_given_dist(point,class_mean{i},class_var{i}) * class_prob(i); %compute the probability for the point to belong to a class

    end
    
    [~,assigned_class_index] = max(loss_mod.*point_prob_class); %look for the position of the maximum probability
    assigned_class = class_labels(assigned_class_index); 

end