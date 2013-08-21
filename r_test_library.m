%This is a script to test the functions in the rotation library. There are
%three parts. The first checks the conversions between rotation realisations
%and the second tests the application of the rotations. The third uses the
%popular SpinCalc library as a third party check.

%The success of Part3 shows the transformation between types is working by
%verifying using an external 3rd party library.

%The success of Part2 shows the transformations and their application is
%working by using independent methods. 
%--Euler applied using three successive 1D transforms
%--DCM by direct matrix multiplication
%--Quarternions using the quarternion algrbra
%--AngleAxis applied using Rodrigues formulation

clc;
format long;
warning('off','KROTLIB:rounding');

%Which tests should be performed
part1_on = 1;
part1_euler = 1;
part1_quart = 1;
part1_axisa = 1;

part2_on = 1;
part2_euler = 1;
part2_aa = 1;
part2_q = 1;

part3_on = 1;
part3_euler = 1;
part3_quart = 1;
part3_axisa = 1;

%If random_on==1 then the Euler angles, quarternions, and angle-axis
%representations will be randomly generated.
random_on = 1;

%Tolerance for conversion differences
tol = 0.000000000000001;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PART 0: Create test input rotations (manual/random)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~random_on
    %Manually entered Euler angles
    %=============================
    phi = 0*(pi/180);
    theta = -89.5*(pi/180);
    psi = 90*(pi/180);
    
    a = -pi;
    b = pi;
    phi = a + (b-a).*rand(1,1);
    psi = a + (b-a).*rand(1,1);
    
    %Convert to other representations
    E = [phi;theta;psi];
    Q = r_e_to_q(E);
    AA = r_e_to_aa(E);
    DCM = r_e_to_dcm(E);
    
    %Vector to be rotated
    vec_t = [1;0;0];

else
    %Randomly generated rotations
    %============================
    %Euler
    a = -pi;
    b = pi;
    phi = a + (b-a).*rand(1,1);
    theta = a/2 + (b/2-a/2).*rand(1,1);
    psi = a + (b-a).*rand(1,1);
    E = [phi;theta;psi];
     
    %Quarternion
    a = -1;
    b = 1;
    Q(1,1) = a + (b-a).*rand(1,1);
    Q(2,1) = a + (b-a).*rand(1,1);
    Q(3,1) = a + (b-a).*rand(1,1);
    Q(4,1) = a + (b-a).*rand(1,1);
    Q = Q./norm(Q);
    
    %Angle-Axis
    a = -pi;
    b = pi;
    AA(1,1) = a + (b-a).*rand(1,1);
    AA(2,1) = a + (b-a).*rand(1,1);
    AA(3,1) = a + (b-a).*rand(1,1);
    AA(4,1) = a + (b-a).*rand(1,1);
    AA(2:4) = AA(2:4)./norm(AA(2:4)); 
    
    %Create a random vector to be rotated
    a=-10;
    b=10;
    x = a + (b-a).*rand(1,1);
    y = a + (b-a).*rand(1,1);
    z = a + (b-a).*rand(1,1);
    vec_t = [x;y;z];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PART 1: Test the raw transformations between representations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if part1_on
    %=============
    if part1_euler
        %Header text
        disp(' ');
        disp('1:1 - Euler to others and back');
        disp('              Phi       Theta     Psi      (diff)');
        disp(['Input Euler:  ' num2str(E(1)) '  ' num2str(E(2)) '  ' num2str(E(3))]);

        %Euler to other types and back
        dcm_temp = r_dcm_to_e( r_e_to_dcm(r_dcm_to_e( r_e_to_dcm(E) )));
        diff1 = sum(E - dcm_temp);
        diff1 = roundEpsilon(diff1,tol);
        disp(['DCM and Back: ' num2str(dcm_temp(1)) '  ' num2str(dcm_temp(2)) '  ' num2str(dcm_temp(3)) '  ' num2str(diff1)]);

        q_temp = r_q_to_e( r_e_to_q(r_q_to_e( r_e_to_q(E) )));
        diff2 = sum(E - q_temp);
        diff2 = roundEpsilon(diff2,tol);
        disp(['Q and Back:   ' num2str(q_temp(1)) '  ' num2str(q_temp(2)) '  ' num2str(q_temp(3)) '  ' num2str(diff2)]);

        aa_temp = r_aa_to_e( r_e_to_aa(r_aa_to_e( r_e_to_aa(E) )));
        diff3 = sum(E - aa_temp);
        diff3 = roundEpsilon(diff3,tol);
        disp(['AA and Back:  ' num2str(aa_temp(1)) '  ' num2str(aa_temp(2)) '  ' num2str(aa_temp(3)) '  ' num2str(diff3)]);
        
        if ((abs(diff1)>tol)||(abs(diff2)>tol)||(abs(diff3)>tol))
            disp('WARNING WARNING WARNING: Part 1 Euler');
        end
    end
    
    %=============
    if part1_quart
        %Header text
        disp(' ');
        disp('1:2 - Q to others and back');
        disp('               1        2        3        4');
        disp(['Input Q:     ' num2str(Q(1)) '  ' num2str(Q(2)) '  ' num2str(Q(3)) '  ' num2str(Q(4))]);

        %Quarternion to others and back
        dcm_temp = r_dcm_to_q( r_q_to_dcm(r_dcm_to_q( r_q_to_dcm(Q) )));
        diff1 = sum(abs(Q)-abs(dcm_temp));
        diff1 = roundEpsilon(diff1,tol);
        disp(['DCM and Back: ' num2str(dcm_temp(1)) '  ' num2str(dcm_temp(2)) '  ' num2str(dcm_temp(3)) '  ' num2str(dcm_temp(4)) '  ' num2str(diff1)]);

        e_temp = r_e_to_q( r_q_to_e(r_e_to_q( r_q_to_e(Q) )));
        diff2 = sum(abs(Q)-abs(e_temp));
        diff2 = roundEpsilon(diff2,tol);
        disp(['E and Back:   ' num2str(e_temp(1)) '  ' num2str(e_temp(2)) '  ' num2str(e_temp(3)) '  ' num2str(e_temp(4)) '  ' num2str(diff2)]);

        aa_temp = r_aa_to_q( r_q_to_aa(r_aa_to_q( r_q_to_aa(Q) )));
        diff3 = sum(abs(Q)-abs(aa_temp));
        diff3 = roundEpsilon(diff3,tol);
        disp(['AA and Back:  ' num2str(aa_temp(1)) '  ' num2str(aa_temp(2)) '  ' num2str(aa_temp(3)) '  ' num2str(aa_temp(4)) '  ' num2str(diff3)]);
        
        if ((abs(diff1)>tol)||(abs(diff2)>tol)||(abs(diff3)>tol))
            disp('WARNING WARNING WARNING: Part 1 Quarternions');
        end
    end
    
    %=============
    if part1_axisa
        %Header text
        disp(' ');
        disp('1:3 - AA to others and back');
        disp('               1        2        3        4');
        disp(['Input AA:     ' num2str(AA(1)) '  ' num2str(AA(2)) '  ' num2str(AA(3)) '  ' num2str(AA(4))]);

        %Axis angle to others and back
        dcm_temp = r_dcm_to_aa( r_aa_to_dcm(r_dcm_to_aa( r_aa_to_dcm(AA) )));
        diff1 = sum(abs(AA)-abs(dcm_temp));
        diff1 = roundEpsilon(diff1,tol);
        disp(['DCM and Back:  ' num2str(dcm_temp(1)) '  ' num2str(dcm_temp(2)) '  ' num2str(dcm_temp(3)) '  ' num2str(dcm_temp(4)) '  ' num2str(diff1)]);

        e_temp = r_e_to_aa( r_aa_to_e(r_e_to_aa( r_aa_to_e(AA) )));
        diff2 = sum(abs(AA)-abs(e_temp));
        diff2 = roundEpsilon(diff2,tol);
        disp(['E and Back:    ' num2str(e_temp(1)) '  ' num2str(e_temp(2)) '  ' num2str(e_temp(3)) '  ' num2str(e_temp(4)) '  ' num2str(diff2)]);

        q_temp = r_q_to_aa( r_aa_to_q(r_q_to_aa( r_aa_to_q(AA) )));
        diff3 = sum(abs(AA)-abs(q_temp));
        diff3 = roundEpsilon(diff3,tol);
        disp(['Q and Back:    ' num2str(q_temp(1)) '  ' num2str(q_temp(2)) '  ' num2str(q_temp(3)) '  ' num2str(q_temp(4)) '  ' num2str(diff3)]);
        
        if ((abs(diff1)>tol)||(abs(diff2)>tol)||(abs(diff3)>tol))
            disp('WARNING WARNING WARNING: Part 1 Angle Axis');
        end
    end
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PART 2: Test the application of the representations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if part2_on
    
    %=============
    if part2_euler
        %Header text
        disp(' ');
        disp('2:1 - Application from Euler');
        disp('        x        y        z       norm diff');
        
        %Retrieve the Euler triplet and use it to define the other rotations
        EULER_R = E;
        Q_R   = r_e_to_q(EULER_R);
        AA_R  = r_e_to_aa(EULER_R);
        DCM_R = r_e_to_dcm(EULER_R);

        %Apply the rotations
        temp_e2   = r_apply_e(vec_t,EULER_R);
        temp_q2   = r_apply_q(vec_t,Q_R);
        temp_aa2  = r_apply_aa(vec_t,AA_R);
        temp_dcm2 = r_apply_dcm(vec_t,DCM_R);
        
        temp_e2 = roundEpsilon(temp_e2,tol);
        temp_q2 = roundEpsilon(temp_q2,tol);
        temp_aa2 = roundEpsilon(temp_aa2,tol);
        temp_dcm2 = roundEpsilon(temp_dcm2,tol);

        %Display the results
        disp(['Euler: ' num2str(temp_e2(1)) '  ' num2str(temp_e2(2)) '  ' num2str(temp_e2(3)) '  ' num2str((norm(temp_e2)-norm(vec_t)))]);
        disp(['Quart: ' num2str(temp_q2(1)) '  ' num2str(temp_q2(2)) '  ' num2str(temp_q2(3)) '  ' num2str((norm(temp_q2)-norm(vec_t)))]);
        disp(['AngAx: ' num2str(temp_aa2(1)) '  ' num2str(temp_aa2(2)) '  ' num2str(temp_aa2(3)) '  ' num2str((norm(temp_aa2)-norm(vec_t)))]);
        disp(['DCM  : ' num2str(temp_dcm2(1)) '  ' num2str(temp_dcm2(2)) '  ' num2str(temp_dcm2(3)) '  ' num2str((norm(temp_dcm2)-norm(vec_t)))]);
    end
    
    %==========
    if part2_aa
        %Header text
        disp(' ');
        disp('2:2 - Application from Axis angle');
        disp('        x        y        z       norm diff');
        
        %Retrieve the Angle Axis vector and use it to define the other rotations
        EULER_R = r_aa_to_e(AA);
        Q_R = r_aa_to_q(AA);
        AA_R = AA;
        DCM_R = r_aa_to_dcm(AA);

        %Apply the rotations
        temp_e2   = r_apply_e(vec_t,EULER_R);
        temp_q2   = r_apply_q(vec_t,Q_R);
        temp_aa2  = r_apply_aa(vec_t,AA_R);
        temp_dcm2 = r_apply_dcm(vec_t,DCM_R);
        
        temp_e2 = roundEpsilon(temp_e2,tol);
        temp_q2 = roundEpsilon(temp_q2,tol);
        temp_aa2 = roundEpsilon(temp_aa2,tol);
        temp_dcm2 = roundEpsilon(temp_dcm2,tol);

        %Display the results
        disp(['Euler: ' num2str(temp_e2(1)) '  ' num2str(temp_e2(2)) '  ' num2str(temp_e2(3)) '  ' num2str((norm(temp_e2)-norm(vec_t)))]);
        disp(['Quart: ' num2str(temp_q2(1)) '  ' num2str(temp_q2(2)) '  ' num2str(temp_q2(3)) '  ' num2str((norm(temp_q2)-norm(vec_t)))]);
        disp(['AngAx: ' num2str(temp_aa2(1)) '  ' num2str(temp_aa2(2)) '  ' num2str(temp_aa2(3)) '  ' num2str((norm(temp_aa2)-norm(vec_t)))]);
        disp(['DCM  : ' num2str(temp_dcm2(1)) '  ' num2str(temp_dcm2(2)) '  ' num2str(temp_dcm2(3)) '  ' num2str((norm(temp_dcm2)-norm(vec_t)))]);
    end
    
    %=========
    if part2_q
        %Header text
        disp(' ');
        disp('2:3 - Application from quarternion');
        disp('        x        y        z       norm diff');
        
        %Retrieve the Quarternion and use it to define the other rotations
        EULER_R = r_q_to_e(Q);
        Q_R = Q;
        AA_R = r_q_to_aa(Q);
        DCM_R = r_q_to_dcm(Q);

        %Apply the rotations
        temp_e2   = r_apply_e(vec_t,EULER_R);
        temp_q2   = r_apply_q(vec_t,Q_R);
        temp_aa2  = r_apply_aa(vec_t,AA_R);
        temp_dcm2 = r_apply_dcm(vec_t,DCM_R);
        
        temp_e2 = roundEpsilon(temp_e2,tol);
        temp_q2 = roundEpsilon(temp_q2,tol);
        temp_aa2 = roundEpsilon(temp_aa2,tol);
        temp_dcm2 = roundEpsilon(temp_dcm2,tol);

        %Display the results
        disp(['Euler: ' num2str(temp_e2(1)) '  ' num2str(temp_e2(2)) '  ' num2str(temp_e2(3)) '  ' num2str((norm(temp_e2)-norm(vec_t)))]);
        disp(['Quart: ' num2str(temp_q2(1)) '  ' num2str(temp_q2(2)) '  ' num2str(temp_q2(3)) '  ' num2str((norm(temp_q2)-norm(vec_t)))]);
        disp(['AngAx: ' num2str(temp_aa2(1)) '  ' num2str(temp_aa2(2)) '  ' num2str(temp_aa2(3)) '  ' num2str((norm(temp_aa2)-norm(vec_t)))]);
        disp(['DCM  : ' num2str(temp_dcm2(1)) '  ' num2str(temp_dcm2(2)) '  ' num2str(temp_dcm2(3)) '  ' num2str((norm(temp_dcm2)-norm(vec_t)))]);
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PART 3: External Library
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if part3_on
    
%=============
    if part3_euler
        %Header text
        disp(' ');
        disp('3:1 - Euler to others');

        temp_q1   = r_e_to_q(E);
        temp_dcm1 = r_e_to_dcm(E);
        temp_aa1  = r_e_to_aa(E);
        
        Etemp = (180/pi)*[E(3) E(2) E(1)];
        
        temp_q2   = SpinCalc('EA321toQ',Etemp,tol,1);
        temp = temp_q2;
        temp_q2 = [temp(4) temp(1) temp(2) temp(3)];
        
        temp_dcm2 = SpinCalc('EA321toDCM',Etemp,tol,1);
        
        temp_aa2  = SpinCalc('EA321toEV',Etemp,tol,1);
        temp_aa2(4) = temp_aa2(4)*(pi/180);
        temp = temp_aa2;
        temp_aa2 = [temp(4) temp(1) temp(2) temp(3)];
        
        diff1 = temp_q1 - temp_q2';
        diff2 = temp_dcm1 - temp_dcm2;
        diff3 = temp_aa1 - temp_aa2';
        
        diff1 = roundEpsilon(diff1,tol);
        diff2 = roundEpsilon(diff2,tol);
        diff3 = roundEpsilon(diff3,tol);
        
        disp(['Quart: ' num2str(diff1(1)) '  ' num2str(diff1(2)) '  ' num2str(diff1(3)) '  ' num2str(diff1(4))]);
        disp(['DCM  : ' num2str(sum(sum(diff2)))]);
        disp(['AngAx: ' num2str(diff3(1)) '  ' num2str(diff3(2)) '  ' num2str(diff3(3)) '  ' num2str(diff3(4))]);
    end
    
    %=============
    if part3_quart
        %Header text
        disp(' ');
        disp('3:2 - Q to others');

        temp_e1   = r_q_to_e(Q);
        temp_dcm1 = r_q_to_dcm(Q);
        temp_aa1  = r_q_to_aa(Q);
        
        Qtemp = [Q(2) Q(3) Q(4) Q(1)];
        
        temp_e2   = SpinCalc('QtoEA321',Qtemp,tol,1);
        temp = temp_e2;
        temp_e2 = (pi/180)*[temp(3) temp(2) temp(1)];
        
        temp_dcm2 = SpinCalc('QtoDCM',Qtemp,tol,1);
        
        temp_aa2  = SpinCalc('QtoEV',Qtemp,tol,1);
        temp_aa2(4) = temp_aa2(4)*(pi/180);
        temp = temp_aa2;
        temp_aa2 = [temp(4) temp(1) temp(2) temp(3)];
        
        diff1 = temp_e1 - temp_e2';
        diff2 = temp_dcm1 - temp_dcm2;
        diff3 = temp_aa1 - temp_aa2';
        
        diff1 = roundEpsilon(diff1,tol);
        diff2 = roundEpsilon(diff2,tol);
        diff3 = roundEpsilon(diff3,tol);
        
        disp(['Eluer: ' num2str(diff1(1)) '  ' num2str(diff1(2)) '  ' num2str(diff1(3))]);
        disp(['DCM  : ' num2str(sum(sum(diff2)))]);
        disp(['AngAx: ' num2str(diff3(1)) '  ' num2str(diff3(2)) '  ' num2str(diff3(3)) '  ' num2str(diff3(4))]);

    end
    
    %=============
    if part3_axisa
        %Header text
        disp(' ');
        disp('3:3 - AA to others');

        temp_e1   = r_aa_to_e(AA);
        temp_dcm1 = r_aa_to_dcm(AA);
        temp_q1  = r_aa_to_q(AA);
        
        AAtemp = [AA(2) AA(3) AA(4) (180/pi)*AA(1)];
        if AAtemp(4)<0
            AAtemp(4) = 360 + AAtemp(4);
        end
        
        temp_e2   = SpinCalc('EVtoEA321',AAtemp,tol,1);
        temp = temp_e2;
        temp_e2 = (pi/180)*[temp(3) temp(2) temp(1)];
        
        temp_dcm2 = SpinCalc('EVtoDCM',AAtemp,tol,1);
        
        temp_q2  = SpinCalc('EVtoQ',AAtemp,tol,1);
        temp = temp_q2;
        temp_q2 = [temp(4) temp(1) temp(2) temp(3)];
        
        diff1 = temp_e1 - temp_e2';
        diff2 = temp_dcm1 - temp_dcm2;
        diff3 = abs(temp_q1) - abs(temp_q2)';
        
        diff1 = roundEpsilon(diff1,tol);
        diff2 = roundEpsilon(diff2,tol);
        diff3 = roundEpsilon(diff3,tol);
        
        disp(['Eluer: ' num2str(diff1(1)) '  ' num2str(diff1(2)) '  ' num2str(diff1(3))]);
        disp(['DCM  : ' num2str(sum(sum(diff2)))]);
        disp(['Quart: ' num2str(diff3(1)) '  ' num2str(diff3(2)) '  ' num2str(diff3(3)) '  ' num2str(diff3(4))]);

    end
    
end


warning('on','KROTLIB:rounding');
format short;