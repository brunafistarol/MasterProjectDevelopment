function[points_train, points_test] = TvsT(input_data)

%separate input_data into a train set and a test set
[m,n] = size(input_data);
id = randperm(m, ceil(0.6*m)); %you could change the 0.5 in order to change the proportion between train and test sets
points_train = input_data(id,:);
points_test = input_data(setdiff(1:m,id),:);
end