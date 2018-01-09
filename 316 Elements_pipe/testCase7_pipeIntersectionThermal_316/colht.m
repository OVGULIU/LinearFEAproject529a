function [nbig,maxa]=colht(lotogo,jj,nel,ndf)
%****************************************************
%*     DEFINES COLUMN HEIGHTS                       *
%*     NOTE: NO CHANGE NECESSARY IN THIS FUNCTION   *
%****************************************************
for i=1:ndf,
    ihc(i)=1;
    for iel=1:nel,
        for k=1:8,
            icon=lotogo(iel,k);
            for kk=1:6,
                iicon=jj(icon,kk);
                if (i==iicon),
                    for l=1:8,
                        ian=lotogo(iel,l);
                        for ll=1:6,
                            iian=jj(ian,ll);
                            if (iian ~= 0),
                                if (iian <= iicon),
                                    isp=abs(iicon-iian)+1;
                                    if (isp > ihc(i)),
                                        ihc(i)=isp;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;


maxa(1)=1;
ndfp=ndf+1;
for i=2:ndfp,
    ii=i-1;
    maxa(i)=maxa(ii)+ihc(ii);
end;

nbig=maxa(ndf+1);