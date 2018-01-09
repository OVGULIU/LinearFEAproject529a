function [shapeF,dhdr,dhdn]=CreateShapeFunc(r,n)
% Create the Shape function evaluated at r,n and their derivatives
% h: shape function r: Ksi    n: Eta   s: Zeta

shapeF=zeros(8,1);
dhdr=zeros(8,1);
dhdn=zeros(8,1);
%Include the 8 Shape functions and Derivatives

% computing shape functions
shapeF(1,1)=-0.25*(1-r)*(1-n)*(1+r+n);
shapeF(2,1)=0.25*(1+r)*(1-n)*(r-n-1);
shapeF(3,1)=0.25*(1+r)*(1+n)*(-1+r+n);
shapeF(4,1)=0.25*(1-r)*(1+n)*(-1-r+n);

shapeF(5,1)=0.5*(1-r^2)*(1-n);
shapeF(6,1)=0.5*(1+r)*(1-n^2);
shapeF(7,1)=0.5*(1-r^2)*(1+n);
shapeF(8,1)=0.5*(1-r)*(1-n^2);

% computing derivatives
% d psi / d ksai dhdr

dhdr(1,1)=0.25*(1-n)*(2*r+n);
dhdr(2,1)=0.25*(1-n)*(2*r-n);
dhdr(3,1)=0.25*(1+n)*(2*r+n);
dhdr(4,1)=0.25*(1+n)*(2*r-n);

dhdr(5,1)=0.5*(-2*r)*(1-n);
dhdr(6,1)=0.5*(1-n^2);
dhdr(7,1)=0.5*(-2*r)*(1+n);
dhdr(8,1)=0.5*(n^2-1);


% d psi / d eta dhdn

dhdn(1,1)=0.25*(1-r)*(2*n+r);
dhdn(2,1)=0.25*(1+r)*(2*n-r);
dhdn(3,1)=0.25*(1+r)*(2*n+r);
dhdn(4,1)=0.25*(1-r)*(2*n-r);

dhdn(5,1)=0.5*(r^2-1);
dhdn(6,1)=0.5*(-2*n)*(1+r);
dhdn(7,1)=0.5*(1-r^2);
dhdn(8,1)=0.5*(-2*n)*(1-r);

end