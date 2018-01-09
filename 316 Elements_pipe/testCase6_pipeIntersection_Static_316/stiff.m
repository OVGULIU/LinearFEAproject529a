function [akloc,felloc,amloc]=stiff(young, poisson,density,x,y,z,dTemp,coefExp,t)
%****************************************************
%*   FORMS THE ELEMENT STIFFNESS AND MASS MATRIX    *
%****************************************************
%
% ZERO ELEMENT STIFFNESS MATRIX (akloc), MASS MATRIX (amloc), AND FORCE VECTOR (felloc)

%
% x=[0 0 4 4 0 2 4.5 2]';
% y=[0 0 4 4 0 2 4 2]';
% z=[0 4 4 0 2 4 2 0]';
% t=0.2*ones(8,1);
% dTemp=0;
% coefExp=0.1;
% density=1;
% young=2;
% poisson=0.3

msize=48;
felloc=zeros(msize,1);
akloc=zeros(msize,msize);   %akloc_0+akloc_eps
akloc_0=zeros(msize,msize);	%stiffness matrix with zero stiffness for Theta_3 rotation
amloc_0=zeros(msize,msize);	%stiffness matrix with zero stiffness for Theta_3 rotation
akloc_eps=zeros(48,48);     %stiffness matrix with nonzero stiffness for Theta_3 rotation
amloc_eps=zeros(48,48);     %stiffness matrix with nonzero stiffness for Theta_3 rotation
amloc=zeros(msize,msize);   %mass matrix, (NOT be included yet!)

fellocTher=zeros(msize,1);  %thermal elemental force

%CREATE THE [E] Elasticity and [A] MATRIX FOR THE ELEMENT
[E,A]=CreateEA(young,poisson)

%number of gauss points to use for the numerical integration
nGPr=3;
nGPn=3;
nGPs=2;
%Thermal Strain to be defined later
ThermalStrain=zeros(6,1);

%
% INITIALIZE ELEMENT STIFFNESS MATRIX AND FORCE VECTOR

for i=1:nGPr,
   [r,wr]=GaussPoint(nGPr,i);
   for j=1:nGPn,
      [n,wn]=GaussPoint(nGPn,j);
      for k=1:nGPs,
       [s,ws]=GaussPoint(nGPs,k);
       [shapeF,dhdr,dhdn]=CreateShapeFunc(r,n)
       [V1,V2,V3,V1T,V2T,V3T]=CreateNormV(x,y,z,t)
       [ajac]=CreateJacobian(dhdr,dhdn,x,y,z,s,shapeF,V3T)
       [ajacinv,det,c]=jacinv(ajac)
       [B,C,G]=CreateBCmatrix(shapeF,dhdr,dhdn,ajacinv,s,V1T,V2T)
       
       D=A*B*C;
       akloc_0=akloc_0+(D'*E*D)*det*wr*wn*ws;
       
       amloc_0=amloc_0+density*(G'*G)*det*wr*wn*ws;
       
       fellocTher=fellocTher+D'*E*ThermalStrain*det*wr*wn*ws;

      end
   end
end


%Construct the akloc_eps matrix
epsi=1E-4;

%%%%
for p=6:6:48
   akloc_eps(p,p)=epsi; 
   amloc_eps(p,p)=epsi;
end

akloc=akloc_0+akloc_eps;
amloc=amloc_0+amloc_eps;
%
diagonal_elements=diag(akloc)
felloc= fellocTher';
end
