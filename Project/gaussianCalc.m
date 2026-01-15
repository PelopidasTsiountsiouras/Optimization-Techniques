function result = gaussianCalc(chromosome, input_data, gauss_number) 

result = 0; 

for i=0 : gauss_number-1 
    weights = chromosome(i*5+1); 
    u1_centers = chromosome(i*5+2); 
    u2_centers = chromosome(i*5+3); 
    u1_spreads = chromosome(i*5+4); 
    u2_spreads = chromosome(i*5+5);

    gaussian = exp(-(((input_data(1)-u1_centers)^2/(2*u1_spreads^2))+((input_data(2)-u2_centers)^2/(2*u2_spreads^2))));
    
    result = result + weights*gaussian; 
end 

end
