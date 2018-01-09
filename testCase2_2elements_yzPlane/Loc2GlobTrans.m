function [akglob,felglob,L] = Loc2GlobTrans(akloc,felloc,V1,V2,V3)
%***********************************************************
%*    TRANSFORMS SHELL ELEMENT STIFF. MATRIX, AND FORCE    *
%*    VECTOR FROM LOCAL TO GLOBAL COORDINATES.             *
%*    NOTE: NO CHANGE NECESSARY IN THIS FUNCTION           *
%***********************************************************

% [L] 48x48 TRANSFORMATION MATRIX.
L = zeros(48,48);

for i=1:8
    L((i-1)*6+1,(i-1)*6+1)=1;
    L((i-1)*6+2,(i-1)*6+2)=1;
    L((i-1)*6+3,(i-1)*6+3)=1;
    %
    L((i-1)*6+4,(i-1)*6+4)=V1(i,1);
    L((i-1)*6+4,(i-1)*6+5)=V1(i,2);
    L((i-1)*6+4,(i-1)*6+6)=V1(i,3);
    %
    L((i-1)*6+5,(i-1)*6+4)=V2(i,1);
    L((i-1)*6+5,(i-1)*6+5)=V2(i,2);
    L((i-1)*6+5,(i-1)*6+6)=V2(i,3);
    %
    L((i-1)*6+6,(i-1)*6+4)=V3(i,1);
    L((i-1)*6+6,(i-1)*6+5)=V3(i,2);
    L((i-1)*6+6,(i-1)*6+6)=V3(i,3);
end

% CALCULATE ELEMENT STIFFNESS MATRIX IN GLOBAL COORDINATE SYSTEM.
akglob = L'*akloc*L;

% CALCULATE ELEMENT FORCE VECTOR IN GLOBAL COORDINATE SYSTEM.
felglob = L'*felloc';