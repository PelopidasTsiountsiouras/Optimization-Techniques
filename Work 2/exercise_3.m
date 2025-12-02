clc; clear; close all;

%% --- Objective Function ---
f = @(x,y) x.^3 .* exp(-x.^2 - y.^4);

%% --- Grid for contour / surface plots ---
[xg, yg] = meshgrid(-2:0.02:2, -2:0.02:2);
zg = f(xg, yg);

%% --- Parameters ---
startingPoints = [ 0 0; -1 -1; 1 1 ];
gamma_rules = {'constant','minimize','armijo'};
gamma_labels = {'Σταθερό γ','Minimize γ','Armijo γ'};
epsilon = 0.001;

all_results = cell(3,3);    % 3 gamma rules × 3 starting points
all_iters   = zeros(3,3);

%% === MAIN LOOP ===
for g = 1:3          % γ rule
    for s = 1:3      % starting point
        
        start = startingPoints(s,:);
        gamma_rule = gamma_rules{g};
        
        fprintf("\n--- Newtons Method | start (%d,%d) | gamma = %s ---\n", ...
                start(1),start(2),gamma_rule);
        
        % === Call your method (must return trajectory) ===
        [x_min, f_min, f_vals, iters, trajectory] = ...
            newtonMethod(epsilon, f, start, gamma_rule);
        
        if isempty(trajectory)
            warning("Trajectory empty for method %s at start (%d,%d)", ...
                gamma_rule, start(1),start(2));
            all_results{g,s} = [];
            all_iters(g,s) = 0;
        else
            all_results{g,s} = trajectory;
            all_iters(g,s)   = size(trajectory,1);
        end
        
        fprintf("Iterations = %d, final point = (%.4f, %.4f), f = %.6f\n", ...
                iters, x_min(1), x_min(2), f_min);
    end
end

%% === BAR PLOT: Iterations for each start/gamma ===
figure;
bar(all_iters);
xlabel('Γ κανόνας'); ylabel('Επαναλήψεις');
title('Αριθμός Επαναλήψεων Newtons Method');
set(gca,'XTickLabel',gamma_labels);
legend('Start (0,0)', 'Start (-1,-1)', 'Start (1,1)');

%% === 3 SEPARATE CONTOUR PLOTS (one for each gamma rule) ===
colors = {'red','blue','green'};
method_names = gamma_labels;

for g = 1:3
    figure('Position',[300+300*(g-1) 200 600 500]);
    
    % Contour background
    contour(xg, yg, zg, 20);
    hold on; grid on;
    xlabel('x'); ylabel('y');
    title(['Τροχιές Σύγκλισης - ', method_names{g}]);
    
    % Plot trajectories
    for s = 1:3
        traj = all_results{g,s};
        
        if isempty(traj) || size(traj,1) < 2
            continue;
        end
        
        % Line
        plot(traj(:,1), traj(:,2), '-', ...
            'Color', colors{s}, 'LineWidth', 1.8, ...
            'DisplayName', sprintf('Start %d: (%.1f,%.1f)', ...
                            s, startingPoints(s,1), startingPoints(s,2)));
        
        % Markers
        plot(traj(:,1), traj(:,2), 'o', ...
            'MarkerFaceColor', colors{s}, ...
            'MarkerEdgeColor', colors{s}, ...
            'MarkerSize', 4);
    end
    
    legend show;
    colorbar;
end
