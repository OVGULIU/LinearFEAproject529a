function [jj,ndf]=eqnum(jj,njoint,nDOFPN)
%****************************************************
%*     CREATES EQUATION NUMBERS                     *
%*     NOTE: NO CHANGE NECESSARY IN THIS FUNCTION   *
%****************************************************
ndf=0;
for i=1:njoint
    for k=1:nDOFPN
        if (jj(i,k)~=0)
            ndf=ndf+1;
        end
        if (jj(i,k)~=0)
            jj(i,k)=ndf;
        end;
    end
end
