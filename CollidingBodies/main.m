clc
clear

nV=2; 
Lb=[-10 -10]; % Lower bounds 
Ub=[10 10]; % Upper bounds 


nCB=10; % Number of colliding bodies.
maxNFEs=300; 


for i=1:nCB
    CB(i,:)=Lb+(Ub-Lb).*rand(1,nV); 
end

for i=1:nCB
    [X,fit,pfit]=fobj(CB(i,:),Lb,Ub);
    CB(i,:)=X;
    Fit(i)=fit;
    PFit(i)=pfit;
end

% Monitor best the so far candidate solution (BestCB) and its corresponding
%penalized objective function (MinPFit) and objective function (MinFit).
[MinPFit,m]=min(PFit);
MinFit=Fit(m);
BestCB=CB(m,:);

% xRange = linspace(-6, 6, 100);
% yRange = linspace(-6, 6, 100);
% [X_0, Y_0] = meshgrid(xRange, yRange);
% Z_0 = -X_0.^2 - Y_0.^2 + 10; 

xRange = linspace(-6, 6, 100);
yRange = linspace(-6, 6, 100);
[X_0, Y_0] = meshgrid(xRange, yRange);
Z_0 = X_0.^2 + Y_0.^2 + 25*(sin(X_0).^2 + sin(Y_0).^2); 

%% Algorithm Body
NFEs=0;
NITs=0; 
maxNITs=maxNFEs/nCB; 
while NFEs<maxNFEs
    NITs=NITs+1; 


    
    M=(1./PFit)./(sum(1./PFit));
    
    [CB, M, Fit, PFit, stepsize] = Collision(CB, M, Fit, PFit, NITs, maxNITs);

    % Preallocate newCB with zeros
    newCB = zeros(nCB, size(CB, 2)); 
    
    for i = 1:nCB
        if i <= nCB / 2
            newCB(i, :) = CB(i, :) + rand(1, nV) .* stepsize(i, :);
        else
            newCB(i, :) = CB(i - nCB / 2, :) + rand(1, nV) .* stepsize(i, :);
        end
    end

    figure; 
    surf(X_0, Y_0, Z_0); 
    colormap('parula'); 
    view(-55,5);
    shading interp;

    hold on;
    scatter3(newCB(:,1), newCB(:,2), -newCB(:,1).^2 - newCB(:,2).^2 + 10, 'r', 'filled'); % Plot new particles
    xlabel('X_0');
    ylabel('Y_0');
    zlabel('Z_0');
    title(['Iteration ' num2str(NITs)]);
    hold off;
    pause(0.01);

    
    for i=1:nCB
        [X,fit,pfit]=fobj(newCB(i,:),Lb,Ub);
        CB(i,:)=X;
        Fit(i)=fit;
        PFit(i)=pfit;
    end
   
    NFEs=NFEs+nCB;

    [minPFit,m]=min(PFit);
    minFit=Fit(m);
    bestCB=CB(m,:);

    % Monitor best of the so far candidate solution (BestCB) and its
    %corresponding penalized objective function (MinPFit) and objective function (MinFit).
    if minPFit<=MinPFit
        BestCB=bestCB;
        MinPFit=minPFit;
        MinFit=minFit;
    end

    disp(['NITs= ' num2str(NITs) '; MinFit = ' num2str(MinFit) '; MinPFit = ' num2str(MinPFit)]);

    output1(NITs,:)=[MinFit,MinPFit,NFEs];
    output2(NITs,:)=[min(PFit),max(PFit),mean(PFit)];
    output3(NITs,:)=[BestCB,NFEs];
end

%% Monitoring the results
figure;
plot((1:1:NITs),output2(:,1),'g',(1:1:NITs),output2(:,2),'r-- ',(1:1:NITs),output2(:,3),'b-.')
legend('min','max','mean');
xlabel('NITs');
ylabel('PFit');