function [ output_args ] = r_apply_dcm( vec , rot )
%R_APPLY_DCM Rotate a vector by the given Direction Cosine Matrix

%Check the given vector is vertical and 3 elements
temp = r_check_vec(vec);

%Check the DCM is valid
ROTM_T = r_check_dcm(rot);

%Then apply using normal matrix algebra
output_args = ROTM_T*temp;

end %r_apply_dcm