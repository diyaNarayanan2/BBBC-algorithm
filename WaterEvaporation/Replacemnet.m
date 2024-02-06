% Evaluating and Updating molecules by comparing the old and new ones.

function [WM,Fit,PFit]=Replacemnet(WM,newWM,Fit,PFit,Lb,Ub)
for i=1:size(WM,1)
    [X,fit,pfit]=fobj(newWM(i,:),Lb,Ub);
    if pfit<=PFit(i)
        WM(i,:)=X;
        Fit(i)=fit;
        PFit(i)=pfit;
    end
end