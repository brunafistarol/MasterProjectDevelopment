function [assigned_class] = hist_pred(input_data,input_vec,N,loss_mod)
%hist_pred assign a class to an input_vector based on histogram density
%estimation, the histogram is computed form input_data with N bins,
%loss_mod is the same than in predicted_class
class_labels = unique(input_data(:,end));
if ~exist('loss_mod','var')
    % fourth parameter does not exist, so default it to something
    loss_mod = ones(length(class_labels),1);
end

[m,n] = size(input_data);
set_points = input_data(:,1:end-1);
sup_lim = max(set_points); %vector with all the maximum values for each feature of the points
inf_lim = min(set_points); %vector with all the maximum values for each feature of the points
cat = floor(((N-1)./(sup_lim-inf_lim)).*(input_vec-sup_lim) + N); %map each feature of the input_vector into one of the N bins that belong to the interval of values of each feature
intervals = [inf_lim + (1/N)*(cat-1).*(sup_lim-inf_lim);inf_lim + (1/N)*cat.*(sup_lim-inf_lim)]; %compute the intervals where each feature of the input_vector belongs
classes_vol = input_data(all((set_points>=intervals(1,:)).*(set_points<=intervals(2,:)),2),n); %count all the points where all it's features are localized in the interval of interest for each class 
classes = unique(input_data(:,n));
pC = (histcounts([classes_vol;classes])-1).*histcounts(input_data(:,n));%count all the points where all it's features are localized in the interval of interest for each class 
[~,pos] = max(loss_mod'.*pC);
assigned_class = classes(pos);
end
