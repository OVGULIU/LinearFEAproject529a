function FEA3DS8_create_input
%********************************************************************
%*    Input Data Translator - ABAQUS -> FEA                         *
%*                                                                  *
%*    Steps for you to take:                                        *
%*      1. copy the Abaqus input file to file node.txt              *
%*      2. Edit node.txt and delete all lines except                *
%*         the nodal coordinate data which occurs under             *
%*         the name "NODE*" in the Abaqus input file.               *
%*      3. copy the Abaqus input file to file element.txt           *
%*      4. Edit element.txt and delete all lines except             *
%*         the element connectivity data which occurs under         *
%*         the name "ELEMENT*" in the Abaqus input file.            *
%*    Then this program does the following:                         *
%*      1. loads Abaqus data from files node.txt and element.txt    *
%*      2. Transforms Abaqus data to FEA data.                      *
%*      3. Saves matlab FEA data for nodes and elements and         *
%*         other data in FEA_input_data.mat.                        *
%********************************************************************
node=load('FEA3DS8_node.txt'); 
element=load('FEA3DS8_element.txt'); 

num_ele = size(element,1);

coord = node(:,2:4);

lotogo = zeros(num_ele,8);

% LOAD LOCAL NODE NUMBERING CONNECTIVITY DATA FROM ABAQUS TO FEA
lotogo(:,1) = element(:,2);
lotogo(:,2) = element(:,3);
lotogo(:,3) = element(:,4);
lotogo(:,4) = element(:,5);
lotogo(:,5) = element(:,6);
lotogo(:,6) = element(:,7);
lotogo(:,7) = element(:,8);
lotogo(:,8) = element(:,9);



% ADDING THE BOUNDARY RESTRAINT CONDITIONS
% ----------------------------------------
% JJ = 1 MEANS THAT DOF IS FREE TO MOVE
% JJ = 0 MEANS THE DOF IS FIXED OR RESTRAINED
%
jj = ones(size(coord,1),6);
%
% SET RESTRAINTS TO ZERO FOR NODES AT THE "OFFSET"
%********************************************************************
%*    NOTE: THIS PART NEEDS TO BE MODIFIED FOR THE PROJECT MODEL    *
%********************************************************************
offset = 0;
ind = (abs(coord(:,2)-offset)<1e-6);
jj(ind,2) = 0;
jj(ind,4) = 0;
jj(ind,6) = 0;

offset = 0;
ind = (abs(coord(:,3)-offset)<1e-6);
jj(ind,3) = 0;
jj(ind,4) = 0;
jj(ind,5) = 0;

offset = 0;
ind = (abs(coord(:,1)-offset)<1e-6);
jj(ind,1) = 0;
jj(ind,5) = 0;
jj(ind,6) = 0;

offset = 40;
ind = (abs(coord(:,3)-offset)<1e-6);
jj(ind,1) = 0;



% offset = 0;
% ind = (abs(coord(:,1)-offset)<1e-6);
% jj(ind,:) = 0;

% ----------------------------------

% MATERIAL PROPERTIES 
young = 29E6;
poisson = 0.3;
density = .0008;
coefExp = 0.000007;

% DYNAMIC ANALYSIS PARAMETERS
ntimeStep = 200;
dt = .005;
AlfaDamp = 0.08;
BetaDamp = 0.002;

% TEMPERATURE VARIATION
dTemp = -60;

% THICKNESS OF THE SHELL
Thickness = 2.5;

% PRESSURE ON THE SHELL SURFACE
Pressure = 22000;

% ----------------------------------------
% CONCENTRATED FORCES
% ----------------------------------------
%********************************************************************
%*    NOTE: THIS PART NEEDS TO BE MODIFIED FOR THE PROJECT MODEL    *
%********************************************************************
% % GLOBAL NODES AT WHICH FORCES ARE APPLIED 
% offset = 25.0 ;
% ind = (abs(coord(:,1)-offset)<1e-6);
% ifornod = find(ind)';

% % FORCE DIRECTIONS (1 - X, 2 - Y, 3 - Z)
% ifordir = 1*ones(1,size(ifornod,2));

% % FORCE VALUES
% for i=1:size(ifornod,2)
       % forval(i) = 1000*50*Thickness/size(ifornod,2); 
% end
ifornod = [3 581 26 579 27 577 28 575 29 573 30 571 31 569 32 567 33 565 34 562 4];
% %ifornod = [3 223:-2:215 18:1:21 23 212 4];
ifordir = 2*ones(1,size(ifornod,2));
% %forval = [(1/6)*55000 (2/3)*55000*ones(1,11) (1/6)*55000];
% %forval=[66595.22 266380.88 133190.44*ones(1,9) 266380.88 66595.22];
numnode=size(ifornod,2);
forval=-0*Pressure*0.5*pi*9.25*Thickness*(1/numnode)*ones(1,numnode);
% ----------------------------------------

save FEA_input_data.mat coord lotogo jj young poisson density ifornod ifordir forval ntimeStep dt AlfaDamp BetaDamp dTemp coefExp Thickness Pressure;
%save FEA_input_data.mat coord lotogo jj young poisson density ntimeStep dt AlfaDamp BetaDamp dTemp coefExp Thickness Pressure;
clear
end