%
%  COURSEWORK 1 | Prof. Alberto Paccanaro
%
% 
% Insert BELOW your function for exercise 4

function values = evenodd(n)

v = randi(30,n);
v = v(1:2:n); %removing even positions

values = v(rem(v,2) == 0);

