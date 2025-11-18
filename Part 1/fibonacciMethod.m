function [k, a_list, b_list, f_evals] = fibonacciMethod(func, a, b, l, e)

    % Initialization
    a_k = a;
    b_k = b;
    a_list = a_k;
    b_list = b_k;

    % Determine N using Fibonacci numbers
    F_prev = 1;
    F_curr = 1;
    N = 2;   % because we already have F1 = F2 = 1

    while F_curr < (b_k - a_k) / l
        F_next = F_prev + F_curr;
        F_prev = F_curr;
        F_curr = F_next;
        N = N + 1;
    end

    % Initial interior points
    x_1 = a_k + (fibonacci(N-2) / fibonacci(N)) * (b_k - a_k);
    x_2 = a_k + (fibonacci(N-1) / fibonacci(N)) * (b_k - a_k);

    f_1 = func(x_1);
    f_2 = func(x_2);
    f_evals = 2;

    k = 1;

    % Main loop
    while true
        
        if f_1 > f_2
            % Interval shifts right
            a_k = x_1;

            x_1 = x_2;
            f_1 = f_2;   % reuse

            x_2 = a_k + (fibonacci(N - k - 1) / fibonacci(N - k)) * (b_k - a_k);

            if k ~= N - 2
                f_2 = func(x_2);
                f_evals = f_evals + 1;
            end

        else
            % Interval shifts left
            b_k = x_2;

            x_2 = x_1;
            f_2 = f_1;   % reuse

            x_1 = a_k + (fibonacci(N - k - 2) / fibonacci(N - k)) * (b_k - a_k);

            if k ~= N - 2
                f_1 = func(x_1);
                f_evals = f_evals + 1;
            end
        end

        % Termination condition (step N - 2)
        if k == N - 2
            x_2 = x_1 + e;
            f_2 = func(x_2);
            f_evals = f_evals + 1;

            if f_1 > f_2
                a_k = x_1;
            else
                b_k = x_2;
            end

            a_list(end+1) = a_k;
            b_list(end+1) = b_k;
            return;
        end

        a_list(end+1) = a_k;
        b_list(end+1) = b_k;

        k = k + 1;

    end

end
