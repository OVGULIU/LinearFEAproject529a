clear all
clc
disp('this is a calling function that calls all the functions')
% x=[1 2 3 4 5 6 7 8]';
% y=[1 2 3 4 5 6 7 8]';
% x=[0 2 2 0 1 2 1 0]';
% y=[0 0 2 2 0 1 2 1]';

x=[0 0 4 4 0 2 4.5 2]';
y=[0 0 4 4 0 2 4 2]';
z=[0 0 4 4 2 4 2 0]';



% 
% z=ones(8,1);
% t=ones(8,1);
s=ones(8,1);
young=2;
poisson=0.3;
density=1;
dTemp=1;
coefExp=1;

t=0.2*ones(8,1);
[akloc,felloc,amloc]=stiff(young, poisson,density,x,y,z,dTemp,coefExp,t);

% [shapeF,dhdr,dhdn]=CreateShapeFunc(r,n)
%[V1,V2,V3,V1T,V2T,V3T]=CreateNormV(x,y,z,t);
% [ajac]=CreateJacobian(dhdr,dhdn,x,y,z,s,shapeF,V3T)






