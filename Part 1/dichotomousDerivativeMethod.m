function [k, a_list, b_list, df_evals] = dichotomousDerivativeMethod(diff_func, a, b, l)

    syms x;

    % Precompute n from theory
    n = ceil( log( l / (b - a) ) / log(1/2) );

    % Initialization
    k = 1;
    a_k = a;
    b_k = b;

    a_list = a_k;
    b_list = b_k;

    df_evals = 0;

    % Main loop
    while true

        % Calculation of the midpoint
        x_k = (a_k + b_k) / 2;

        diff_f_xk = subs(diff_func, x, x_k);
        df_evals = df_evals + 1;

        % Derivative check
        if abs(diff_f_xk) < 1e-12   % I don't use exactly =0, because float numbers are never exact and numerical derivatives give small residual error
            % Minimum found exactly
            a_k = x_k;
            b_k = x_k;
            a_list(end+1) = a_k;
            b_list(end+1) = b_k;
            return;
        elseif diff_f_xk > 0
            a_k = a_k;
            b_k = x_k;
        else
            a_k = x_k;
            b_k = b_k;
        end

        % Save interval
        a_list(end+1) = a_k;
        b_list(end+1) = b_k;

        % Check if k = n
        if k == n
            return;
        end

        k = k + 1;
    end

end
