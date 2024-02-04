function [X, fit, pfit]= fobj(X,Lb,Ub) 
%adjusting design vector to maintain bound range
for i = 1:size(X,1)
	if X(i)>Ub(i)
	  X(i)=Ub(i);
  end

	if X(i)<Lb(i)
	  X(i)=Lb(i);
  end
end


g(1)= X(1)^2 +X(2)^2 -10;
%fit=X(1)^2 +X(2)^2 -10;



% g(1)= X(1).^2 + X(2).^2 + 25*(sin(X(1)).^2 + sin(X(2)).^2);
% g(2)=X(1).^4 + X(2)^4;
g(2)= (X(1))^2;
fit=-(X(1).^2 + X(2).^2 + 25*(sin(X(1)).^2 + sin(X(2)).^2));
g(3) = (X(2))^2;
% g(1)=1-(X(2)^3*X(3))/(71785*X(1)^4);
% g(2)=1-(140.45*X(1))/(X(2)^2*X(3));
% g(3)=(X(1)+X(2))/(1.5)-1;
%fit=(X(3)+2)*X(2)*X(1)^2;

% nou is penalty parameter. 
nou=10000;
penalty=0;

for i=1:size(g,2)
  if g(i)>0
    penalty=penalty+nou*g(i);
  end
end

%finding penalised cost function
pfit =fit+penalty;

 
end