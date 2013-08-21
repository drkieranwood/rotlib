function [ output_args ] = r_load_tol( in )
%LOAD_TOL Load the tolerances for the rotation conversions
%   The rotations library relies on vectors being unit length and comparing
%   values to +-1 for inverse trig functions. Due to computational rounding
%   errors the values can sometimes exceed +-1 leading to errors. For this
%   reason there are many tolerance checks. This function provides the
%   tolerance value to be used.

output_args = 0.0000001;

end %r_load_tol

