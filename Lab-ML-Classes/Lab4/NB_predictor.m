function[pred] = NB_predictor(in,prob_feature_per_class,classes,categorics_per_feature,loss_mod)
%it have as inputs what is already described in the NB_model function
%script, 'loss_mod' should be a column vector where each element is a
%weight to increment or decrease the probability of predicting a class in
%'classes'

 if ~exist('loss_mod','var')
     % sixth parameter does not exist, so default it to something
      loss_mod = ones(length(classes),1); %all the weights are the same
 end
[m,n] = size(in);
aux=[];
for (i = 1:n)
    aux = [aux, (in(i)==categorics_per_feature{i})]; %logic indicator for what features the point 'in' have
end
aux = logical([aux,1]);

[~,pos] = max(prod(prob_feature_per_class(:,aux),2).*loss_mod); %to choose the maximum probability
pred = classes(pos);