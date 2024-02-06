function [X, fit, pfit]= fobj_1D(X,Lb,Ub) 
% Correcting the design vector if it is not within the defined range.
for i = 1:size(X,1)
	if X(i)>Ub(i)
	  X(i)=Ub(i);
  end

	if X(i)<Lb(i)
	  X(i)=Lb(i);
  end
end

% Calculate inequality constraints (g(i)). Number of inequality constraints is 3.
g(1)=-X(1)

% Calculate the cost function (fit).
fit= 1/(6(X(1)-4)^2 +8);

% nou is penalty parameter. 
%Notice that penalty parameter is considered as a very big number and equal for all four inequality constraints.

nou=10^5;
penalty=0;

for i=1:size(g,2)
  if g(i)>0
    penalty=penalty+nou*g(i);
  end
end
% Calculate the penalized cost function (pfit) by adding measure of penalty function (penalty).

pfit =fit+penalty;

 
end