function [a,f]=assem(iel,lotogo,jj,a,f,maxa,akglob,felglob)
%****************************************************
%*     ASSEMBLES STIFF. MATRIX AND FORCE VECTOR.    *
%*     NOTE: NO CHANGE NECESSARY IN THIS FUNCTION   *
%****************************************************
for i=1:8,
    for k=1:8,
        icon=lotogo(iel,i);
        kcon=lotogo(iel,k);
        for ii=1:6,
            for kk=1:6,
                iicon=jj(icon,ii);
                kkcon=jj(kcon,kk);
                iii=(i-1)*6+ii;
                kkk=(k-1)*6+kk;
                if (iicon ~= 0 && kkcon ~= 0),
                    if (iicon <= kkcon),
                        ilp=maxa(kkcon)+kkcon-iicon;
                        a(ilp)=a(ilp)+akglob(iii,kkk);
                    end;
                end;
                if (k==1 && kk==1),
                    if (iicon~=0),
                        f(iicon)=f(iicon)+felglob(iii);
                    end;
                end;
            end;
        end;
    end;
end;