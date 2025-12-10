clc; clear; close all;

%% ----- Objective Function -----
f = @(x1,x2) (1/3 * x1.^2) + (3 * x2.^2);

%% ----- Grid για contour -----
[xg, yg] = meshgrid(-20:0.05:20, -20:0.05:20);
zg = f(xg, yg);

%% ----- Parameters -----
epsilon = 0.001;
gammas  = [0.1 0.3 3 5];
start   = [10 10];

trajectories = cell(1,length(gammas));
f_history    = cell(1,length(gammas));
iterations   = zeros(1,length(gammas));

%% ================= LOOP =================
for k = 1:length(gammas)
    
    gamma = gammas(k);
    fprintf("\n====== gamma = %.2f ======\n",gamma);

    [xmin, fmin, fvals, iters, traj] = ...
        steepestDescentMethod(epsilon, f, start, gamma);

    trajectories{k} = traj;
    f_history{k} = fvals;
    iterations(k) = iters;

    fprintf("iterations = %d, final = (%.4f, %.4f), f = %.6f\n", ...
            iters, xmin(1), xmin(2), fmin);

    %% ===== Plot A: Convergence f(k) (one per gamma) =====
    figure;
    plot(fvals, 'LineWidth', 2);
    grid on;
    xlabel('k'); ylabel('f(x_k)');
    title(['Σύγκλιση f(x_k) για \gamma = ', num2str(gamma)]);
    
    %% ===== Plot B: contour + trajectory (one per gamma) =====
    figure;
    contour(xg, yg, zg, 25);
    hold on; grid on;
    plot(traj(:,1), traj(:,2), '-o', 'LineWidth', 2);
    
    xlabel('x'); ylabel('y');
    title(['Τροχιά Σύγκλισης για \gamma = ', num2str(gamma)]);
    colorbar;

end

%% ===== Plot C: bar chart iterations (one total) =====
figure;
bar(iterations);
title('Επαναλήψεις μέχρι σύγκλιση');
set(gca,'XTickLabel',{'0.1','0.3','3','5'});
xlabel('\gamma');
ylabel('Iterations');
grid on;
