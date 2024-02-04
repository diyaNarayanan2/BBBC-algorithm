function [X, fit, pfit]= fobj(X,Lb,Ub) 
% Correcting the design vector if it is not within the defined range.
for i = 1:size(X,1)
	if X(i)>Ub(i)
	  X(i)=Ub(i);
  end

	if X(i)<Lb(i)
	  X(i)=Lb(i);
  end
end

% Calculate inequality constraints (g(i))

g(1)= X(1).^2 + X(2).^2 + 25*(sin(X(1)).^2 + sin(X(2)).^2);
fit=-(X(1).^2 + X(2).^2 + 25*(sin(X(1)).^2 + sin(X(2)).^2));


% g(1)= X(1)^2 +X(2)^2 -10;
% g(2)= (X(1))^2;
% g(3) = (X(2))^2;
g(2)=X(1).^4 + X(2)^4;
% fit=X(1)^2 +X(2)^2 -10;

% nou is penalty parameter. 
nou=10^5;
penalty=0;

for i=1:size(g,2)
  if g(i)>0
    penalty=penalty+nou*g(i);
  end
end

% Calculate the penalized cost function

pfit =fit+penalty;
 
end