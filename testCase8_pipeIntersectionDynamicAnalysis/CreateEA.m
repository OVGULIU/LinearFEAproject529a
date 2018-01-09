function [E,A]=CreateEA(young,poisson)

%CREATE THE [E] MATERIAL MATRIX 
E=zeros(6,6);

% populating the E matrix
for i=1:size(E,2)
    for j=1:size(E,2)
        % populating the diagonal terms
        if (i<=size(E,2)/2 && j<=size(E,2)/2 && i==j)
            E(i,j)=1-poisson;
        end
  
        if (i>size(E,2)/2 && i>size(E,2)/2 && i==j)
            E(i,j)=(1-2*poisson)/2;
        end
        
        % populating the off diagonal terms
        if (i<=size(E,2)/2 && j<=size(E,2)/2 && i~=j)
            E(i,j)=poisson;
        end

    end
       
end

E=((young)/((1+poisson)*(1-2*poisson)))*E;


%CREATE THE [A] MATRIX FOR THE ELEMENT
A=zeros(6,9);

ls=4; % long step in horisontal direction
ss=2; % short step in horisontal direction

startp=1;% for upper half

for k=1:size(A,1)
   if k<=size(A,1)/2
       A(k,startp)=1;
       startp=startp+ls;
   end
   if k==4
        A(k,2)=1;
        A(k,2+ss)=1;
   end
   if k==5
        A(k,3)=1;
        A(k,3+ls)=1;
   end
   if k==6
        A(k,6)=1;
        A(k,6+ss)=1;
   end
end



end