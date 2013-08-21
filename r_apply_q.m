function [ output_args ] = r_apply_q( vec , rot )
%R_APPLY_Q Rotate a vector by the given Quarternion

%Check the given vector is vertical and 3 elements
temp = r_check_vec(vec);

%Check the Quarternion is valid
ROTM_T = r_check_q(rot);

%Construct the augmented vector
U_T = [0;temp];

%Construct the conjugate inverse Quarternion
ROTM_TI = [ROTM_T(1);-ROTM_T(2:4)];

%TODO: This algrebra can be made much faster!
%Create the quarternion multiplication matrix
U_T2 = [U_T(1) -U_T(2) -U_T(3) -U_T(4);U_T(2) U_T(1) -U_T(4) U_T(3); U_T(3) U_T(4) U_T(1) -U_T(2); U_T(4) -U_T(3) U_T(2) U_T(1)];

%Apply the first rotation
temp2 = U_T2*ROTM_T;

%Create the quarternion multiplication matrix
ROTM_TI2 = [ROTM_TI(1) -ROTM_TI(2) -ROTM_TI(3) -ROTM_TI(4);ROTM_TI(2) ROTM_TI(1) -ROTM_TI(4) ROTM_TI(3); ROTM_TI(3) ROTM_TI(4) ROTM_TI(1) -ROTM_TI(2); ROTM_TI(4) -ROTM_TI(3) ROTM_TI(2) ROTM_TI(1)];

%Apply the second rotation
temp2 = ROTM_TI2*temp2;

%Strip the top 0
output_args = temp2(2:4);

end %r_apply_q