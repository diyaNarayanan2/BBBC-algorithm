%MAIN CODE

clc
clear

nV=2; 
Lb=[-5 -5]; 
Ub=[5 5]; 

nP=20; 
maxNFEs=1000; 
beta=0.2; 
alfa=1; 

for i=1:nP
    P(i,:)=Lb+(Ub-Lb).*rand(1,nV); 
end

Fit = zeros(size(P, 1), 1);
PFit = zeros(size(P, 1), 1);

for i=1:size(P,1)
    [X,fit,pfit]= fobj(P(i,:),Lb,Ub);
    P(i,:)=X;
    Fit(i)=fit;
    PFit(i)=pfit;
end

[minPFit,m]=min(PFit);
minFit=Fit(m);
bestP=P(m,:);

xRange = linspace(-6, 6, 100);
yRange = linspace(-6, 6, 100);
[X_0, Y_0] = meshgrid(xRange, yRange);
Z_0 = X_0.^2 + Y_0.^2 + 25*(sin(X_0).^2 + sin(Y_0).^2); 

xRange = linspace(-6, 6, 100);
yRange = linspace(-6, 6, 100);
[X_0, Y_0] = meshgrid(xRange, yRange);
Z_0 = -X_0.^2 - Y_0.^2 + 10; 

NFEs=0; 
NITs=0; 
while NFEs<maxNFEs
    
    if NITs==0
        BestP=bestP;
        MinPFit=minPFit;
        MinFit=minFit;
    end
	
    NITs=NITs+1; 

    CM=Big_Crunch(P,PFit);
    newP=Big_Bang(P,CM,bestP,beta,alfa,Lb,Ub,NITs);

    figure; 
    surf(X_0, Y_0, Z_0);
    view(-45,12)
    colormap('parula'); 
    shading interp;

    hold on;
    scatter3(newP(:,1), newP(:,2), -newP(:,1).^2 - newP(:,2).^2 + 10, 'r', 'filled'); 
    xlabel('X_0');
    ylabel('Y_0');
    zlabel('Z_0');
    title(['Iteration ' num2str(NITs)]);
    hold off;
    pause(0.001);

    for i=1:size(P,1)
        [X,fit,pfit]=fobj(newP(i,:),Lb,Ub);
        P(i,:)=X;
        Fit(i)=fit;
        PFit(i)=pfit;
    end
    NFEs=NFEs+nP;

    [minPFit,m]=min(PFit);
    minFit=Fit(m);
    bestP=P(m,:);
    if minPFit<=MinPFit
        BestP=bestP;
        MinPFit=minPFit;
        MinFit=minFit;
    end
    disp(['NITs= ' num2str(NITs) '; MinFit = ' num2str(MinFit) '; MinPFit  =' num2str(MinPFit)]);

    output1(NITs,:)=[minFit,minPFit,NFEs];
    output2(NITs,:)=[minPFit,max(PFit),mean(PFit)];
    output4(NITs,:)=[MinFit,MinPFit,NFEs];
    output5(NITs,:)=[BestP,NFEs];

end

figure(1);
plot((1:1:NITs),output2(:,1),'g',(1:1:NITs),output2(:,2),'r--',(1:1:NITs),output2(:,3),'b-.')
legend('min','max','mean');
xlabel('NITs');
ylabel('pfit');
