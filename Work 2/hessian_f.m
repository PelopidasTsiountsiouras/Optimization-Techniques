function H = hessian_f(f, x, y)
% HESSIAN_F   Αριθμητική προσέγγιση Hessian 2x2 της f στο (x,y)
%   f : @(x,y)
%   H : 2x2 πίνακας

    h = 1e-4;

    % Βοηθητικά
    f_xx_plus  = f(x + h, y);
    f_xx_minus = f(x - h, y);
    f_yy_plus  = f(x, y + h);
    f_yy_minus = f(x, y - h);

    f_xy_pp = f(x + h, y + h);
    f_xy_pm = f(x + h, y - h);
    f_xy_mp = f(x - h, y + h);
    f_xy_mm = f(x - h, y - h);

    f_xy = (f_xy_pp - f_xy_pm - f_xy_mp + f_xy_mm) / (4*h*h);

    f_center = f(x, y);

    f_xx = (f_xx_plus - 2*f_center + f_xx_minus) / (h*h);
    f_yy = (f_yy_plus - 2*f_center + f_yy_minus) / (h*h);

    H = [f_xx, f_xy;
         f_xy, f_yy];
end
