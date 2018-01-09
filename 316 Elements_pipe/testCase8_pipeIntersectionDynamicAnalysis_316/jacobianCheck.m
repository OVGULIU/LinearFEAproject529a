% jacobian check
clear all
clc

r=-0.577;
n=-0.577;



x=[0 2 2 0 1 2 1 0]';
y=[0 0 2 2 0 1 2 1]';
z=ones(8,1);
s=1*ones(8,1);
t=ones(8,1);


[shapeF,dhdr,dhdn]=CreateShapeFunc(r,n);

[V1,V2,V3,V1T,V2T,V3T]=CreateNormV(x,y,z,t);


[ajac]=CreateJacobian(dhdr,dhdn,x,y,z,s,shapeF,V3T)