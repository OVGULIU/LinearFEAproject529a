function [Feff]=updtfr(jj,maxa,njoint,Feff,aM1,aM2,dV1,dV2)
%**********************************************************
%*    UPDATES THE GENERALIZED FORCE VECTOR CONDIDERING    *
%*    DYNAMIC EFFECTS.                                    *
%*    NOTE: NO CHANGE NECESSARY IN THIS FUNCTION          *
%**********************************************************

for icon=1:njoint
    for ii=1:3
        iicon=jj(icon,ii);
        if (iicon ~= 0)
            for kcon=1:njoint
                for kk=1:3
                    kkcon=jj(kcon,kk);
                    if (kkcon ~= 0)
                        if (iicon <= kkcon)
                            if (maxa(kkcon+1)-maxa(kkcon))>(kkcon-iicon)
                                ilp=maxa(kkcon)+kkcon-iicon;
                                Feff(iicon)=Feff(iicon)+aM1(ilp)*dV1(kkcon);
                                Feff(iicon)=Feff(iicon)+aM2(ilp)*dV2(kkcon);
                            end
                        else
                            if (maxa(iicon+1)-maxa(iicon))>(iicon-kkcon)
                                ilp=maxa(iicon)+iicon-kkcon;
                                Feff(iicon)=Feff(iicon)+aM1(ilp)*dV1(kkcon);
                                Feff(iicon)=Feff(iicon)+aM2(ilp)*dV2(kkcon);
                            end
                        end
                    end
                end
            end
        end
    end
end