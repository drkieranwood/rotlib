function [ output_args ] = r_aa_to_dcm( in )
%AA_TO_DCM Convert a 4 element Angle-Axis into a Direction cosine matrix.
%   The transformation described by a rotation in the range (-pi:pi] around
%   a unit norm axis is converted to a 3x3 DCM matrix.
%
%   The input must be [w x y z]' where w is the angle and [x y z]' is the
%   unit norm axis of rotation.
%
%   The output is a 3x3 special orthogonal matrix.
%   
%   All rotations are for a right handed coordinate system. 
%   All angles are in radians.

%=============================================================
%PRE CHECKS ==================================================
%=============================================================

%Check the Angle-Axis is valid
temp = r_check_aa(in);

%=============================================================
%CONVERSION ==================================================
%=============================================================

%Convert using an intermediate quarternion
temp2 = r_q_to_dcm(r_aa_to_q(temp));

%=============================================================
%POST CHECKS =================================================
%=============================================================

%Check the DCM is valid
output_args = r_check_dcm(temp2);

return;
end %r_aa_to_dcm