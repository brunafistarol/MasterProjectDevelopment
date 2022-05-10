function p = project(x, v)
%this function projects a set of points x on a subspace v

p = zeros(size(x));

for j = 1:size(v,2)
    p = p + ((x*v(:,j))'.*repmat(v(:,j), 1, size(x, 1)))';
end
