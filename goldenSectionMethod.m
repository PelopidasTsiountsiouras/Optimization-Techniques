function [k, a_list, b_list, f_evals] = goldenSectionMethod(func, a, b, l)

a_k = a;
b_k = b;
a_list = a_k;
b_list = b_k;
k = 1;
gamma = 0.618;

x_1 = a_k + (1 - gamma) * (b_k - a_k);
x_2 = a_k + gamma * (b_k - a_k);

f_1 = func(x_1);
f_2 = func(x_2);
f_evals = 2;

while (b_k - a_k) >= l
    
    if f_1 > f_2
        a_k = x_1;
        x_1 = x_2;
        x_2 = a_k + gamma * (b_k - a_k);
        f_1 = f_2;
        f_2 = func(x_2);
        f_evals = f_evals + 1;
    else
        b_k = x_2;
        x_2 = x_1;
        x_1 = a_k + (1 - gamma) * (b_k - a_k);
        f_2 = f_1;
        f_1 = func(x_1);
        f_evals = f_evals + 1;
    end

    k = k + 1;
    a_list(end+1) = a_k;
    b_list(end+1) = b_k;

end


end

