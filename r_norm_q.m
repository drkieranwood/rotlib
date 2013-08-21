function [ output_args ] = r_norm_q( in )
%R_NORM_Q Normalises a quarternion with no restrictions

output_args = in./(norm(in));

end %r_norm_q