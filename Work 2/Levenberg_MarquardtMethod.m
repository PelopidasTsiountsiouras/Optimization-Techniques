function [x_min, f_min, f_values, iterations, trajectory] = Levenberg_MarquardtMethod(e, f, start_x, gamma_calculator)
% LEVENBERG_MARQ  Μέθοδος Levenberg–Marquardt

    x_k = start_x(1);
    y_k = start_x(2);

    trajectory = [x_k, y_k];

    f_values = f(x_k, y_k);
    gk = gradient_f(f, x_k, y_k);

    iterations = 0;
    maxIter = 200;

    while norm(gk) > e && iterations < maxIter

        H = hessian_f(f, x_k, y_k);

        % Βρες μ ώστε H + μI να είναι θετικά ορισμένος
        mu = 1;
        A = H + mu*eye(2);
        eigA = eig(A);
        safety = 0;
        while ~all(eigA > 0) && safety < 50
            mu = mu + 1;
            A = H + mu*eye(2);
            eigA = eig(A);
            safety = safety + 1;
        end

        % d_k = -(H+μI)^{-1} gk
        d_k = - A \ gk;

        % γ από τους κανόνες
        gamma = calculateGamma(f, x_k, y_k, d_k, gamma_calculator);

        % ενημέρωση
        x_k = x_k + gamma * d_k(1);
        y_k = y_k + gamma * d_k(2);

        % αποθήκευση f
        f_values(end+1) = f(x_k, y_k);

        % νέο gradient
        gk = gradient_f(f, x_k, y_k);

        trajectory(end+1,:) = [x_k, y_k];

        iterations = iterations + 1;
    end

    x_min = [x_k, y_k];
    f_min = f_values(end);
end
