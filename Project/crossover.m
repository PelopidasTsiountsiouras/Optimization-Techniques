function new_population = crossover(parents, crossover_probability)
    [N, L] = size(parents); % Get rows (N) and columns (L)
    new_population = zeros(N, L);
    
    for i = 1 : 2 : N
        k = rand(); % Generate a random number between 0 and 1
        
        if k <= crossover_probability
            cp = randi(L-1); % Pick a random point between 1 and 74
            
            % Create Child 1
            new_population(i, :) = [parents(i, 1:cp), parents(i+1, cp+1:end)];
            
            % Create Child 2
            new_population(i+1, :) = [parents(i+1, 1:cp), parents(i, cp+1:end)];
        else
            % No crossover: Copy parents directly
            new_population(i, :) = parents(i, :);
            new_population(i+1, :) = parents(i+1, :);
        end
    end
end