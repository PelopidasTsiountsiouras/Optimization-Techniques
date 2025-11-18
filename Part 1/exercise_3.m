clc;
close all;
clear;

%Functions to optimize
f1 = @(x) 5^x + (2 - cos(x))^2;
f2 = @(x) (x-1)^2 + exp(x-5) * sin(x+3);
f3 = @(x) exp(-3*x) - (sin(x-2) - 2)^2;

%Define the interval [a, b]
a = -1;
b = 3;

e = 0.001;

%% Run fibonacci method for each l
l_values = [1, 0.5, 0.3, 0.2, 0.1, 0.05, 0.02, 0.01, 0.005, 0.003];

% Pre-registration of the matrixes
evals_f1 = zeros(size(l_values));
evals_f2 = zeros(size(l_values));
evals_f3 = zeros(size(l_values));

% Loop for each l
for k = 1:length(l_values)
    l = l_values(k);
    
    [~, ~, ~, evals_f1(k)] = fibonacciMethod(f1, a, b, l, e);
    [~, ~, ~, evals_f2(k)] = fibonacciMethod(f2, a, b, l, e);
    [~, ~, ~, evals_f3(k)] = fibonacciMethod(f3, a, b, l, e);
end

% Plots
figure;
plot(l_values, evals_f1, '-o');
xlabel('l'); ylabel('Αριθμός αξιολογήσεων f_1(x)');
title('Μεταβολή αξιολογήσεων για f_1');
grid on;

figure;
plot(l_values, evals_f2, '-o');
xlabel('l'); ylabel('Αριθμός αξιολογήσεων f_2(x)');
title('Μεταβολή αξιολογήσεων για f_2');
grid on;

figure;
plot(l_values, evals_f3, '-o');
xlabel('l'); ylabel('Αριθμός αξιολογήσεων f_3(x)');
title('Μεταβολή αξιολογήσεων για f_3');
grid on;

%% Plot the interval bounds for different interval lengths
l_values = [1, 0.5, 0.3, 0.2, 0.1, 0.05, 0.02, 0.01, 0.005, 0.003];

% Loop for each l for f_1
figure;
hold on; grid on;
for i = 1:length(l_values)
    l = l_values(i);

    [k, a_list, b_list, ~] = fibonacciMethod(f1, a, b, l, e);

    it = 1:length(a_list);  % δείκτης επαναλήψεων

    plot(it, a_list, '-o', 'DisplayName', sprintf('a_k, l=%.4f', l));
    plot(it, b_list, '--o', 'DisplayName', sprintf('b_k, l=%.4f', l));
end

xlabel('k');
ylabel('Τιμές a_k και b_k');
title('Εξέλιξη άκρων [a_k, b_k] για f_1(x)');
legend show;
hold off;

% Loop for each l for f_2
figure;
hold on; grid on;
for i = 1:length(l_values)
    l = l_values(i);

    [k, a_list, b_list, ~] = fibonacciMethod(f2, a, b, l, e);

    it = 1:length(a_list);  % δείκτης επαναλήψεων

    plot(it, a_list, '-o', 'DisplayName', sprintf('a_k, l=%.4f', l));
    plot(it, b_list, '--o', 'DisplayName', sprintf('b_k, l=%.4f', l));
end

xlabel('k');
ylabel('Τιμές a_k και b_k');
title('Εξέλιξη άκρων [a_k, b_k] για f_2(x)');
legend show;
hold off;

% Loop for each l for f_3
figure;
hold on; grid on;
for i = 1:length(l_values)
    l = l_values(i);

    [k, a_list, b_list, ~] = fibonacciMethod(f3, a, b, l, e);

    it = 1:length(a_list);  % δείκτης επαναλήψεων

    plot(it, a_list, '-o', 'DisplayName', sprintf('a_k, l=%.4f', l));
    plot(it, b_list, '--o', 'DisplayName', sprintf('b_k, l=%.4f', l));
end

xlabel('k');
ylabel('Τιμές a_k και b_k');
title('Εξέλιξη άκρων [a_k, b_k] για f_3(x)');
legend show;
hold off;
