function [x_min, f_min, f_values, iterations, trajectory] = steepestDescentMethod(e, f, start_x, gamma)
% STEEPEST_DECENT  Μέθοδος Μέγιστης Καθόδου
% e : tolerance
% f : @(x,y)
% start_x : [x0, y0]
% gamma : constant

    x_k = start_x(1);
    y_k = start_x(2);

    trajectory = [x_k, y_k];

    f_values = f(x_k, y_k);

    gk = gradient_f(f, x_k, y_k);

    iterations = 0;
    maxIter = 500;

    while norm(gk) > e && iterations < maxIter
        d_k = -gk;

        x_k = x_k + gamma * d_k(1);
        y_k = y_k + gamma * d_k(2);

        f_values(end+1) = f(x_k, y_k);

        gk = gradient_f(f, x_k, y_k);

        trajectory(end+1,:) = [x_k, y_k];

        iterations = iterations + 1;
    end

    x_min = [x_k, y_k];
    f_min = f_values(end);
end