function [ output_args ] = r_q_to_aa( in )
%Q_TO_AA Convert a 4 element unit Quarternion to a 4 element Angle-Axis
%   Convert the transformation described by the unit quaternion into a
%   rotation around a unit axis.
%
%   The input is a 4 element vector [w x y z]' with unit norm representing
%   the standard quarternion meanings (w is roughtly the angle, and [x y z]'
%   is roughly the axis).
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
        
%Check the Quarternion is valid
temp = r_check_q(in);

%=============================================================
%CONVERSION ==================================================
%=============================================================

%Find the angle
temp2(1,1) = 2*acos( temp(1) );

%Check for the 0 angle
tol = r_load_tol;
if ( abs(temp2(1,1)) < tol )
    %If the angle is small then set to zero and maintain the axis direction
    temp2(2,1) = temp(2);
    temp2(3,1) = temp(3);
    temp2(4,1) = temp(4);
    temp2(2:4) = temp(2:4)./norm(temp(2:4));
else
    %Else convert the axis
    temp2(2,1) = temp(2);
    temp2(3,1) = temp(3);
    temp2(4,1) = temp(4);
    temp2(2:4) = temp(2:4)./sin(0.5*(temp2(1,1)));
end

%=============================================================
%POST CHECKS =================================================
%=============================================================
        
%Check the Angle-Axis is valid
output_args = r_check_aa(temp2);

return;
end %r_q_to_aa