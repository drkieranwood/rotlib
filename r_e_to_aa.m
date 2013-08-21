function [ output_args ] = r_e_to_aa( in )
%E_TO_AA Convert the Euler Triplet into a 4 element Angle-Axis
%   Convert the transformation described by three successive rotations
%   around independent axes into a single rotation around a unit axis.
%
%   The input is a 3 element vector [phi theta psi]' where phi is the
%   roll, theta is the pitch, and psi is the yaw. Values are in the range
%   (-pi:pi] for roll, pitch, and yaw.
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
        
%Check the Euler Triplet is valid
temp = r_check_e(in);

%=============================================================
%CONVERSION ==================================================
%=============================================================

%Convert using an intermediate quarternion
temp2 = r_q_to_aa(r_e_to_q(temp));

%=============================================================
%POST CHECKS =================================================
%=============================================================
        
%Check the Angle-Axis is valid
output_args = r_check_aa(temp2);

return;
end %r_e_to_aa