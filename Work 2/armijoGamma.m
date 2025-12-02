function gamma = armijoGamma(f, x_k, y_k, d_k)
% ARMIJOGAMMA  Armijo backtracking για επιλογή βήματος γ

    alpha = 1e-4;   % c στο Armijo
    beta  = 0.5;    % συντελεστής μείωσης
    gamma = 1.0;    % αρχικό βήμα

    % gradient στο (x_k, y_k)
    gk = gradient_f(f, x_k, y_k);

    f0 = f(x_k, y_k);

    max_backtracks = 50;
    bt = 0;

    while true
        x_new = x_k + gamma * d_k(1);
        y_new = y_k + gamma * d_k(2);

        f_new = f(x_new, y_new);

        if f_new <= f0 + alpha * gamma * (gk' * d_k)
            break;  % ικανοποιεί Armijo
        end

        gamma = beta * gamma;
        bt = bt + 1;
        if bt >= max_backtracks
            % ασφάλεια: μην κολλήσει ποτέ
            break;
        end
    end
end
