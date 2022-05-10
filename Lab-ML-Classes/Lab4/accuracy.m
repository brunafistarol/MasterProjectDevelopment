function [acc,acc_perclass,classes] = accuracy(y,pred)
%the input y and pred should be columns, y are the actual (real) classes
%for each point meanwhile pred is a vector with the predcitions made for
%some model for the same points
acc = (1/length(y))*sum(y==pred); %proportion of the quantinty of well predicted points in general
classes = unique(y)';
acc_perclass = sum((y==classes)==(pred==classes))./length(y); %proportion of the quantinty of well predicted points in each class
end