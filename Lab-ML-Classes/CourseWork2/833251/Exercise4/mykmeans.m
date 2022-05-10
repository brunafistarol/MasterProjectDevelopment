function [C, V] = mykmeans(Data, k, t)

%assuming that we loaded 'DataForKmeans.mat' in command window

m = size(Data, 1); %useful
C = Data(randperm(size(Data, 1), k), :); %initial values to centroids
V = zeros(m, 1); %specify the cluster to which each point belongs
dist = []; %function that is being minimized by k-means
dist_centroids = inf; %relative change in the position of the centroids between two successive iterations

while dist_centroids > t
    %choose a centroid to associate to each point
    for i = 1:m
        [~, V(i,1)] = min(sum((repmat(Data(i,:), k, 1)-C).^2, 2).^0.5);
    end
    
    prev = C;
    dist = [dist 0]; % keeping sum of distances between a point and it cluster
    
    %redefining the clusters and calculating dist
    for i=1:k
        dist(end) = dist(end) + sum(sum((Data(V==i, :) - repmat(C(i, :), size(Data(V==i, :), 1), 1)).^2).^0.5);
        C(i, :) = mean(Data(V==i, :));
    end
    
    %calculating relative distance of the centroids between two successive iterations
    dist_centroids = (sum((prev - C).^2)).^0.5;
end

%ploting dist
figure()
plot(dist)
ylabel('Error'); xlabel('Iteration')

%ploting k-means
figure()
hold on;
for i = 1:k
    plot(Data(V == i, 1), Data(V == i, 2), '.')
end
plot(C(:,1),C(:,2),'k*', 'MarkerSize', 10)
hold off;
