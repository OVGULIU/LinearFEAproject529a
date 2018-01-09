function [pos,weight]=GaussPoint(nGP,GP)
% Return the gauss point weight 


if nGP==2
    weight=1;
    if GP==1
        pos=-1/sqrt(3);
    else
        pos=1/sqrt(3);
    end
end

if nGP==3
    if GP==1
        pos=-sqrt(0.6);
        weight=5/9;
    else
        if GP==2
            pos=0;
            weight=8/9;
        else
            pos=sqrt(0.6);
            weight=5/9;
        end
    end
end

%Add 4 Gauss point formulas

if nGP==4
    if GP==1
        pos=-0.86114;
        weight=0.3478;
    elseif GP==2
        pos=-0.33998;
        weight=0.65214;
    elseif GP==3
        pos=0.33998;
        weight=0.65214;
    else
        pos=0.86114;
        weight=0.34785;   
    end
        
        
%     else
%         if GP==2
%             pos=-0.33998;
%             weight=0.65214;
%         end
%         if GP==3
%             pos=0.33998;
%             weight=0.65214;
%         else
%             pos=0.86114;
%             weight=0.34785;   
%         end
%     end
% end of if for gp==4
end

%end of function

end