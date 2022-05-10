function[prob_feature_per_class,classes,categorics_per_feature] = NBmodel(in, out)
%the function NBmodel take as an input "in" (datapoint in each row which features are
%from a discret set, it must be a string array) and 'out'(assign classes
%for every datapoint in 'in', must be a column). The outputs are 'classes'
%(a line where each element is a class from the dataset),
%'categorics_per_feature' (cell array where there is a cell for each
%feature of the datapoints, ant the cell contain the possible values of
%that features, and 'prob_feature_per_class'(a matrix where an element ij
%represent the probability of ocurrence of the feature i given a class j,
%the last column contain just the probability of ocurrence of the classj)

[m,n] = size(in);

classes = unique(out)';
prob_feature_per_class = []; 
categorics_per_feature = {};

for (i = 1:n)
   categorics_per_feature{i} = unique(in(:,i))'; 
end

for (i = 1:length(classes)) %to create each row of prob_feature_per_class
    aux = in(out == classes(i),:); %aux is a sample of 'in' with only the class i
    aux1 = [];
    for (j = 1:n)
        aux1 = [aux1 sum(aux(:,j)==unique(in(:,j))')]; %compute the sum of ocurrence of every category on every feature for the given class
    end
    prob_feature_per_class = [prob_feature_per_class; aux1];
end
prob_feature_per_class = [prob_feature_per_class./(sum(out==classes))', (1/m)*(sum(out==classes))'];
    