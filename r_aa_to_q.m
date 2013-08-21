function [ output_args ] = r_aa_to_q( in )
%AA_TO_Q Convert a 4 element Angle-Axis into a unit Quarternion.
%   The transformation described by a rotation in the range (-pi:pi] around
%   a unit norm axis is converted into a 4 element unit Quarternion.
%  
%   The input must be [w x y z]' where w is the angle and [x y z]' is the
%   unit norm axis of rotation.
%
%   The output is a 4 element vector [w x y z]' with unit norm representing
%   the standard quarternion meanings (w is roughtly the angle, and [x y z]'
%   is roughly the axis).
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

temp2(1,1) =         cos(temp(1)/2);
temp2(2,1) = temp(2)*sin(temp(1)/2);
temp2(3,1) = temp(3)*sin(temp(1)/2);
temp2(4,1) = temp(4)*sin(temp(1)/2);

%=============================================================
%POST CHECKS =================================================
%=============================================================
        
%Check the Quarternion is valid
output_args = r_check_q(temp2);

return;
end %r_aa_to_q