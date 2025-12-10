function [x_min, f_min, f_values, iterations, trajectory] = steepestDescentProjectionMethod(e, f, start_x, gamma, sk)

    % Initialization
    iterations = 1;
    xk = start_x(:)';   % ensure row
    trajectory = xk;

    f_values = f(xk(1), xk(2));

    grad_fk = gradient_f(f, xk(1), xk(2));

    % Restraints
    x_rest = [-10, 5; -8, 12];

    while norm(grad_fk) > e && iterations < 500
        
        dk = -grad_fk;

        x_bar = xk + (sk * dk)';

        % Projection
        for i = 1:length(x_bar)
            if x_bar(i) < x_rest(i,1)
                x_bar(i) = x_rest(i,1);
            elseif x_bar(i) > x_rest(i,2)
                x_bar(i) = x_rest(i,2);
            end
        end

        % Update based on gamma
        xk = xk + gamma * (x_bar - xk);

        % Store values
        f_values(end+1) = f(xk(1), xk(2));
        grad_fk = gradient_f(f, xk(1), xk(2));
        trajectory(end+1,:) = xk;

        iterations = iterations + 1;
    end

    x_min = xk;
    f_min = f_values(end);
end
