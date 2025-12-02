function [x_min, f_min, f_values, iterations, trajectory] = newtonMethod(e, f, start_x, gamma_calculator)
% NEWTONS_METHOD  Μέθοδος Newton για 2D f(x,y)

    x_k = start_x(1);
    y_k = start_x(2);

    trajectory = [x_k, y_k];

    f_values = f(x_k, y_k);
    gk = gradient_f(f, x_k, y_k);

    iterations = 0;
    maxIter = 500;

    while norm(gk) > e && iterations < maxIter

        H = hessian_f(f, x_k, y_k);

        % direction d_k = -H^{-1} gk  (σωστά μέσω backslash)
        d_k = - H \ gk;

        % βήμα γ
        gamma = calculateGamma(f, x_k, y_k, d_k, gamma_calculator);

        % ενημέρωση
        x_k = x_k + gamma * d_k(1);
        y_k = y_k + gamma * d_k(2);

        % αποθήκευση
        f_values(end+1) = f(x_k, y_k);

        % νέο gradient
        gk = gradient_f(f, x_k, y_k);

        trajectory(end+1,:) = [x_k, y_k];

        iterations = iterations + 1;
    end

    x_min = [x_k, y_k];
    f_min = f_values(end);
end
