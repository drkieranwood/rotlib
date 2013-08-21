function [ output_args ] = r_aa_to_e( in )
%AA_TO_E Convert a 4 element Angle-Axis into a triplet of Tait-Bryan angles
%(also called Euler angles)
%   The transformation described by a rotation in the range (-pi:pi] around
%   a unit norm axis is converted into three successive rotations around
%   independent axes in the 3-2-1 (z-y-x) order. This is the standard 
%   aerospace yaw-pitch-roll order. 
%  
%   The input must be [w x y z]' where w is the angle and [x y z]' is the
%   unit norm axis of rotation.
%
%   The output is a 3 element vector [phi theta psi]' where phi is the
%   roll, theta is the pitch, and psi is the yaw. Values are in the range
%   (-pi:pi] for roll and yaw, and (-pi/2:pi/2] for pitch.
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
temp2 = r_q_to_e(r_aa_to_q(temp));

%=============================================================
%POST CHECKS =================================================
%=============================================================
        
%Check the Euler Triplet is valid
output_args = r_check_e(temp2);

return;
end %r_aa_to_e