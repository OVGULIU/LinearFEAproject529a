function [sigPr,sigVon]=stress(young, poisson,x,y,z,disploc,rc,nc,sc,dTemp,coefExp,t)
%function [stress_val]=stress(young, poisson,x,y,z,disploc,rc,nc,sc,dTemp,coefExp,t)
%****************************************************
%*     COMPUTE ELEMENT STRESS DISTRIBUTION          *
%*                                                  *
%*     YOUR WORK:                                   *
%*     YOU SHOULD ADD YOUR STRESS ROUTINES HERE     *
%****************************************************
%
% ZERO STRESSES - SIGMAxx, SIGMAyy, SIGMAzz, TAUxy, TAUxz, TAUyz
% sig=zeros(6,1);
% %
% % tau is the stress tensor:
% % |sig(1,1)  sig(4,1)  sig(5,1)|
% % |                            |
% % |sig(4,1)  sig(2,1)  sig(6,1)|
% % |                            |
% % |sig(5,1)  sig(6,1)  sig(3,1)|
% tau=zeros(3,3);
% %
% % Principal stresses (sigPr(1) < sigPr(2) < sigPr(3))
% sigPr=zeros(3,1);
% %Thermal Strain
% ThermalStrain=zeros(6,1);
% ThermalStrain(1:3,1)=coefExp*dTemp;


%COMPUTE STRESSES

%disploc=[zeros(1,6),1,zeros(1,5),1,zeros(1,5),zeros(1,6),0.5,zeros(1,5),1,zeros(1,5),0.5,zeros(1,5),zeros(1,6)]';
 % Populate the stress tensor tau(3,3) for calculating the principal
 % stresses S1 < S2 < S3
%  
% rc=0.5;
% nc=0.5;
% sc=0;
 [shapeF,dhdr,dhdn]=CreateShapeFunc(rc,nc);
 
 [V1,V2,V3,V1T,V2T,V3T]=CreateNormV(x,y,z,t);

 [ajac]=CreateJacobian(dhdr,dhdn,x,y,z,sc,shapeF,V3T);
  
 [ajacinv,det,c]=jacinv(ajac);
 
 [E,A]=CreateEA(young,poisson);

 [B,C]=CreateBCmatrix(shapeF,dhdr,dhdn,ajacinv,sc,V1T,V2T);
density=1;

%disploc=inv(akloc)*felloc;
 
sig=E*A*B*C*disploc*det;
tau=[sig(1,1)  sig(4,1)  sig(5,1);
    sig(4,1)  sig(2,1)  sig(6,1);
    sig(5,1)  sig(6,1)  sig(3,1)]
sigPr=eig(tau)
sigVon=sqrt(0.5*((sigPr(1)-sigPr(2))^2+(sigPr(2)-sigPr(3))^2+(sigPr(1)-sigPr(3))^2))
 
%  
% density=1;
% %east=stiff(young, poisson,density,x,y,z,dTemp,coefExp,t);
%  
%  % check 1 
%  
%  
%  
%  stress_val=east*disploc
%  

 %%%
 %
 % Calculate the principal stresses S1, S2, S3
 
 % Calculate the Von-Mises stress component
 
end
