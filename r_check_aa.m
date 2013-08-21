function [ output_args ] = r_check_aa( in )
%CHECK_AA Check the Angle-Axis is valid
%   The input should be a 4 element vertical vector [w x y z]' where w is
%   the angle of rotation, and [x y z]' is a unit norm axis.
%
%   Returns the same Angle-Axis if everything is within tolerance.
%
%   Checks the input vector has 4 elements. If it is a row then a warning
%   is issued.
%
%   Checks the axis [x y z]' has unit norm. If far from unity then an 
%   error is thrown. If close to unity it is re-normalised.
%
%   Checks the angle has been given in radians, and puts into the range
%   (-pi:pi].
%
%   All rotations are for a right handed coordinate system. 
%   All angles are in radians.

%Create the empty ouput variable
output_args = 0;

%Get matrix size
temp = size(in);

%Check it is 2D
if (length(temp)~=2)
    error('Angle-Axis vector has more than 2 dimensions.');
end

%Check if it is horizontal
if ( (temp(1)==1) && (temp(2)==4) )
    warning('KROTLIB:representation','Angle-Axis is a row vector. Consider converting to column vector.');
    
%Check it has 4 elements
elseif ( (temp(1)~=4) || (temp(2)~=1) )
    error('Angle-Axis vector is not 4x1.');
end

%Check if the value of the angle exceeds 3*pi. If so it may indicate the
%argument is in degrees.
if ( abs(in(1)) > (3*pi) )
    warning('KROTLIB:representation','Angle has values >3*pi. Is the input in radians?');
end

%Check if the axis norm is far from unity
temp = norm(in(2:4));
tol = r_load_tol;
if ( (temp<(1-tol)) || (temp>(1+tol)) )
    error('Axis norm is far from unity.');    
end

%Wrap the angle to the range (-pi:pi]
if ( in(1) >= 0 )
    %Remove superflous complete rotations
    in(1) = mod( in(1) , 2*pi);
    if ( in(1) > pi )
        warning('KROTLIB:representation','Angle >pi. Wrapping to (-pi:pi].');
        in(1) = in(1) - (2*pi);
    end
else
    %Remove superflous complete rotations
    in(1) = mod( in(1) , -2*pi);
    if ( in(1) <= -pi )
        warning('KROTLIB:representation','Angle <=-pi. Wrapping to (-pi:pi].');
        in(1) = in(1) + (2*pi);
    end
end

%Check if axis is unity norm
if (temp~=1)
    warning('KROTLIB:rounding','Axis norm~=1. Normalising Now.');
    output_args = in;
    output_args(2:4) = in(2:4)./temp;
else 
    %If at this point then all tests have succeeded.
    output_args = in;
end


return;
end %r_check_aa