

clear all
clc
%disploc=[zeros(1,6),1,zeros(1,5),zeros(1,36)]';
%disploc=[zeros(1,6),1/3^0.5,zeros(1,5),1/3^0.5,zeros(1,5),zeros(1,12),1/3^0.5,zeros(1,5),zeros(1,12)]';
%disploc=[zeros(1,6),1,zeros(1,5),1,zeros(1,5),zeros(1,6),0.5,zeros(1,5),1,zeros(1,5),0.5,zeros(1,5),zeros(1,6)]';
disploc=[zeros(1,6),1,zeros(1,5),1,zeros(1,5),zeros(1,6),0.5,zeros(1,5),1,zeros(1,5),0.5,zeros(1,5),zeros(1,6)]';
sc=1;
x=[0 2 2 0 1 2 1 0]';
y=[0 0 1 1 0 0.5 1 0.5]';
z=ones(8,1);
t=1*ones(8,1);
s=zeros(8,1);
young=2;
poisson=0.0;
density=1;
dTemp=1;
coefExp=1;
rc=0;
nc=0;
str=stress(young, poisson,x,y,z,disploc,rc,nc,sc,dTemp,coefExp,t);

