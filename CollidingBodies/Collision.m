% Calculate the velocity of bodies after collision.

function [CB,M,Fit,PFit,stepsize]=Collision(CB,M,Fit,PFit,NITs,maxNITs)
nCB=size(CB,1);
[~,order]=sort(PFit);
CB=CB(order,:);
Fit=Fit(order);
PFit=PFit(order);
M=M(order);
COR=1-(NITs/maxNITs); 
for i=1:nCB/2
    VMB=CB(nCB/2+i,:)-CB(i,:); 
    stepsize(i,:)=((1+COR)*M(nCB/2+i))/(M(i)+M(nCB/2+i))*VMB; 
    stepsize(nCB/2+i,:)=(M(nCB/2+i)-COR*M(i))/(M(i)+M(nCB/2+i))*VMB; 
end