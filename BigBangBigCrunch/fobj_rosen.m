% Creating a grid of points
x = linspace(-4.5, 4.5, 75); 
y = linspace(-4.5, 4.5, 75); 
[X, Y] = meshgrid(x, y);

% Evaluating Beale's function
Z = (1.5 - X + X.*Y).^2 + (2.25 - X + X.*Y.^2).^2 + (2.625 - X + X.*Y.^3).^2;

% Plotting
figure;
surf(X, Y, Z)
colormap(jet)
title('Beale Function')
xlabel('x')
ylabel('y')
zlabel('f(x, y)')
