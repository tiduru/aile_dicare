%% Auteur : Antoine Henri
%% Titre: Cinematique inverse du banc de test
%% Projet: Aile d'icare
%% Date: 25 novembre 2021
clear all

%% Making transformation matrix between fixed reference frame F and mobile reference frame
%% Fixed reference frame is set at center of fixed plate
%% Mobile reference frame is set at center of mobile plate
% z: distance between both platform centers (mobile center is always
% directly above fixed center)
% phi: tilt angle
% theta: pitch angle


syms z theta phi 

R_xi_phi = Make_R(1, -phi)
R_yf_theta = Make_R(2, -theta)
% matrice de rotation entre les 2 vecteurs
R_f_m  = R_xi_phi*R_yf_theta

% hauteur entre les 2 plaques
FM_vect_f = [0;0;z];

%%

syms ax bx cx px qx rx ay by cy py qy ry 

% Verin AP
% Entre centre plaque fixe et ancrage bas verin, dans repere fixe
FA_vect_f = [ax;ay;0];
% Entre centre plaque mobile et ancrage haut verin, dans repere mobile
MP_vect_m = [px;py;0];
% vecteur entre les 2 ancrages, dans le repere fixe

AP_vect_f = FM_vect_f + R_f_m*MP_vect_m - FA_vect_f


% Verin BQ
% Entre centre plaque fixe et ancrage bas verin, dans repere fixe
FB_vect_f = [bx;by;0];
% Entre centre plaque mobile et ancrage haut verin, dans repere mobile
MQ_vect_m = [qx;qy;0];
% vecteur entre les 2 ancrages, dans le repere fixe

BQ_vect_f = FM_vect_f + R_f_m*MQ_vect_m - FB_vect_f

% Verin CR
% Entre centre plaque fixe et ancrage bas verin, dans repere fixe
FC_vect_f = [cx;cy;0];
% Entre centre plaque mobile et ancrage haut verin, dans repere mobile
MR_vect_m = [rx;ry;0];
% vecteur entre les 2 ancrages, dans le repere fixe

CR_vect_f = FM_vect_f + R_f_m*MR_vect_m - FC_vect_f

%% longueur de chaque verin

norme_AP_vect_f = simplify(norm(AP_vect_f))

norme_AP_vect_f = z^2+ax^2+ay^2+px^2+py^2+2*px*sin(theta)*(z*cos(phi)-ay*sin(phi))-2*py*(z*sin(phi)+ay*cos(phi))

