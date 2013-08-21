function [ output_args ] = r_check_q( in )
%CHECK_Q Check the Quarternion is valid
%   The input should be a 4 element vertical vector [w x y z]' where w is
%   (roughly) the angle of rotation, and [x y z]' is (roughly) the axis.
%
%   Returns the same Quarternion if everything is within tolerance.
%
%   Checks the input vector has 4 elements. If it is a row then a warning
%   is issued.
%
%   Checks the vector [w x y z]' has unit norm. If far from unity then an 
%   error is thrown. If close to unity it is re-normalised.
%
%   All rotations are for a right handed coordinate system. 
%   All angles are in radians.

%Create the empty ouput variable.
output_args = 0;

%Get matrix size
r_temp = size(in);

%Check it is 2D
if (length(r_temp)~=2)
    error('Quarternion has more than 2 dimensions.');
end

%Check if it is horizontal
if ( (r_temp(1)==1) && (r_temp(2)==4) )
    warning('KROTLIB:representation','Quarternion is a row vector. Consider converting to column vector.');
    
%Check it has 4 elements
elseif ( (r_temp(1)~=4) || (r_temp(2)~=1) )
    error('Quarternion vector is not 4x1.');
end

%Check if the norm is far from unity
clear r_temp;
r_temp = norm(in)-1;
tol = r_load_tol;
if ( abs(r_temp)>tol )
    error('Quarternion norm is far from unity.');    
end

%Check if Quarternion is unity norm
if (r_temp~=0)
    warning('KROTLIB:rounding','Quarternion norm~=1. Normalising Now.');
    output_args = in./norm(in);
else 
    %If at this point then all tests have succeeded.
    output_args = in;
end

return;
end %r_check_q