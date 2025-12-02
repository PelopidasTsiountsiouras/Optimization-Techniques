function gamma = minimizeGamma(f, x_k, y_k, d_k)
% MINIMIZEGAMMA  βρίσκει γ που ελαχιστοποιεί f(x_k + γ d_k)

    phi = @(g) f(x_k + g*d_k(1), y_k + g*d_k(2));

    [~, a_list, b_list, ~] = goldenSectionMethod(phi, 0, 1, 1e-2);

    a_final = a_list(end);
    b_final = b_list(end);

    gamma = (a_final + b_final)/2;
end
