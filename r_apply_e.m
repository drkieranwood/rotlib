function [ output_args ] = r_apply_e( vec , rot )
%R_APPLY_E Rotate a vector by the given Euler Triplet

%Check the given vector is vertical and 3 elements
temp = r_check_vec(vec);

%Check the Euler Triplet is valid
rot = r_check_e(rot);

%Create three step by step rotation matrices
ROT_1 = [1 0 0;0 cos(rot(1)) sin(rot(1));0 -sin(rot(1)) cos(rot(1))];
ROT_2 = [cos(rot(2)) 0 -sin(rot(2));0 1 0;sin(rot(2))  0 cos(rot(2))];
ROT_3 = [cos(rot(3)) sin(rot(3)) 0;-sin(rot(3)) cos(rot(3)) 0 ;0 0 1];

%Then apply using normal matrix algebra
output_args = ROT_1*(ROT_2*(ROT_3*temp));

end %r_apply_e