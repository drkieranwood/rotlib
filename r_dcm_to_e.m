function [ output_args ] = r_dcm_to_e( in )
%AA_TO_E Convert a 3x3 Direction Cosine Matrix into a triplet of Tait-Bryan
%angles (also called Euler angles)
%   The transformation described by the 3x3 DCM matrix is converted into 
%   three successive rotations around independent axes in the 3-2-1 (z-y-x) 
%   order. This is the standard aerospace yaw-pitch-roll order.
%
%   The input must be a 3x3 special orthogonal matrix.
%
%   The output is a 3 element vector [phi theta psi]' where phi is the
%   roll, theta is the pitch, and psi is the yaw. Values are in the range
%   (-pi:pi] for roll and yaw, and (-pi/2:pi/2] for pitch.
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

%Find a value for theta
theta = asin(-temp(1,3));

%Check if theta (pitch) is close to +-90 degrees
tol = r_load_tol;
if ( abs(cos(theta)) > tol ) 
    %If not too close to +-90 then find phi and psi (roll and yaw)
    phi = atan2( temp(2,3) , temp(3,3) );
    psi = atan2( temp(1,2) , temp(1,1) );
    temp2 = [phi theta psi]';
    
elseif ( (temp(1,3)<(-1+tol)) && (temp(1,3)>(-1-tol)) )     
    %If theta is at 90 then set phi=0, theta=pi/2, and calculate psi
    phi = 0;
    theta = pi/2;
    psi = atan2(-temp(2,1),temp(3,1));
    temp2 = [phi theta psi]';
    warning('KROTLIB:representation','Gimbal lock detected. Pitch=(pi/2).');
    
else                                    
    %If theta is at -90 then set phi=0, theta=-pi/2, and calculate psi
    phi = 0;
    theta = -pi/2;
    psi = atan2(-temp(2,1),temp(3,1));
    temp2 = [phi theta psi]';
    warning('KROTLIB:representation','Gimbal lock detected. Pitch=(-pi/2).');
    
end

%=============================================================
%POST CHECKS =================================================
%=============================================================
        
%Check the Euler Triplet is valid
output_args = r_check_e(temp2);

return;
end %r_dcm_to_e