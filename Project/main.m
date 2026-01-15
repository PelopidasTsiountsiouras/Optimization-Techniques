%% --- 1. Constants and GA Hyperparameters ---
N = 100;                    % Population Size
gauss_number = 15;          % Number of Gaussians
target_error = 0.001;        % Stop if MSE is below this
max_generations = 1000;      % Maximum iterations
crossover_probability = 0.8;
mutation_probability = 0.05;
mutation_step = 0.1;

% Range of inputs
u1_range = [-1, 2];
u2_range = [-2, 1];

%% --- 2. Data Preparation ---
% Training Data (500 points)
u1_vals = u1_range(1) + (u1_range(2) - u1_range(1)) * rand(500, 1);
u2_vals = u2_range(1) + (u2_range(2) - u2_range(1)) * rand(500, 1); 
y_true = sin(u1_vals + u2_vals) .* sin(u2_vals.^2); 

% Validation Data (Unseen by the GA)
u1_test = u1_range(1) + (u1_range(2) - u1_range(1)) * rand(500, 1); 
u2_test = u2_range(1) + (u2_range(2) - u2_range(1)) * rand(500, 1);
y_test_true = sin(u1_test + u2_test) .* sin(u2_test.^2);

%% --- 3. Initial Population ---
% Structure: [w, c1, c2, s1, s2] x 15
population = zeros(N, 75); 
population(:, 1:5:end) = -2 + 4 * rand(N, 15);           % Weights [-2, 2]
population(:, 2:5:end) = -1 + 3 * rand(N, 15);           % c1 centers [-1, 2]
population(:, 3:5:end) = -2 + 3 * rand(N, 15);           % c2 centers [-2, 1]
population(:, 4:5:end) = 0.1 + 0.9 * rand(N, 15);        % s1 spreads [0.1, 1]
population(:, 5:5:end) = 0.1 + 0.9 * rand(N, 15);        % s2 spreads [0.1, 1]

error_history = [];
generation_counter = 1;
best_ever_error = inf;

%% --- 4. Main Evolutionary Loop ---
while generation_counter <= max_generations
    errors = zeros(N, 1);
    
    % Step A: Evaluation (Fitness)
    for i = 1 : N
        total_sq_error = 0;
        for k = 1 : length(u1_vals)
            y_pred = gaussianCalc(population(i,:), [u1_vals(k), u2_vals(k)], gauss_number);
            total_sq_error = total_sq_error + (y_pred - y_true(k))^2;
        end
        errors(i) = total_sq_error / length(u1_vals);
    end
    
    % Step B: Track Best and Elitism
    [current_min_error, best_idx] = min(errors);
    error_history(generation_counter) = current_min_error;
    
    if current_min_error < best_ever_error
        best_ever_error = current_min_error;
        best_chromosome = population(best_idx, :);
    end
    
    % Termination Check
    if current_min_error < target_error
        fprintf('Target error reached at generation %d!\n', generation_counter);
        break;
    end
    
    % Step C: Evolution
    mating_pool = selection(population, errors);
    offspring = crossover(mating_pool, crossover_probability);
    mutated_pop = mutation(offspring, mutation_probability, mutation_step);
    
    % Step D: Apply Elitism 
    % Put the best-ever individual back into the population
    population = mutated_pop;
    population(1, :) = best_chromosome; 
    
    fprintf('Gen %d: Best MSE = %.6f\n', generation_counter, current_min_error);
    generation_counter = generation_counter + 1;
end

%% --- 5. Final Observations and Results ---
% Final Validation on unseen data
y_pred_test = zeros(length(u1_test), 1);
for k = 1:length(u1_test)
    y_pred_test(k) = gaussianCalc(best_chromosome, [u1_test(k), u2_test(k)], gauss_number);
end
final_MSE = mean((y_pred_test - y_test_true).^2);
fprintf('\n--- FINAL RESULTS ---\n');
fprintf('Validation MSE: %.6f\n', final_MSE);

% 3D Plots for Project Report
[U1, U2] = meshgrid(-1:0.05:2, -2:0.05:1);
Z_true = sin(U1 + U2) .* sin(U2.^2);
Z_pred = zeros(size(U1));
for r = 1:size(U1,1)
    for c = 1:size(U1,2)
        Z_pred(r,c) = gaussianCalc(best_chromosome, [U1(r,c), U2(r,c)], gauss_number);
    end
end

figure(1);
plot(error_history, 'LineWidth', 2); title('Learning Curve');
xlabel('Generation'); ylabel('Best MSE'); grid on;

figure(2);
subplot(1,2,1); surf(U1, U2, Z_true); title('True Function'); shading interp;
subplot(1,2,2); surf(U1, U2, Z_pred); title('GA Approximation'); shading interp;