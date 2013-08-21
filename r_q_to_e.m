function [ output_args ] = r_q_to_e( in )
%Q_TO_E Convert Quarternion to Euler angles
%   Convert a 4 element quarternion rotation vector into a a 3 element
%   Euler angle vector. All rotations follow the right hand rule.
%   The quarterion must be given as [w,x,y,z]'
%
%   The input is a 4 element vector [w x y z]' with unit norm representing
%   the standard quarternion meanings (w is roughtly the angle, and [x y z]'
%   is roughly the axis).
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
        
%Check the Quarternion is valid
temp = r_check_q(in);

%=============================================================
%CONVERSION ==================================================
%=============================================================

%Convert using an intermediate quarternion
temp2 = r_dcm_to_e(r_q_to_dcm(temp));

%=============================================================
%POST CHECKS =================================================
%=============================================================
        
%Check the Euler Triplet is valid
output_args = r_check_e(temp2);


return;
end %r_q_to_e