% Radius =2
R=0.05;
%Base at (2,0,1)
x0=0;y0=0;z0=0;
% Height = 10
h=1;
[x,y,z]=cylinder(R);
x_c1=x+x0;
y_c1=y+y0;
z_c1=z*h+z0;
% to plot
figure()
surf(x,y,z)
xlim([-1 1])
ylim([-1 1])

hold on
%Capteurs verticaux
%capteur 1
x_c1 = x - (1-0.4);
y_c1 = y - (1-0.4);
z_c1 = z;

surf(x_c1,y_c1,z_c1)

% %capteur 2
% x_c2 = x + ;
% y_c2 = y + ;
% z_c2 = z + ;
% 
% %capteur 3
% x_c3 = x + ;
% y_c3 = y + ;
% z_c3 = z + ;
% 
% %capteur 4
% x_c4 = x + ;
% y_c4 = y + ;
% z_c4 = z + ;