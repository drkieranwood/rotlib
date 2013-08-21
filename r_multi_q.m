function [ output_args ] = r_multi_q( rot1 , rot2 )
%R_MULTI_Q Multiply two quarternions together

%Check the Quarternion is valid
rot1 = r_check_q(rot1);

%Check the Quarternion is valid
rot2 = r_check_q(rot2);

%TODO: This algrebra can be made much faster!
%Create the quarternion multiplication matrix
rotm = [rot1(1) -rot1(2) -rot1(3) -rot1(4);rot1(2) rot1(1) -rot1(4) rot1(3); rot1(3) rot1(4) rot1(1) -rot1(2); rot1(4) -rot1(3) rot1(2) rot1(1)];

%Multiply
temp2 = rotm*rot2;

output_args = r_check_q(temp2);

end %r_multi_q