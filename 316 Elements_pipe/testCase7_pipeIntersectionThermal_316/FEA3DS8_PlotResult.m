%**********************************************************
%*    PLOTS THE STATIC DISPLACEMENT AND STRESS RESULTS    *
%*    NOTE: NO CHANGE NECESSARY IN THIS FUNCTION          *
%**********************************************************

close all;
clc
load FEA_output_data.mat coord lotogo nnod nDOFPN jj young poisson density d nel dTemp coefExp Thickness;

%--------------------- PLOT DEFORMATION ---------------------
% PLOT THE DEFORMATION FOR THE LOAD CASE DEFINED.

% DO YOU WANT THE UNDEFORMED SHAPE IN THE PLOT?: 1 - YES
%                                                0 - NO
IncludeUndeform = 1;

% AMPLIFICATION FACTOR FOR THE DEFORMATION PLOTS
AmplificationFactor = 25;
AmpFactorDeformationStress = 0;

% DEFINE THE 4 NODES OF THE SHELL ELEMENT.
%
%  c4---c7---c3
%  |          |
%  |          |
%  c8        c6
%  |          |
%  |          |
%  c1---c5---c2
%
faceN = [1,5,2,6,3,7,4,8];

% INITIZALIZATION OF THE VARIABLES.
x = zeros(nnod,1);
y = zeros(nnod,1);
z = zeros(nnod,1);
disp = zeros(nnod,nDOFPN);
dispV = zeros(nnod*nDOFPN,1);

% DEFORMATION PLOT.
figure(1)
hold on;
for iPD = 1:2
    
    % COLOR USED TO PAINT THE FACE OF THE ELEMENT.
    if (iPD == 1)
        ColorFace = 'w'; 
    else
        ColorFace = 'g';
    end  
        
    if (IncludeUndeform == 1 || iPD == 2)
        
        if (IncludeUndeform == 1 && iPD == 2)
                alpha(0.3); % Plot the undeformed shape transparent
        end
        
        for iel = 1:nel

            % EXTRACT ELEMENT GEOMETRY IN GLOBAL COORDINATE SYSTEM.
            for iloc = 1:nnod,
                x(iloc,1) = coord(lotogo(iel,iloc),1);
            	y(iloc,1) = coord(lotogo(iel,iloc),2);
				z(iloc,1) = coord(lotogo(iel,iloc),3);
            end;

            % EXTRACT ELEMENT NODAL DISPLACEMENTS IN GLOBAL COORDINATE SYSTEM.
            for iloc = 1:nnod,
                inod = lotogo(iel,iloc);
                for idir = 1:nDOFPN,
                    disp(iloc,idir) = 0;
                    ieqnm = jj(inod,idir);
                    if (ieqnm ~= 0),
                        disp(iloc,idir) = disp(iloc,idir) + d(ieqnm);
                    end;
                end;
            end;
            % AMPLIFICATION OF THE DEFORMATION.
            AmpFactor = (iPD-1)*AmplificationFactor; 
           
            % PLOTTING THE ELEMENT.
            for iface=1:1,
                faceNode = faceN(iface,:);
                fill3(x(faceNode,1)+AmpFactor*disp(faceNode,1),z(faceNode,1)+AmpFactor*disp(faceNode,3),y(faceNode,1)+AmpFactor*disp(faceNode,2),ColorFace);
            end
  
        end 
    end
end

hold off
grid;
axis([0 20 0 45 0 30]);
set(gca,'YDir','rev');
view(45,35);
title(strcat('Deformed Shape','    Amplification Factor =',{' '},num2str(AmpFactor)));
xlabel('X');ylabel('Z');zlabel('Y');
print('-djpeg','-r600',strcat('Deformed_Shape_AmpFactor_',num2str(AmpFactor),'.jpeg'));


%
%--------------------- PLOT STRESSES ---------------------

% STRESS TO PLOT
% 1 - S11;	2 - S22;	3 - S33; 4 -S_Von_Mises



for isig = 1:4;    % Stress Component to Plot


    for sloc = 1:3;		% Shell Thickness Location to Plot


		figure((isig-1)*3+sloc+1)
		hold on;
		MinStress = +inf;
		MaxStress = -inf;
		
		for iel = 1:nel
			% EXTRACT ELEMENT GEOMETRY IN GLOBAL COORDINATE SYSTEM.
			for iloc = 1:nnod
				x(iloc,1) = coord(lotogo(iel,iloc),1);
				y(iloc,1) = coord(lotogo(iel,iloc),2);
				z(iloc,1) = coord(lotogo(iel,iloc),3);
			end
			% FIND LOCAL TO GLOBAL TRANSFORMATION MATRIX, LAMBDA [3x3].
            t=Thickness*ones(nnod,1);
            [V1,V2,V3,V1T,V2T,V3T]=CreateNormV(x,y,z,t);            
    			
			% EXTRACT ELEMENT NODAL DISPLACEMENTS IN GLOBAL COORDINATE SYSTEM.
			for iloc = 1:nnod,
				inod = lotogo(iel,iloc);
				for idir = 1:nDOFPN,
					disp(iloc,idir) = 0;
					ieqnm = jj(inod,idir);
					if (ieqnm ~= 0),
						disp(iloc,idir) = disp(iloc,idir) + d(ieqnm);
					end;
				end;
				for  idir = 1:nDOFPN,
					dispV((iloc-1)*nDOFPN + idir,1) = 0;
					ieqnm = jj(inod,idir);
					if (ieqnm ~= 0),
						dispV((iloc-1)*nDOFPN + idir,1) = d(ieqnm);
					end;
				end;
			end;
			
			% COMPUTE ELEMENT NODAL DISPLACEMENTS IN LOCAL COORDINATE SYSTEM.
            [akloc,felloc,amloc] = stiff(young,poisson,density,x,y,z,dTemp,coefExp,t);
            [akglob,felglob,L] = Loc2GlobTrans(akloc,felloc,V1,V2,V3);
			dispVloc = L*dispV;
			
			% AMPLIFICATION OF THE DEFORMATION.
			AmpFactor = AmpFactorDeformationStress;
			
			% PLOT THE STRESS OF EACH FACE AT THE PROJECTION OF INTEGRATION
			% POINT IN THE FACE OF THE ELEMENT.
            %

            
            for iface = 1:1;
				
				faceNode = faceN(iface,:);
    		
				% (8) GAUSS POINT COORDINATES AT EACH FACE OF THE ELEMENT.
				
				% COMPUTE THE STRESS AT EACH PROJECTION OF THE INTEGRATION POINT
				% IN THE FACE USING 2 GAUSS POINTS (2*2).
				
                
                ag=-1/sqrt(5/3); bg=0; cg=1/sqrt(5/3); dg=[-1 0.0 1];
				Face_G=[ag,ag; bg,ag; cg,ag; cg,bg; cg,cg; bg,cg; ag,cg; ag,bg];                
                [sigPr1,sigVon1] = stress(young,poisson,x,y,z,dispVloc,Face_G(8*(iface-1)+1,1),Face_G(8*(iface-1)+1,2),dg(sloc),dTemp,coefExp,t);
				[sigPr2,sigVon2] = stress(young,poisson,x,y,z,dispVloc,Face_G(8*(iface-1)+2,1),Face_G(8*(iface-1)+2,2),dg(sloc),dTemp,coefExp,t);
				[sigPr3,sigVon3] = stress(young,poisson,x,y,z,dispVloc,Face_G(8*(iface-1)+3,1),Face_G(8*(iface-1)+3,2),dg(sloc),dTemp,coefExp,t);
				[sigPr4,sigVon4] = stress(young,poisson,x,y,z,dispVloc,Face_G(8*(iface-1)+4,1),Face_G(8*(iface-1)+4,2),dg(sloc),dTemp,coefExp,t);
				[sigPr5,sigVon5] = stress(young,poisson,x,y,z,dispVloc,Face_G(8*(iface-1)+5,1),Face_G(8*(iface-1)+5,2),dg(sloc),dTemp,coefExp,t);
				[sigPr6,sigVon6] = stress(young,poisson,x,y,z,dispVloc,Face_G(8*(iface-1)+6,1),Face_G(8*(iface-1)+6,2),dg(sloc),dTemp,coefExp,t);
				[sigPr7,sigVon7] = stress(young,poisson,x,y,z,dispVloc,Face_G(8*(iface-1)+7,1),Face_G(8*(iface-1)+7,2),dg(sloc),dTemp,coefExp,t);
				[sigPr8,sigVon8] = stress(young,poisson,x,y,z,dispVloc,Face_G(8*(iface-1)+8,1),Face_G(8*(iface-1)+8,2),dg(sloc),dTemp,coefExp,t);
  
                if  isig ~= 4   % The Principal Stresses S11 S22 and S33
                    ColorFaceStress = [sigPr1(isig,1),sigPr2(isig,1),sigPr3(isig,1),sigPr4(isig,1),sigPr5(isig,1),sigPr6(isig,1),sigPr7(isig,1),sigPr8(isig,1)]';
                else
                    ColorFaceStress = [sigVon1,sigVon2,sigVon3,sigVon4,sigVon5,sigVon6,sigVon7,sigVon8]';

                end

               
                
				if (MaxStress < max(ColorFaceStress))
					MaxStress = max(ColorFaceStress);
				end
				if (MinStress > min(ColorFaceStress))
					MinStress = min(ColorFaceStress);
                end
				fill3(x(faceNode,1)+AmpFactor*disp(faceNode,1),z(faceNode,1)+AmpFactor*disp(faceNode,3),y(faceNode,1)+AmpFactor*disp(faceNode,2),ColorFaceStress');
				%
			end
			%
		end
		%
		hold off
		grid;
        axis([0 20 0 45 0 30]);
		set(gca,'YDir','rev','fontsize',18);
		view(45,35);
		%
        title_Var = {'Principal Stress \sigma_1 @ Bottom Surface','Principal Stress \sigma_1 @ Mid Surface','Principal Stress \sigma_1 @ Top Surface','Principal Stress \sigma_2 @ Bottom Surface','Principal Stress \sigma_2 @ Mid Surface','Principal Stress \sigma_2 @ Top Surface','Principal Stress \sigma_3 @ Bottom Surface','Principal Stress \sigma_3 @ Mid Surface','Principal Stress \sigma_3 @ Top Surface','VonMises Stress \sigma_V @ Bottom Surface','VonMises Stress \sigma_V @ Mid Surface','VonMises Stress \sigma_V @ Top Surface'};
		title(title_Var((isig-1)*3+sloc));
		axes('position',[.05  .05  .9  .01])
		pcolor([1:0.1:10;1:0.1:10]);
		set(gca,'XTickLabel',{MinStress:(MaxStress-MinStress)/8:MaxStress});
		set(gca,'YTickLabel',{''});
		print_Var= {'Principal_Stress_1_@_Bottom_Surface.jpeg','Principal_Stress_1_@_Mid_Surface.jpeg','Principal_Stress_1_@_Top_Surface.jpeg','Principal_Stress_2_@_Bottom_Surface.jpeg','Principal_Stress_2_@_Mid_Surface.jpeg','Principal_Stress_2_@_Top_Surface.jpeg','Principal_Stress_3_@_Bottom_Surface.jpeg','Principal_Stress_3_@_Mid_Surface.jpeg','Principal_Stress_3_@_Top_Surface.jpeg','VonMises_Stress_@_Bottom_Surface.jpeg','VonMises_Stress_@_Mid_Surface.jpeg','VonMises_Stress_@_Top_Surface.jpeg'};
		print('-djpeg','-r600',char(print_Var((isig-1)*3+sloc)));
		%
        close all
		
	end;
    
end;
%
%

clear all
clc