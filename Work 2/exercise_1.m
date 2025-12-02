syms x y;

f = @(x,y) x.^(3) .* exp(-x.^(2)-y.^(4));

[xg, yg] = meshgrid(-3:0.1:3, -3:0.1:3);
zg = f(xg, yg);

surf(xg, yg, zg);
xlabel('x'); ylabel('y'); zlabel('f(x,y)');
title('Surface Plot of f(x,y)');
colorbar   % adds color scale
shading interp   % makes it smooth
