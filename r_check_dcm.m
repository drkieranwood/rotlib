function [ output_args ] = r_check_dcm( in )
%CHECK_DCM Check the Direction Cosine Matrix is valid.
%   The DCM should be a 3x3 matrix with its determinant exaxtly equal to +1
%   and orthagonal properties.
%
%   Returns the same DCM if everything is within tolerance.
%
%   Checks the matrix has 3x3 elements.
%
%   Checks if the determinant is far from +1. If it is close the matrix is
%   re-orthagonalised.
%
%   Checks the DCM is orthagonal
%
%   All rotations are for a right handed coordinate system. 
%   All angles are in radians.

%Create the empty ouput variable
output_args = 0;

%Get matrix size
temp = size(in);

%Check it is 2D
if (length(temp)~=2)
    error('DCM matrix has more than 2 dimensions.');
end

%Check it is 3x3
if ( (temp(1)~=3) || (temp(2)~=3) )
    error('DCM matrix is not 3x3.');
end

%Check it is special orthagonal to a tolerance (det(A)==1)
tol = r_load_tol;
temp = det(in);
if ( (temp<(1-tol)) || (temp>(1+tol)) )
    error('DCM matrix is not special orthagonal (det(A)==1).');    
end

%Check it is orthagonal
temp2 = sum(sum(in*in'));
if ( (temp2<(3-tol)) || (temp2>(3+tol)) )
    error('DCM matrix is not orthagonal (AA''~=I).');
end
    
%If the DCM is close to orthagonal then re-orthagonalise it
if (temp~=1)
    warning('KROTLIB:rounding','Matrix determinant~=1. Normalising Now.');
    [U S V] = svd(in);
    in = U*V';
end    

%If at this point then all tests have succeeded.
output_args = in;


return;
end %r_check_dcm