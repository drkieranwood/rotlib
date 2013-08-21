function [ output_args ] = r_check_vec( in )
%CHECK_VEC Check the length of a vector is 3 elements and vertical.
%   Return the same vector if it is vertical with 3 elements. If it is
%   horizontal with three elements it is re-aligned with a warning. Else an
%   error is thrown.

%Create the empty ouput variable.
output_args = 0;

%Get matrix size
temp = size(in);

%Check it is 2D
if (length(temp)~=2)
    error('Vector has more than 2 dimensions.');
end

%Check if it is horizontal
if ( (temp(1)==1) && (temp(2)==3) )
    warning('KROTLIB:representation','Vector is a row vector. Converting to column vector now.');
    in = in';

%Check it has 3 elements
elseif ( (temp(1)~=3) || (temp(2)~=1 ))
    error('Vector is not 3x1.');
end

%If at this point then all tests have succeeded.
output_args = in;

return;
end %r_check_vec