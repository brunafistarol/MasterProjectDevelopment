function [class_means, class_vars, class_prob,class_labels,class_data] = construct_dist(input_data)
%construct_dist have as an input (input_data) a matrix where each row
%contain a point and a class for that point in the last column

    [m,n] = size(input_data);
    class_labels = unique(input_data(:,n)); %vector with all the classes of the dataset
    n_classes = length(class_labels);
    class_mean = {};
    class_vars = {};
    class_prob = zeros(n_classes,1); %probability of ocurrence of each class based on their frquency
    for i = 1:n_classes
        
        class_tmp = input_data(input_data(:,n) == class_labels(i),:);
        class_means{i} = mean(class_tmp(:,1:n-1)); %compute the mean of each class
        class_vars{i} =  cov(class_tmp(:,1:n-1)); %compute the variance of each class
        class_prob(i) =  size(class_tmp,1)/m;
        class_data{i} = class_tmp(:,1:n-1); %save all the points for each class separately
            
    end
       
    

end