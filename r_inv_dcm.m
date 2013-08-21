function [ output_args ] = r_inv_dcm( in )
%R_INV_DCM Find the inverse of the Direction Cosine matrix

%Check the DCM is valid
in = r_check_dcm(in);

output_args = in';

end %r_inv_dcm