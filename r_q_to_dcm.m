function [ output_args ] = r_q_to_dcm( in )
%Q_TO_DCM Convert a 4 element unit Quarternion to a 3x3 Direction Cosine
%Matrix
%   Convert the transformation described by a unit quarternion into a DCM
%   matrix.
%
%   The input is a 4 element vector [w x y z]' with unit norm representing
%   the standard quarternion meanings (w is roughtly the angle, and [x y z]'
%   is roughly the axis).
%
%   The output is a 3x3 special orthogonal matrix.
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

temp2(1,1) = (temp(1)*temp(1)) + (temp(2)*temp(2)) - (temp(3)*temp(3)) - (temp(4)*temp(4));
temp2(1,2) = 2*( temp(2)*temp(3) + temp(1)*temp(4) );
temp2(1,3) = 2*( temp(2)*temp(4) - temp(1)*temp(3) );

temp2(2,1) = 2*( temp(2)*temp(3) - temp(1)*temp(4) );
temp2(2,2) = (temp(1)*temp(1)) - (temp(2)*temp(2)) + (temp(3)*temp(3)) - (temp(4)*temp(4));
temp2(2,3) = 2*( temp(3)*temp(4) + temp(1)*temp(2) );

temp2(3,1) = 2*( temp(2)*temp(4) + temp(1)*temp(3) );
temp2(3,2) = 2*( temp(3)*temp(4) - temp(1)*temp(2) );
temp2(3,3) = (temp(1)*temp(1)) - (temp(2)*temp(2)) - (temp(3)*temp(3)) + (temp(4)*temp(4));

%=============================================================
%POST CHECKS =================================================
%=============================================================

%Check the DCM is valid
output_args = r_check_dcm(temp2);


return;
end %r_q_to_dcm