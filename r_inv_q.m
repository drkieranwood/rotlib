function [ output_args ] = r_inv_q( in )
%R_INV_Q Find conjugate inverse of a Quarternion

%Check the given vector is vertical and 3 elements
in = r_check_q(in);

output_args = [in(1) -in(2) -in(3) -in(4)]';

end %r_inv_q