%% Auteur : Antoine Henri
%% Titre: Cinematique inverse du banc de test - V2
%% Projet: Aile d'icare
%% Date: 26 novembre 2021
clear all


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Based on : Dynamic Analysis of a Novel 3-PSP 3-DOF Parallel Manipulator, by Hao, Q.; Wang, L.; Guan, L. and Liu, X.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Making transformation matrix between fixed reference frame F and mobile reference frame
%% Fixed reference frame is set at center of fixed plate
%% Mobile reference frame is set at center of mobile plate

%% the values below are the ones we want to control
% z: distance between both platform centers (mobile center is always
% directly above fixed center)
% phi: tilt angle
% theta: torsion angle


syms z theta phi 
%% Rotation matrix between the two reference frames (using tilt and torsion angles)

ct = cos(theta);
st = sin(theta);
cp = cos(phi);
sp = sin(phi);
R_f_m  = [cp^2*ct+sp^2 sp*cp*(ct-1) cp*st;
    sp*cp*(ct-1) sp^2*ct+cp^2 sp*st;
    -st*cp -st*sp ct];

%% Temporary
syms R_11 R_12 R_13  R_21 R_22 R_23  R_31 R_32 R_33

R_f_m = [R_11 R_12 R_13;R_21 R_22 R_23;R_31 R_32 R_33];

%% The following variables are inherent to the geometry of the robot
% r_i: distance from fixed reference frame origin to point A_i 
% alpha_i: angle between reference frame x base vector to vector going from
% origin to point A_i/B_i (same for both reference frames)

syms r_0 r_1 r_2 alpha_0 alpha_1 alpha_2

ca_0 = cos(alpha_0);
sa_0 = sin(alpha_0);
ca_1 = cos(alpha_1);
sa_1 = sin(alpha_1);
ca_2 = cos(alpha_2);
sa_2 = sin(alpha_2);

FA0_vect_f = [r_0*ca_0; r_0*sa_0; 0];
FA1_vect_f = [r_1*ca_1; r_1*sa_1; 0];
FA2_vect_f = [r_2*ca_2; r_2*sa_2; 0];

MB0_vect_m_unit = [ca_0; sa_0; 0];
MB1_vect_m_unit = [ca_1; sa_2; 0];
MB2_vect_m_unit = [ca_1; sa_2; 0];

MB0_vect_f_unit = R_f_m * MB0_vect_m_unit;
MB1_vect_f_unit = R_f_m * MB1_vect_m_unit;
MB2_vect_f_unit = R_f_m * MB2_vect_m_unit;

%% Following variables are the poisition of the origin of the mobile reference frame relative to the fixed frame

syms x y
% also have to include z

FM_vect_f = [x; y; z];

A0M_vect_f = FM_vect_f - FA0_vect_f;
A1M_vect_f = FM_vect_f - FA1_vect_f;
A2M_vect_f = FM_vect_f - FA2_vect_f;

% this vector represents the direction of the three different actuators

A0B0_vect_f_unit = [0;0;1];
A1B1_vect_f_unit = [0;0;1];
A2B2_vect_f_unit = [0;0;1];


% To know if the vector along the actuator axis can be represented as a
% linear combination of the two others(aka our robot is physically possible 
% to make), we have to know if all three
% vectors are linearly indepedent, aka the matrix made from the three
% column vectors has a derterminant equal to zero
vector_dependency_mat_0 = [A0M_vect_f MB0_vect_f_unit A0B0_vect_f_unit];
vector_dependency_mat_1 = [A1M_vect_f MB1_vect_f_unit A1B1_vect_f_unit];
vector_dependency_mat_2 = [A2M_vect_f MB2_vect_f_unit A2B2_vect_f_unit];

det_vector_dependency_mat_0 = det(vector_dependency_mat_0);
det_vector_dependency_mat_1 = det(vector_dependency_mat_1);
det_vector_dependency_mat_2 = det(vector_dependency_mat_2);

eq_null_det_0 = det_vector_dependency_mat_0 == 0;
eq_null_det_1 = det_vector_dependency_mat_1 == 0;
eq_null_det_2 = det_vector_dependency_mat_2 == 0;

%% We now try to find the values of parasitic translational displacement of 
%% mobile reference frame relative to fixed reference frame in the form of 
%% values x and y

% we can take any of the two equations of the three, as the only unknowns
% are x and y

eqns_for_x_y = [eq_null_det_0, eq_null_det_1];
solution_x_y = solve(eqns_for_x_y,[x y]);

%% Now that we have equations for x and y, we must try and find norm of vectors between Bi and M, and norm of vector between
%% Ai and Bi (the actuator extensions)

% According to Dynamic Analysis of a Novel 3-PSP 3-DOF Parallel
% Manipulator,

i_vect_f = [1;0;0];
k_vect_f = [0;0;1];


norm_MB0_vect_f = -(dot(A0M_vect_f,i_vect_f))/(dot(MB0_vect_f_unit,i_vect_f));
norm_MB1_vect_f = -(dot(A1M_vect_f,i_vect_f))/(dot(MB1_vect_f_unit,i_vect_f));
norm_MB2_vect_f = -(dot(A2M_vect_f,i_vect_f))/(dot(MB2_vect_f_unit,i_vect_f));

norm_A0B0_vect_f = norm_MB0_vect_f*dot(MB0_vect_f_unit,k_vect_f)+z;
norm_A1B1_vect_f = norm_MB1_vect_f*dot(MB1_vect_f_unit,k_vect_f)+z;
norm_A2B2_vect_f = norm_MB2_vect_f*dot(MB2_vect_f_unit,k_vect_f)+z;


%% Test with values from Dynamic Analysis of a Novel 3-PSP 3-DOF Parallel Manipulator

%% TODO


