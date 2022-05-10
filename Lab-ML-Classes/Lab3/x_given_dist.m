function [class_prob] = x_given_dist(point,class_mean,class_var)
%the function x_given_dist compute the probabilty that a point belongs to a
%certain probability distribution
    D = size(point,2);
    
    class_prob = exp(-1/2 * (point-class_mean) * inv(class_var) * (point-class_mean)') / ((2 * pi)^(D/2) * det(class_var)^(1/2));
    

end