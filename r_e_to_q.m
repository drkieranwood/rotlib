function [ output_args ] = r_e_to_q( in )
%E_TO_Q Convert the Euler Triplet into a unit Quarternion
%   Convert the transformation described by three successive rotations
%   around independent axes into a 4 element unit quarternion.
%
%   The input is a 3 element vector [phi theta psi]' where phi is the
%   roll, theta is the pitch, and psi is the yaw. Values are in the range
%   (-pi:pi] for roll, pitch, and yaw.
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
        
%Check the Euler Triplet is valid
temp = r_check_e(in);

%=============================================================
%CONVERSION ==================================================
%=============================================================

%Make some temporary variables
s1 = sin(temp(1)/2);
s2 = sin(temp(2)/2);
s3 = sin(temp(3)/2);
c1 = cos(temp(1)/2);
c2 = cos(temp(2)/2);
c3 = cos(temp(3)/2);

%Find the quarternion elements
temp2(1,1) = c1*c2*c3 + s1*s2*s3;
temp2(2,1) = s1*c2*c3 - c1*s2*s3;
temp2(3,1) = c1*s2*c3 + s1*c2*s3;
temp2(4,1) = c1*c2*s3 - s1*s2*c3;

%=============================================================
%POST CHECKS =================================================
%=============================================================
        
%Check the Quarternion is valid
output_args = r_check_q(temp2);


return;
end %r_e_to_q