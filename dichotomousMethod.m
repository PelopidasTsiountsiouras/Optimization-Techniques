function [k, a_list, b_list, f_evals] = dichotomousMethod(func, a, b, l, step)

k = 0;
a_k = a;
b_k = b;
f_evals = 0;
counts = 1;
a_list = a_k;
b_list = b_k;

while (b_k - a_k) >= l

    x_1 = (a_k + b_k) / 2 - step;
    x_2 = (a_k + b_k) / 2 + step;

    f_1 = func(x_1);
    f_2 = func(x_2);
    f_evals = f_evals + 2;

    if f_1 < f_2
        b_k = x_2;
    else
        a_k = x_1;
    end

    a_list(end+1) = a_k;
    b_list(end+1) = b_k;
    counts = counts + 1;

end

end

