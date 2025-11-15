function [xmin, a_list, b_list, fevals, iterations] = golden_section(f, a1, b1, l)
% GOLDEN_SECTION  Golden Section Search according to the algorithm used in class.
%
%   Implements the exact theoretical steps:
%
%       x1_k = a_k + (1 - γ) * (b_k - a_k)
%       x2_k = a_k + γ       * (b_k - a_k)
%
%   and interval updates based on f(x1_k) and f(x2_k).
%
% INPUTS:
%   f   - function handle for f(x)
%   a1  - initial left endpoint α1
%   b1  - initial right endpoint β1
%   l   - desired final interval length
%
% OUTPUTS:
%   xmin       - estimated minimizer
%   a_list     - list of αk values
%   b_list     - list of βk values
%   fevals     - total number of function evaluations
%   iterations - total number of iterations
%

    % Golden ratio constant
    gamma = 0.618;   % as stated in the algorithm

    % Initialization (k = 1)
    ak = a1;
    bk = b1;

    % First interior test points
    x1k = ak + (1 - gamma) * (bk - ak);
    x2k = ak + gamma       * (bk - ak);

    % Evaluate f at the two points
    f1 = f(x1k);
    f2 = f(x2k);

    fevals = 2;  % count initial evaluations
    iterations = 1;

    % Lists for plotting
    a_list = ak;
    b_list = bk;

    % --- MAIN LOOP ---
    while (bk - ak) >= l

        if f1 > f2
            % --- Step 2 from algorithm ---
            % Minimum is in [x1_k, b_k]
            ak_new = x1k;
            bk_new = bk;

            % Update points:
            % x1_{k+1} = x2_k
            x1_new = x2k;

            % x2_{k+1} = a_{k+1} + γ * (b_{k+1} - a_{k+1})
            x2_new = ak_new + gamma * (bk_new - ak_new);

            % Evaluate f(x1_{k+1})
            f1_new = f(x1_new);
            fevals = fevals + 1;

            % Keep f2 from previous step because x2_new is new
            f2_new = f2;
            
        else
            % --- Step 3 from algorithm ---
            % Minimum is in [a_k, x2_k]
            ak_new = ak;
            bk_new = x2k;

            % Update points:
            % x2_{k+1} = x1_k
            x2_new = x1k;

            % x1_{k+1} = a_{k+1} + (1 - γ) * (b_{k+1} - a_{k+1})
            x1_new = ak_new + (1 - gamma) * (bk_new - ak_new);

            % Evaluate f(x2_{k+1})
            f2_new = f(x2_new);
            fevals = fevals + 1;

            % Keep previous f1 for new location
            f1_new = f1;
        end

        % Update iteration data
        ak = ak_new;
        bk = bk_new;

        x1k = x1_new;
        x2k = x2_new;
        f1  = f1_new;
        f2  = f2_new;

        iterations = iterations + 1;

        a_list(end+1) = ak;
        b_list(end+1) = bk;
    end

    % Final estimated minimizer
    xmin = (ak + bk) / 2;

end