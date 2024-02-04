% Get new water molecules by monolayer evaporation strategy.

function newWM=Monolayer_Evaporation(WM,PFit)
Emax=-.5; Emin=-3.5; 

for i=1:size(PFit,2)
    E(i)=(Emax-Emin)*(PFit(i)-min(PFit))/(max(PFit)-min(PFit))+Emin; 
    Jesub(i)=exp(E(i)); 
    MEP(i,:)=rand(1,size(WM,2))<Jesub(i); 
end

stepsize=rand*(WM(randperm(size(WM,1)),:)-WM(randperm(size(WM,1)),:));
newWM=WM+stepsize.*MEP;