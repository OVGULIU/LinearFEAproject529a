function [B,C,G]=CreateBCmatrix(shapeF,dhdr,dhdn,ajacinv,s,V1T,V2T)

B=zeros(9,9);
C=zeros(9,48);
G=zeros(3,48);


for i=1:3
    for j=1:3
        for k=1:3
            B(i+(k-1)*3,j+(k-1)*3)=ajacinv(i,j);
        end
    end
end

for i=1:8
    for j=1:3
        C((j-1)*3+1,(i-1)*6+j)=dhdr(i,1);
        C((j-1)*3+1,(i-1)*6+4)=s*dhdr(i,1)*(-0.5)*V2T(i,j);
        C((j-1)*3+1,(i-1)*6+5)=s*dhdr(i,1)*(0.5)*V1T(i,j);
        
        C((j-1)*3+2,(i-1)*6+j)=dhdn(i,1);
        C((j-1)*3+2,(i-1)*6+4)=s*dhdn(i,1)*(-0.5)*V2T(i,j);
        C((j-1)*3+2,(i-1)*6+5)=s*dhdn(i,1)*(0.5)*V1T(i,j);
        
        C((j-1)*3+3,(i-1)*6+4)=shapeF(i,1)*(-0.5)*V2T(i,j);
        C((j-1)*3+3,(i-1)*6+5)=shapeF(i,1)*(0.5)*V1T(i,j)
    end
end

for i=1:8
    
    for j=1:3
        G(j,(i-1)*6+j)=shapeF(i,1);
        G(j,(i-1)*6+4)=s*shapeF(i,1)*(-0.5)*V2T(i,j);
        G(j,(i-1)*6+5)=s*shapeF(i,1)*0.5*V1T(i,j);
        
    end
end
end