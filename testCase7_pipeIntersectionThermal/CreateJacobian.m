function [ajac]=CreateJacobian(dhdr,dhdn,x,y,z,s,shapeF,V3T)


ajac=zeros(3,3);

ajac(1,1)=dhdr'*x+dhdr'*V3T(:,1)*(s/2);
ajac(1,2)=dhdr'*y+dhdr'*V3T(:,2)*(s/2);
ajac(1,3)=dhdr'*z+dhdr'*V3T(:,3)*(s(1)/2);

ajac(2,1)=dhdn'*x+dhdn'*V3T(:,1)*(s/2);
ajac(2,2)=dhdn'*y+dhdn'*V3T(:,2)*(s/2);
ajac(2,3)=dhdn'*z+dhdn'*V3T(:,3)*(s/2);

ajac(3,1)=0.5*shapeF'*V3T(:,1);
ajac(3,2)=0.5*shapeF'*V3T(:,2);
ajac(3,3)=0.5*shapeF'*V3T(:,3);

ajac

end