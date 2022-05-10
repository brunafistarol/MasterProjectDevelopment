%
%  COURSEWORK 1 | Prof. Alberto Paccanaro
%
% 
% Insert BELOW your code for exercises 1, 5, 6, 7
% The templates for functions for exercises 2, 3 and 4 are provided in separate files.
%


%% ================== Exercise 1 ==================

%creating file
data = [1.2 1.4 1.8 1.3; 2.2 2.5 1.7 2.9];
save 'salesfigs.dat' data -ascii

%loading the file - a 2x4 matrix
load salesfigs.dat

%creating two vectors
v1 = salesfigs(1,:);
v2 = salesfigs(2,:);

%plotting
plot(v1, 'ko')
hold on
plot(v2, 'k*')
xlabel('Quarter')
ylabel('Sales (bilions)')
title('ABC Corporation Sales: 2013')
legend('Division A','Division B')
hold off
%% ================== Exercise 5 ==================

%generating 1000 points uniformly distributed
u = rand(2,1000)*15 + 20;

%plotting
plot(u(1,:), u(2,:), 'r*')
axis([-10 40 -5 40])
hold on
plot(randn(1,1000) + 3, randn(1,1000) + 3, 'b*')
hold off
%% ================== Exercise 6 ==================

%creating 3D point normally distributed
normal = randn(3,10000);

%checking which points are not positive and finding their columns
index = find(~sum(normal <= 0, 1));

%our new set of normalized values are:
normalp = normal(:, index);

%normalizing:
data = normalp./(sum(normalp.^2)).^(1/2);

%plotting
plot3(data(1,:), data(2,:), data(3,:), 'r*')


%% ================== Exercise 7 ==================

%creating data
x = linspace(0,15);
y = sin(2*x) + x/2 + 4; %function
xvec = 0:0.01:15;
noise = randn(1, size(xvec,2));
data = noise + sin(2*xvec) + xvec/2 + 4; %noisy data

%plotting
plot(xvec, data, 'r.') 
hold on
plot(x, y, 'y') 
set(gca,'Color','k') %black background

%plotting data centeriong in their mean
plot(xvec - mean(data), data - mean(data), 'c.')

%fitting the model
c = (xvec -mean(data))' .^ [0:1];
model = c \ (data - mean(data))';

%plotting on the original x
plot(x, model(2)*x + model(1), 'g')

%it is sufficient to sum a constant on the model above to center on
%original data. The constant is equal to mean(data)/2, because plotting on
%the original x already shifts the model to the upper right
plot(x, model(2)*x + model(1) + mean(data)/2, 'y')