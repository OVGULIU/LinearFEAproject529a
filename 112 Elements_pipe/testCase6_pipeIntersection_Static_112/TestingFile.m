% clear all
% clc
% nGP=3;
% h=zeros(1,nGP);
% n=zeros(1,nGP);
% j=zeros(1,nGP);
% k=zeros(1,nGP);
% 
% xc=zeros(1,nGP*nGP);
% yc=zeros(1,nGP*nGP);
% %[a b]=GaussPoint(nGP,1)
% for i=1:nGP
%    [q w]=GaussPoint(nGP,i) ;
%    [qy wy]=GaussPoint(nGP,i) ;
%    h(i)=q;
%    n(i)=qy;
%    j(i)=w;
%    k(i)=wy;
% end
% xy=combvec(h,n);
% xc=xy(1,:);
% yc=xy(2,:);
% h;
% j;
% xc
% yc
% 
% 
% 
% [pos2,weight2]=GaussPoint(nGP,2)
% [pos3,weight3]=GaussPoint(nGP,3)
% [pos4,weight4]=GaussPoint(nGP,4)

clear all 
clc
% simmulating a second order system
% %------------
% a=[0 1; 
%    -2 -3];
% 
% [t v]=eig(a)
% 
% syms s
% tf=1/[s^2+3*s+2];
% tf2=[1 0]*inv(s*[1 0;0 1]-a)*[0 1]'
% %poles(tf,s)
% 
% 
% b1 = [1];
% a1 = [1 3 2];
% %fvtool(b1,a1,'polezero')
% [b1,a1] = eqtflength(b1,a1);
% [z,p,k] = tf2zp(b1,a1)
%-------------------------
% m=[1 -1 8; 4 9 -6];
% l=m*m'
% r=m'*m
% lef=det(l)
% rig=det(r)
% 
% x=[1 2 3 4 5 6 7 8]';
% y=[1 2 3 4 5 6 7 8]';
% z=ones(8,1);
% t=ones(8,1);
% r_nod=[-1 1 1 -1 0 1 0 -1];   %Ksi values at nodes
% n_nod=[-1 -1 1 1 -1 0 1 0];   %Eta values at nodes
% 
% 
% xyz=[x y z];
% 
% V1=zeros(8,3);
% [shapeF,dhdr_nod,dhdn_nod]=CreateShapeFunc(r_nod(1),n_nod(1));
% %[shapeF,dhdr_nod,dhdn_nod]=CreateShapeFunc(r_nod(1),n_nod(1));
% %dhdr_nod     
%     %qq1, qq2, qq3 are tempory vectors for each loop
%     qq1=zeros(3,1);
%     qq2=zeros(3,1);
%     qq3=zeros(3,1);
% 
%    qq1(1,1)=dhdr_nod'*xyz(:,1); 
%    
% %     
% %     for j=1:size(qq1,1)
% %        qq1(j,1)=dhdr_nod*xyz(:,j); 
% %        qq2(j,1)=dhdr_nod*xyz(:,j);  
% %     end
% %     qqn1=qq1/norm(qq1);
% %     qqn2=qq2/norm(qq2);
% %     qq3=cross(qq1,qq2);
% %     
% %     %VV1, VV2, VV3 are tempory vectors for each loop
% %     VV1=zeros(3,1);
% %     VV2=zeros(3,1);
% %     VV3=zeros(3,1);
% %     
% %     VV1=qq1;
% %     VV2=corss(qq3,qq1);
% %     VV3=qq3;
% %     
% %     vv=[VV1 VV2 VV3];
% %     
% %     
% %     for k=1:size(V1,2)
% %        V1(1,k)=norm(vv(:,k));
% %     end



syms x l
p=(((3*x^2)/(l^2))-(2*x/l))^4
v=p^4;
expand(v)
pretty(v)












