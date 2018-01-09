function [a,f,d]=colsol(ndf,kkk,a,f,maxa)
%****************************************************
%*     ACTIVE COLUMN EQUATION SOLVER                *
%*     NOTE: NO CHANGE NECESSARY IN THIS FUNCTION   *
%****************************************************

if ((kkk-2) < 0),
    for n=1:ndf;
        kn=maxa(n);
        kl=kn+1;
        ku=maxa(n+1)-1;
        kh=ku-kl;
        if (kh > 0),
            k=n-kh;
            ic=0;
            klt=ku;
            for j=1:kh;
                ic=ic+1;
                klt=klt-1;
                ki=maxa(k);
                nd=maxa(k+1)-ki-1;
                if (nd > 0),
                    kk=ic;
                    if (kk>nd),kk=nd;
                    end;
                    c=0.0;
                    for l=1:kk;
                        dum1=a(ki+l);
                        if (dum1~=0.0),
                            dum2=a(klt+l);
                            if (dum2~=0.0),
                                c=c+dum1.*dum2;
                            end;
                        end;
                    end;
                    a(klt)=a(klt)-c;
                    k=k+1;
                else
                    k=k+1;
                end;
            end;
            k=n;
            b=0.0;
            for kk=kl:ku;
                k=k-1;
                ki=maxa(k);
                if (a(kk)~=0.0),
                    c=a(kk)./a(ki);
                    b=b+c.*a(kk);
                else
                    c=0.0;
                end;
                a(kk)=c;
            end;
            a(kn)=a(kn)-b;
        elseif (kh == 0),
            k=n;
            b=0.0;
            for kk=kl:ku;
                k=k-1;
                ki=maxa(k);
                if (a(kk)~=0.0),
                    c=a(kk)./a(ki);
                    b=b+c.*a(kk);
                else
                    c=0.0;
                end;
                a(kk)=c;
            end;
            a(kn)=a(kn)-b;
        else
            if (a(kn)==0),
                fid = fopen('output_special.txt','w');
                fprintf(fid,'stop-N,A(kn)=');
                fprintf(fid,'%6.2f  %6.2f\n\r',n,a(kn));
                fclose(fid);
            end;
        end;
    end;
    return;
    
else
    for n=1:ndf,
        kl=maxa(n)+1;
        ku=maxa(n+1)-1;
        if ((ku-kl) >= 0),
            k=n;
            c=0.0;
            for kk=kl:ku,
                k=k-1;
                c=c+a(kk).*f(k);
            end;
            f(n)=f(n)-c;
        end;
    end;
    for n=1:ndf,
        k=maxa(n);
        f(n)=f(n)./a(k);
    end;
    if (ndf==1),return;
    end;
    n=ndf;
    for l=2:ndf;
        kl=maxa(n)+1;
        ku=maxa(n+1)-1;
        if ((ku-kl) >= 0),
            k=n;
            for kk=kl:ku,
                k=k-1;
                f(k)=f(k)-a(kk).*f(n);
            end;
            n=n-1;
        else
            n=n-1;
        end;
    end;
    d=f;
end;