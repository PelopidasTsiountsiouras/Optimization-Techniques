function mutated_population = mutation(population, mutation_probability, mutation_step)
    [N, L] = size(population); 
    mutated_population = population; % Initialize output with current data
    
    for i = 1 : N
        for j = 1 : L
            if rand() <= mutation_probability % Probability check for each gene
                
                % 1. Apply Mutation
                mutated_population(i, j) = mutated_population(i, j) + mutation_step * randn();
                
                % 2. Identify and Enforce Constraints
                param_type = mod(j-1, 5) + 1; % Result is 1, 2, 3, 4, or 5
                
                if param_type == 2 % u1_center
                    % Keep within [-1, 2] 
                    if mutated_population(i, j) < -1
                        mutated_population(i, j) = -1; 
                    end
                    if mutated_population(i, j) > 2
                        mutated_population(i, j) = 2; 
                    end
                    
                elseif param_type == 3 % u2_center
                    % Keep within [-2, 1] 
                    if mutated_population(i, j) < -2
                        mutated_population(i, j) = -2;
                    end
                    if mutated_population(i, j) > 1
                        mutated_population(i, j) = 1; 
                    end
                    
                elseif param_type == 4 || param_type == 5 % Spreads
                    % Spreads must be > 0 to avoid division by zero
                    if mutated_population(i, j) <= 0
                        mutated_population(i, j) = 0.01; % Reset to small positive value
                    end
                end
            end
        end
    end
end