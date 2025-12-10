function g = gradient_f(f, x, y)
% GRAD_F   Αριθμητική προσέγγιση του gradient της f στο (x,y)
%   f : @(x,y)
%   g : 2x1 διάνυσμα [df/dx ; df/dy]

    h = 1e-6;

    dfdx = (f(x + h, y) - f(x - h, y)) / (2*h);
    dfdy = (f(x, y + h) - f(x, y - h)) / (2*h);

    g = [dfdx; dfdy];
end
