function [ output_args ] = r_e_to_dcm( in )
%E_TO_DCM Convert the Euler Triplet into a 3x3 Direction Cosine Matrix
%   Convert the transformation described by three successive rotations
%   around independent axes into a single 3x3 DCM matrix.
%
%   The input is a 3 element vector [phi theta psi]' where phi is the
%   roll, theta is the pitch, and psi is the yaw. Values are in the range
%   (-pi:pi] for roll, pitch, and yaw.
%
%   The output is a 3x3 special orthogonal matrix.
%   
%   All rotations are for a right handed coordinate system. 
%   All angles are in radians.

%=============================================================
%PRE CHECKS ==================================================
%=============================================================
        
%Check the Euler Triplet is valid
temp = r_check_e(in);

%=============================================================
%CONVERSION ==================================================
%=============================================================

%Make some temporary variables
s1 = sin(in(1));
s2 = sin(in(2));
s3 = sin(in(3));
c1 = cos(in(1));
c2 = cos(in(2));
c3 = cos(in(3));

%Find the matrix elements
temp2(1,1) = c2*c3;
temp2(1,2) = c2*s3;
temp2(1,3) = -s2;

temp2(2,1) = s1*s2*c3 - c1*s3;
temp2(2,2) = s1*s2*s3 + c1*c3;
temp2(2,3) = s1*c2;

temp2(3,1) = c1*s2*c3 + s1*s3;
temp2(3,2) = c1*s2*s3 - s1*c3;
temp2(3,3) = c1*c2;

%=============================================================
%POST CHECKS =================================================
%=============================================================

%Check the DCM is valid
output_args = r_check_dcm(temp2);

return;
end %r_e_to_dcm