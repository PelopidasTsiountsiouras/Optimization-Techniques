clc; clear; close all;

%% ----- Objective Function -----
f = @(x1,x2) (1/3 * x1.^2) + (3 * x2.^2);

%% ----- Grid για contour -----
[xg, yg] = meshgrid(-20:0.05:20, -20:0.05:20);
zg = f(xg, yg);

%% ----- Parameters -----
epsilon = 0.01;
gamma  = 0.1;
s_k = 15;
start   = [-5 10];

[xmin, fmin, fvals, iters, traj] = ...
    steepestDescentProjectionMethod(epsilon, f, start, gamma, s_k);

fprintf("iterations = %d, final = (%.4f, %.4f), f = %.6f\n", ...
        iters, xmin(1), xmin(2), fmin);

%% ===== Plot A: Convergence f(k) (one per gamma) =====
figure;
plot(fvals, 'LineWidth', 2);
grid on;
xlabel('k'); ylabel('f(x_k)');
title(['Σύγκλιση f(x_k) για \gamma = ', num2str(gamma), ',  s_k = ', num2str(s_k)]);

%% ===== Plot B: contour + trajectory (one per gamma) =====
figure;
contour(xg, yg, zg, 25);
hold on; grid on;
plot(traj(:,1), traj(:,2), '-o', 'LineWidth', 2);

xlabel('x'); ylabel('y');
title(['Τροχιά Σύγκλισης για \gamma = ', num2str(gamma), ', s_k = ', num2str(s_k)]);
colorbar;

