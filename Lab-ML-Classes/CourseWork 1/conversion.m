%
%  COURSEWORK 1 | Prof. Alberto Paccanaro
%
% 
% Insert BELOW your function for exercise 3


function conv = conversion()

unit = input("Insert unit measure ('f' for feet or 'm' for meter)", 's');
if unit == 'm'
    measure = input('Insert your measure (or a vector of them)');
    conv = measure*3.28084;
elseif unit == 'f'
    measure = input('Insert your measure (or a vector of them)');
    conv = measure*0.3048;
else
    disp('Invalid unit measure')
    conv = conversion();
end

    