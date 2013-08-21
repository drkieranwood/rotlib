function [ output_args ] = r_dcm_to_aa( in )
%DCM_TO_AA Convert a 3x3 Direction Cosine Matrix into a 4 element Angle-Axis.
%   The transformation described by the DCM matrix is converted into a
%   rotation in the range (-pi:pi] around a unit vector axis.
%
%   The input must be a 3x3 special orthogonal matrix.
%
%   The output is a 4 element vector [w x y z]' where w is the rotation
%   angle in the range (-pi:pi], and [x y z]' is the unit norm rotation
%   axis.
%   
%   All rotations are for a right handed coordinate system. 
%   All angles are in radians.

%=============================================================
%PRE CHECKS ==================================================
%=============================================================
        
%Check the DCM is valid
temp = r_check_dcm(in);

%=============================================================
%CONVERSION ==================================================
%=============================================================

%Convert using an intermediate quarternion
temp2 = r_q_to_aa(r_dcm_to_q(temp));

%=============================================================
%POST CHECKS =================================================
%=============================================================
        
%Check the Angle-Axis is valid
output_args = r_check_aa(temp2);

return;
end %r_dcm_to_aa