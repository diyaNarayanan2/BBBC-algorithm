function CM = Big_Crunch(P, PFit)
    [~, numCols] = size(P);
    CM = zeros(1, numCols); % Preallocate 

    for i = 1:numCols
        CM(i) = sum(P(:, i) ./ PFit) / sum(1 ./ PFit);
    end
end
