function new_data = selection(population, error)
    [N, L] = size(population); 
    new_data = zeros(N, L);
    
    for i = 1 : N
        % Pick random indices for the tournament
        k_1 = randi(N);
        k_2 = randi(N);
        k_3 = randi(N);

        competitors = [error(k_1), error(k_2), error(k_3)];
        [~, index] = min(competitors);

        if index == 1
            new_data(i, :) = population(k_1, :);
       elseif index == 2
           new_data(i, :) = population(k_2, :);
       elseif index == 3
           new_data(i, :) = population(k_3, :);
       end
       
    end

end