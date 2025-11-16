function [k, a_list, b_list, df_evals] = dichotomousDerivativeMethod(diff_func, a, b, l)

    syms x;

    % Step 0: Precompute n from theory
    n = ceil( log( l / (b - a) ) / log(1/2) );

    % Initialization
    k = 1;
    a_k = a;
    b_k = b;

    a_list = a_k;
    b_list = b_k;

    df_evals = 0;

    while true

        % Step 1: Midpoint
        x_k = (a_k + b_k) / 2;

        diff_f_xk = subs(diff_func, x, x_k);
        df_evals = df_evals + 1;

        % Derivative check
        if abs(diff_f_xk) < 1e-12
            % Minimum found exactly
            a_k = x_k;
            b_k = x_k;
            a_list(end+1) = a_k;
            b_list(end+1) = b_k;
            return;
        elseif diff_f_xk > 0
            % Step 2
            a_k = a_k;
            b_k = x_k;
        else
            % Step 3
            a_k = x_k;
            b_k = b_k;
        end

        % Save interval
        a_list(end+1) = a_k;
        b_list(end+1) = b_k;

        % Step 4: Check if k = n
        if k == n
            return;
        end

        k = k + 1;
    end

end
