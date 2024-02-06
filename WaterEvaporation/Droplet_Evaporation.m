%Replace some nests by constructing new solutions/nests

function newWM=Droplet_Evaporation(WM,PFit)
Tetamax=-20; Tetamin=-50;  

for i=1:size(PFit,2)
    Teta(i)=(Tetamax-Tetamin)*(PFit(i)-min(PFit))/(max(PFit)- min(PFit))+Tetamin; 
    Jteta(i)=(1/2.6)*(2/3+(cosd(Teta(i)))^3/3-cosd(Teta(i)))^(-2/3)*(1- cosd(Teta(i))); 
    DEP(i,:)=rand(1,size(WM,2))<Jteta(i); 
end

stepsize=rand*(WM(randperm(size(WM,1)),:)-WM(randperm(size(WM,1)),:));
newWM=WM+stepsize.*DEP;