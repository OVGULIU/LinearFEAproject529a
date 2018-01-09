% read files
clear all
clc
load FEA3DS8_node.txt
a=FEA3DS8_node(:,1);
x=FEA3DS8_node(:,2);
y=FEA3DS8_node(:,3);
z=FEA3DS8_node(:,4);
%scatter3(x,y,z)
%surf(x,y,z)
% s=[x y z];
% contour(s)
plot3(x,y,z,'-*')