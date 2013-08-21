function [ output_args ] = r_check_e( in )
%CHECK_E Check the Euler Triplet is valid.
%   The Euler triplet should be a 3 element vector with values in radians
%   in the range (-pi:pi].
%
%   Returns the same Euler triplet if everything is within tolerance.
%
%   Checks the vector has 3 elements.
%
%   Checks the angles have been given in radians, and puts into the range
%   (-pi:pi].
%
%   All rotations are for a right handed coordinate system. 
%   All angles are in radians.

%Create the empty ouput variable.
output_args = 0;

%Get matrix size
temp = size(in);

%Check it is 2D
if (length(temp)~=2)
    error('Euler Triplet has more than 2 dimensions.');
end

%Check if it is horizontal
if ( (temp(1)==1) && (temp(2)==3) )
    warning('KROTLIB:representation','Euler Triplet is a row vector. Consider converting to column vector.');

%Check it has 3 elements
elseif ( (temp(1)~=3) || (temp(2)~=1 ))
    error('Euler Triplet is not 3x1.');
end

%Check if the value of the angle exceeds 3*pi. If so it may indicate the
%argument is in degrees.
if ( ( abs(in(1))>(3*pi) ) || ( abs(in(1))>(3*pi) ) || ( abs(in(1))>(3*pi) ) )
    warning('KROTLIB:representation','Angle has values >3*pi. Is the input in radians?');
end


%Wrap the angles to the range (-pi:pi]
for ii=1:1:3
    if ( in(ii) >= 0 )
        %Remove superflous complete rotations
        in(ii) = mod( in(ii) , 2*pi);
        if ( in(ii) > pi )
            warning('KROTLIB:representation','Angle >pi. Wrapping to (-pi:pi].');
            in(ii) = in(ii) - (2*pi);
        end
    else
        %Remove superflous complete rotations
        in(ii) = mod( in(ii) , -2*pi);
        if ( in(ii) <= -pi )
            warning('KROTLIB:representation','Angle <=-pi. Wrapping to (-pi:pi].');
            in(ii) = in(ii) + (2*pi);
        end
    end
end

%If at this point then all tests have succeeded.
output_args = in;


return;
end %r_check_e