function [k, a_list, b_list, f_evals] = dichotomousMethod(func, a, b, l, e)

% Initialization
k = 1;

a_k = a;
b_k = b;

f_evals = 0;

a_list = a_k;
b_list = b_k;

% Main loop
while (b_k - a_k) >= l

    x_1 = (a_k + b_k) / 2 - e;
    x_2 = (a_k + b_k) / 2 + e;

    f_1 = func(x_1);
    f_2 = func(x_2);
    f_evals = f_evals + 2;

    if f_1 < f_2
        % Interval shifts left
        b_k = x_2;
    else
        % Interval shifts right
        a_k = x_1;
    end

    a_list(end+1) = a_k;
    b_list(end+1) = b_k;
    k = k + 1;

end

end

