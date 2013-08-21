function [ output_args ] = r_dcm_to_q( in )
%DCM_TO_Q Convert a 3x3 Direction Cosine Matrix into a 4 element Quarternion
%   The transformation described by the 3x3 DCM matrix is converted into a
%   4 element Quarternion.
%
%   The input must be a 3x3 special orthogonal matrix.
%
%   The output is a 4 element vector [w x y z]' with unit norm representing
%   the standard quarternion meanings (w is roughtly the angle, and [x y z]'
%   is roughly the axis).
%  
%   All rotations are for a right handed coordinate system. 
%   All angles are in radians.

%=============================================================
%PRE CHECKS ==================================================
%=============================================================
        
%Check the DCM is valid
temp = r_check_dcm(in);

%=============================================================
%CONVERSION ==================================================
%=============================================================

%Find the greatest quarternion element from the following
tempq0 = sqrt( 0.25*(1+temp(1,1)+temp(2,2)+temp(3,3)) );
tempq1 = sqrt( 0.25*(1+temp(1,1)-temp(2,2)-temp(3,3)) );
tempq2 = sqrt( 0.25*(1-temp(1,1)+temp(2,2)-temp(3,3)) );
tempq3 = sqrt( 0.25*(1-temp(1,1)-temp(2,2)+temp(3,3)) );

%Use the greatest element to calculate the others
if ( (tempq0>tempq1) && (tempq0>tempq2) && (tempq0>tempq3) )
    %q0 is the greatest
    temp2(1,1) = tempq0;
    temp2(2,1) = (0.25*(temp(2,3) - temp(3,2)))/tempq0;
    temp2(3,1) = (0.25*(temp(3,1) - temp(1,3)))/tempq0;
    temp2(4,1) = (0.25*(temp(1,2) - temp(2,1)))/tempq0;

elseif ( (tempq1>tempq2) && (tempq1>tempq3) )
    %have ruled out q0, so q1 must be greatest
    temp2(1,1) = (0.25*(temp(2,3) - temp(3,2)))/tempq1;
    temp2(2,1) = tempq1;
    temp2(3,1) = (0.25*(temp(1,2) + temp(2,1)))/tempq1;
    temp2(4,1) = (0.25*(temp(1,3) + temp(3,1)))/tempq1;

elseif ( (tempq2>tempq3) )
    %have ruled out q0 and q1, so q2 must be greatest
    temp2(1,1) = (0.25*(temp(3,1) - temp(1,3)))/tempq2;
    temp2(2,1) = (0.25*(temp(1,2) + temp(2,1)))/tempq2;
    temp2(3,1) = tempq2;
    temp2(4,1) = (0.25*(temp(2,3) + temp(3,2)))/tempq2;

else
    %have ruled out q0, q1, and q2, so q3 must be the greatest
    temp2(1,1) = (0.25*(temp(1,2) - temp(2,1)))/tempq3;
    temp2(2,1) = (0.25*(temp(1,3) + temp(3,1)))/tempq3;
    temp2(3,1) = (0.25*(temp(2,3) + temp(3,2)))/tempq3;
    temp2(4,1) = tempq3;

end

%=============================================================
%POST CHECKS =================================================
%=============================================================
        
%Check the Quarternion is valid
output_args = r_check_q(temp2);


return;
end %r_dcm_to_q