function [k, a_list, b_list, f_evals] = goldenSectionMethod(func, a, b, tol)
% GOLDENSECTIONMETHOD  1D ελαχιστοποίηση στο [a,b]
% func : @(g)
% tol  : ανοχή στο μήκος διαστήματος

    gamma = 0.618;
    a_k = a;
    b_k = b;

    a_list = a_k;
    b_list = b_k;

    % αρχικά εσωτερικά σημεία
    x1 = a_k + (1 - gamma)*(b_k - a_k);
    x2 = a_k + gamma*(b_k - a_k);

    f1 = func(x1);
    f2 = func(x2);

    f_evals = 2;
    k = 1;

    while (b_k - a_k) > tol && k < 200
        if f1 > f2
            a_k = x1;
            x1 = x2;
            f1 = f2;
            x2 = a_k + gamma*(b_k - a_k);
            f2 = func(x2);
        else
            b_k = x2;
            x2 = x1;
            f2 = f1;
            x1 = a_k + (1 - gamma)*(b_k - a_k);
            f1 = func(x1);
        end
        f_evals = f_evals + 1;
        k = k + 1;
        a_list(end+1) = a_k;
        b_list(end+1) = b_k;
    end
end
