function [xmin, a_list, b_list, fevals, iterations] = dichotomous(f, a1, b1, eps, l)
% DICHOTOMOUS   Implements the Dichotomous Search exactly as defined in class.
%
%   Inputs:
%       f   - objective function handle
%       a1  - initial left endpoint (α1)
%       b1  - initial right endpoint (β1)
%       eps - ε > 0 (distance from midpoint)
%       l   - desired final interval length
%
%   Outputs:
%       xmin       - estimated minimizer
%       a_list     - list of αk values
%       b_list     - list of βk values
%       fevals     - number of function evaluations
%       iterations - number of iterations k

    % --- Initialization (from algorithm) ---
    ak = a1;
    bk = b1;
    k  = 1;

    a_list = ak;
    b_list = bk;

    fevals = 0;
    iterations = 0;

    % --- Algorithm loop ---
    while (bk - ak) >= l

        % Step 1: compute test points
        x1k = (ak + bk)/2 - eps;
        x2k = (ak + bk)/2 + eps;

        f1 = f(x1k);
        f2 = f(x2k);
        fevals = fevals + 2;

        % Step 2: interval update
        if f1 < f2
            ak_new = ak;
            bk_new = x2k;
        else
            ak_new = x1k;
            bk_new = bk;
        end

        % Move to next iteration
        ak = ak_new;
        bk = bk_new;

        k = k + 1;
        iterations = iterations + 1;

        % Save interval endpoints
        a_list(end+1) = ak;
        b_list(end+1) = bk;
    end

    % Final minimizer is the midpoint of the last interval
    xmin = (ak + bk) / 2;

end