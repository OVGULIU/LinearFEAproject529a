function [V1,V2,V3,V1T,V2T,V3T]=CreateNormV(x,y,z,t)

%x,y,z, and t are all vectors sized 8x1 (nodal postions and thickness)
%Create q1, q2, q3 vectors and construct the set of orthogonal unit
% vectors of V1, V2, and V3

%q1 and q2 are the matrices for storing values of q1 and q2 vectors
%Define r_nod n_nod as Ksi and Eta values at nodes
%Call CreateshapeFunc to calculate the derivatives at r_nod and n_nod
%Construct qq1 and qq2 for each node by using definition of q1 and q2 vectors
%in q1 and q2 you can use transpose functiion or simply prime, eg
%dhdr_nod'*x
%use 'cross' command to calculate q3=q1 x q2
%store q1 vector for each node in a temporary variable qq1
%To normalize the vector qq1 and store it in temporary vector VV1 use the
%magnitude command 'norm' in the normalization
%Use the same procedure for VV3
%VV2 = VV3 x VV1

q1=zeros(3,8);
q2=zeros(3,8);


V1=zeros(8,3); %V1 is the matrix of VV1 vector of each node
V2=zeros(8,3); %V2 is the matrix of VV2 vector of each node
V3=zeros(8,3); %V3 is the matrix of VV3 vector of each node
%
V1T=zeros(8,3); %V1T is the matrix of VV1*t vector of each node (t=thickness of the node)
V2T=zeros(8,3); %V2T is the matrix of VV2*t vector of each node (t=thickness of the node)
V3T=zeros(8,3); %V3T is the matrix of VV3*t vector of each node (t=thickness of the node)
%

xyz=[x y z];

r_nod=[-1 1 1 -1 0 1 0 -1];   %Ksi values at nodes
n_nod=[-1 -1 1 1 -1 0 1 0];   %Eta values at nodes



for i=1:8
    [shapeF,dhdr_nod,dhdn_nod]=CreateShapeFunc(r_nod(i),n_nod(i));
        
    %qq1, qq2, qq3 are tempory vectors for each loop
    qq1=zeros(3,1);
    qq2=zeros(3,1);
    %qq3=zeros(3,1);
    
    for j=1:size(qq1,1)
       qq1(j,1)=dhdr_nod'*xyz(:,j); 
       qq2(j,1)=dhdn_nod'*xyz(:,j);  
    end
    qqn1=qq1/norm(qq1);
    qqn2=qq2/norm(qq2);
    qq3=cross(qqn1,qqn2);
    qqn3=qq3/norm(qq3);

    
    %VV1, VV2, VV3 are tempory vectors for each loop
%     VV1=zeros(3,1);
%     VV2=zeros(3,1);
%     VV3=zeros(3,1);

    VV1=qqn1;
    VV2=cross(qqn3,qqn1);
    VV3=qqn3;

     
%     
    V1(i,:)= VV1';
    V2(i,:)=VV2';
    V3(i,:)=VV3';
    
    V1T(i,:)= t(i)*VV1';
    V2T(i,:)=t(i)*VV2';
    V3T(i,:)=t(i)*VV3';
    
    
    
    %In the Jacobian and C matrices the terms t*V1, t*V2, and t*V3 will show up. So, let's call these terms V1T's V2T's and V3T's
    
    %t*V1
    %t*V2  
    %t*V3        
%end of for loop    
end
% End of function
end