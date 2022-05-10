%
%  COURSEWORK 1 | Prof. Alberto Paccanaro
%
% 
% Insert BELOW your function for exercise 2

function area = calcrectarea()

l = input('Insert your lenght (or vector of lenghts)');
w = input('Insert your width (or vector of widths');

if size(l) == size(w)
    area = l.*w;
else
    disp('Lenght and width vectors must be the same size');
    area = calcrectarea();
end

