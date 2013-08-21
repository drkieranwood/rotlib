function [ output_args ] = r_apply_aa( vec , rot )
%R_APPLY_AA Rotate a vector by the given Angle-Axis

%Check the given vector is vertical and 3 elements
temp = r_check_vec(vec);

%Check the Angle-Axis is valid
ROTM_T = r_check_aa(rot);

%Apply the rotation using Rodrigues' rotation formula
%NOTE: the change of sign of the angle: -ROTM_T(1)
output_args = temp*cos(-ROTM_T(1)) + (cross((ROTM_T(2:4)),temp))*sin(-ROTM_T(1)) + (ROTM_T(2:4))*(dot((ROTM_T(2:4)),temp))*(1-cos(-ROTM_T(1)));

end %r_apply_aa