function gamma = calculateGamma(f, x_k, y_k, d_k, gamma_calculator)
% CALCULATEGAMMA  επιλέγει τη μέθοδο για γ

    if strcmp(gamma_calculator, "constant")
        gamma = 0.1;                    
    elseif strcmp(gamma_calculator, "minimize")
        gamma = minimizeGamma(f, x_k, y_k, d_k);
    elseif strcmp(gamma_calculator, "armijo")
        gamma = armijoGamma(f, x_k, y_k, d_k);
    else
        error("Invalid gamma calculator");
    end
end
