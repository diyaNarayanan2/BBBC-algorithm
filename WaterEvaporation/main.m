clc
clear

%% Initialization

nV=3;
Lb=[0.05 0.25 2]; 
Ub=[2 1.3 15]; 
% Define the parameters of the WEO algorithm.
nWM=20; 
maxNFEs=4000;

for i=1:nWM
    WM(i,:)=Lb+(Ub-Lb).*rand(1,nV); % Thermal objects matrix or matrix of the initial candidate solutions
end


for i=1:nWM
    [X,fit,pfit]=fobj(WM(i,:),Lb,Ub);
    WM(i,:)=X;
    Fit(i)=fit;
    PFit(i)=pfit;
end

%% Algorithm Body
NFEs=0; 
NITs=0; 
maxNITs=maxNFEs/nWM; 
while NFEs<maxNFEs
    NITs=NITs+1; 
    if NITs<=maxNITs/2

    newWM=Monolayer_Evaporation(WM,PFit);
    [WM,Fit,PFit]=Replacemnet(WM,newWM,Fit,PFit,Lb,Ub);
   
    NFEs=NFEs+nWM;
    else
    % Generate new water molecules based on the droplet evaporation strategy.
    newWM=Droplet_Evaporation(WM,PFit);

    [WM,Fit,PFit]=Replacemnet(WM,newWM,Fit,PFit,Lb,Ub);
    
    NFEs=NFEs+nWM;
    end
   
    [minPFit,m]=min(PFit);
    minFit=Fit(m);
    bestWM=WM(m,:);

    disp(['NITs= ' num2str(NITs) '; minFit = ' num2str(minFit) '; minPFit = ' num2str(minPFit)]);
 
    output1(NITs,:)=[minFit,minPFit,NFEs];
    output2(NITs,:)=[min(PFit),max(PFit),mean(PFit)];
    output3(NITs,:)=[bestWM,NFEs];
end


%% Monitoring the results
figure;
plot((1:1:NITs),output2(:,1),'g',(1:1:NITs),output2(:,2),'r-- ',(1:1:NITs),output2(:,3),'b-.')
legend('min','max','mean');
xlabel('NITs');
ylabel('PFit');