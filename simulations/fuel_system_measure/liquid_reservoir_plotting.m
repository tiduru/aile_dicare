clear all

CO(:,:,1) = zeros(11); % red
CO(:,:,2) = ones(11); % green
CO(:,:,3) = ones(11); % blue


% plane
[x y] = meshgrid(0:0.1:1);
z = 0.414*x + 0.406;
figure()
surf(x,y,z,CO);
hold on 

%square
X = [0 1 1 0 0 0;1 1 0 0 1 1;1 1 0 0 1 1;0 1 1 0 0 0];
Y = [0 0 1 1 0 0;0 1 1 0 0 0;0 1 1 0 1 1;0 0 1 1 1 1];
Z = [0 0 0 0 0 1;0 0 0 0 0 1;1 1 1 1 0 1;1 1 1 1 0 1];
h=plot3(X,Y,Z,'k','linewidth',2);




