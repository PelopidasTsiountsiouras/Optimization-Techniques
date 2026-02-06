# Tεχνικές Βελτιστοποίησης - Εργαστηριακές Ασκήσεις και Project

Αυτή η αναφορά περιλαμβάνει την περιγραφή και υλοποίηση των εργαστηριακών ασκήσεων που ανατέθηκαν στο πλαίσιο του μαθήματος **Τεχνικές Βελτιστοποίησης**. Κάθε άσκηση συνοδεύεται από μαθηματική ανάλυση των αλγορίθμων, υλοποίηση σε `MATLAB` και συγκριτική αξιολόγηση των αποτελεσμάτων προσομοίωσης.

- **Άσκηση 1:** Ελαχιστοποίηση κυρτής συνάρτησης μιας μεταβλητής με μεθόδους συρρίκνωσης διαστήματος (Διχότομος, Χρυσός Τομέας, Fibonacci).
- **Άσκηση 2:** Βελτιστοποίηση συναρτήσεων πολλών μεταβλητών χωρίς περιορισμούς με χρήση παραγώγων (Μέγιστη Κάθοδος, Newton, Levenberg-Marquardt).
- **Άσκηση 3:** Εφαρμογή της μεθόδου Μέγιστης Καθόδου με Προβολή σε προβλήματα με περιορισμούς.
- **Project:** Σχεδίαση και υλοποίηση Γενετικού Αλγορίθμου για την προσέγγιση άγνωστης συνάρτησης μέσω Γκαουσιανών συναρτήσεων.

Η αναφορά περιλαμβάνει διαγράμματα σύγκλισης, τροχιές αναζήτησης και πίνακες αποδοτικότητας που τεκμηριώνουν τη λειτουργία και την ταχύτητα σύγκλισης κάθε μεθόδου.

## Άσκηση 1: Ελαχιστοποίηση Κυρτής Συνάρτησης Μίας Μεταβλητής

Σε αυτήν την άσκηση υλοποιήθηκαν αλγόριθμοι για τον εντοπισμό του ελαχίστου $x^*$ μιας κυρτής συνάρτησης $f(x)$ σε ένα αρχικό διάστημα $[-1, 3]$. Στόχος ήταν η μείωση του εύρους αναζήτησης σε ένα τελικό διάστημα $[a_k, b_k]$ με προδιαγεγραμμένη ακρίβεια $l > 0$. 

### Υλοποίηση Αλγορίθμων

Οι μέθοδοι που εξετάστηκαν είναι:
- **Μέθοδος Διχοτόμου:** Υπολογισμός δύο σημείων $x_{1,k}, x_{2,k}$ σε απόσταση $\epsilon$ από το μέσο του διαστήματος.

```matlab
while (b_k - a_k) >= l

    x_1 = (a_k + b_k) / 2 - e;
    x_2 = (a_k + b_k) / 2 + e;

    f_1 = func(x_1);
    f_2 = func(x_2);
    f_evals = f_evals + 2;

    if f_1 < f_2
        % Interval shifts left
        b_k = x_2;
    else
        % Interval shifts right
        a_k = x_1;
    end

    a_list(end+1) = a_k;
    b_list(end+1) = b_k;
    k = k + 1;

end
```
- **Μέθοδος Χρυσού Τομέα:** Χρήση σταθεράς αναλογίας $\gamma = 0.618$ για τη συρρίκνωση του διαστήματος.
```matlab
while (b_k - a_k) >= l
    
    if f_1 > f_2 
        % Interval shifts right
        a_k = x_1;
        x_1 = x_2;
        x_2 = a_k + gamma * (b_k - a_k);
        f_1 = f_2;    %reuse
        f_2 = func(x_2);
        f_evals = f_evals + 1;
    else   
        % Interval shifts left
        b_k = x_2;
        x_2 = x_1;
        x_1 = a_k + (1 - gamma) * (b_k - a_k);
        f_2 = f_1;   %reuse
        f_1 = func(x_1);
        f_evals = f_evals + 1;
    end

    k = k + 1;
    a_list(end+1) = a_k;
    b_list(end+1) = b_k;

end
```
- **Μέθοδος Fibonacci:** Βέλτιστη τοποθέτηση σημείων βάσει της ακολουθίας Fibonacci για ελαχιστοποίηση των υπολογισμών.
```matlab
    while true
        
        if f_1 > f_2
            % Interval shifts right
            a_k = x_1;

            x_1 = x_2;
            f_1 = f_2;   % reuse

            x_2 = a_k + (fibonacci(N - k - 1) / fibonacci(N - k)) * (b_k - a_k);

            if k ~= N - 2
                f_2 = func(x_2);
                f_evals = f_evals + 1;
            end

        else
            % Interval shifts left
            b_k = x_2;

            x_2 = x_1;
            f_2 = f_1;   % reuse

            x_1 = a_k + (fibonacci(N - k - 2) / fibonacci(N - k)) * (b_k - a_k);

            if k ~= N - 2
                f_1 = func(x_1);
                f_evals = f_evals + 1;
            end
        end

        % Termination condition (step N - 2)
        if k == N - 2
            x_2 = x_1 + e;
            f_2 = func(x_2);
            f_evals = f_evals + 1;

            if f_1 > f_2
                a_k = x_1;
            else
                b_k = x_2;
            end

            a_list(end+1) = a_k;
            b_list(end+1) = b_k;
            return;
        end

        a_list(end+1) = a_k;
        b_list(end+1) = b_k;

        k = k + 1;

    end
```
- **Διχότομος με Παραγώγους:** Χρήση του προσήμου της πρώτης παραγώγου για τον προσδιορισμό της κατεύθυνσης του ελαχίστου.
```matlab
while true

        % Calculation of the midpoint
        x_k = (a_k + b_k) / 2;

        diff_f_xk = subs(diff_func, x, x_k);
        df_evals = df_evals + 1;

        % Derivative check
        if abs(diff_f_xk) < 1e-12   % float numbers are never exact and numerical derivatives give small residual error
            % Minimum found exactly
            a_k = x_k;
            b_k = x_k;
            a_list(end+1) = a_k;
            b_list(end+1) = b_k;
            return;
        elseif diff_f_xk > 0
            a_k = a_k;
            b_k = x_k;
        else
            a_k = x_k;
            b_k = b_k;
        end

        % Save interval
        a_list(end+1) = a_k;
        b_list(end+1) = b_k;

        % Check if k = n
        if k == n
            return;
        end

        k = k + 1;
    end
```

### Συγκριτικά Αποτελέσματα

Από τις προσομοιώσεις για διαφορετικές τιμές των $l$ και $\epsilon$, προέκυψαν τα εξής συμπεράσματα:
- Η Μέθοδος Fibonacci υπερτερεί ελαφρώς του Χρυσού Τομέα σε αριθμό αξιολογήσεων της $f$.
- Η Διχότομος με Παραγώγους είναι η ταχύτερη όλων, καθώς απαιτεί τον ελάχιστο αριθμό επαναλήψεων για την ίδια ακρίβεια $l$.
- Ο αριθμός των απαιτούμενων υπολογισμών αυξάνεται λογαριθμικά καθώς η ακρίβεια $l$ μικραίνει.

## Άσκηση 2: Βελτιστοποίηση Συναρτήσεων Πολλών Μεταβλητών Χωρίς Περιορισμούς

Αντικείμενο της άσκησης ήταν η ελαχιστοποίηση της συνάρτησης $f(x,y) = x^3 e^{-(x^2+y^4)}$. Υλοποιήθηκαν και συγκρίθηκαν τρεις βασικοί αλγόριθμοι καθόδου, με διαφορετικούς μηχανισμούς επιλογής βήματος $\gamma_k$ (Σταθερό, Exact Line Search, Armijo).

### Υλοποίηση Αλγορίθμων

- **Μέθοδος Μέγιστης Καθόδου (Steepest Descent):** Η κατεύθυνση αναζήτησης είναι η αρνητική κλίση της συνάρτησης.

```matlab
while norm(gk) > e && iterations < maxIter
        d_k = -gk;

        gamma = calculateGamma(f, x_k, y_k, d_k, gamma_calculator);

        x_k = x_k + gamma * d_k(1);
        y_k = y_k + gamma * d_k(2);

        f_values(end+1) = f(x_k, y_k);

        gk = gradient_f(f, x_k, y_k);

        trajectory(end+1,:) = [x_k, y_k];

        iterations = iterations + 1;
    end
```

- **Μέθοδος Newton:** Χρησιμοποιεί τον αντίστροφο πίνακα Hessian για να πετύχει τετραγωνική σύγκλιση.

```matlab
while norm(gk) > e && iterations < maxIter

        H = hessian_f(f, x_k, y_k);

        % direction d_k = -H^{-1} gk  (σωστά μέσω backslash)
        d_k = - H \ gk;

        % βήμα γ
        gamma = calculateGamma(f, x_k, y_k, d_k, gamma_calculator);

        % ενημέρωση
        x_k = x_k + gamma * d_k(1);
        y_k = y_k + gamma * d_k(2);

        % αποθήκευση
        f_values(end+1) = f(x_k, y_k);

        % νέο gradient
        gk = gradient_f(f, x_k, y_k);

        trajectory(end+1,:) = [x_k, y_k];

        iterations = iterations + 1;
    end
```

- **Μέθοδος Levenberg-Marquardt:**Εισάγει έναν όρο απόσβεσης $\mu_k$ στον Hessian για να εξασφαλίσει ότι ο πίνακας παραμένει θετικά ορισμένος, συνδυάζοντας τη σταθερότητα της Steepest Descent με την ταχύτητα της Newton.

```matlab
while norm(gk) > e && iterations < maxIter

        H = hessian_f(f, x_k, y_k);

        % Βρες μ ώστε H + μI να είναι θετικά ορισμένος
        mu = 1;
        A = H + mu*eye(2);
        eigA = eig(A);
        safety = 0;
        while ~all(eigA > 0) && safety < 50
            mu = mu + 1;
            A = H + mu*eye(2);
            eigA = eig(A);
            safety = safety + 1;
        end

        % d_k = -(H+μI)^{-1} gk
        d_k = - A \ gk;

        % γ από τους κανόνες
        gamma = calculateGamma(f, x_k, y_k, d_k, gamma_calculator);

        % ενημέρωση
        x_k = x_k + gamma * d_k(1);
        y_k = y_k + gamma * d_k(2);

        % αποθήκευση f
        f_values(end+1) = f(x_k, y_k);

        % νέο gradient
        gk = gradient_f(f, x_k, y_k);

        trajectory(end+1,:) = [x_k, y_k];

        iterations = iterations + 1;
    end
```

### Συγκριτικά Αποτελέσματα

Από τη μελέτη των αποτελεσμάτων προέκυψαν τα εξής:

- **Steepest Descent:** Παρουσιάζει αργή σύγκλιση με χαρακτηριστική πορεία "ζιγκ-ζαγκ", ειδικά σε περιοχές με μεγάλη κυρτότητα.
- **Newton:** Πολύ ταχύτερη σύγκλιση, αλλά ευαίσθητη στο αρχικό σημείο εκκίνησης (κίνδυνος παγίδευσης σε σαγματικά σημεία).
- **Levenberg-Marquardt:** Η πιο αξιόπιστη μέθοδος, καθώς ο όρος $\mu_k$ επιτρέπει στον αλγόριθμο να προσαρμόζεται στη γεωμετρία της συνάρτησης.

## Άσκηση 3: Μέγιστη Κάθοδος με Προβολή σε Προβλήματα με Περιορισμούς

Αντικείμενο της άσκησης ήταν η ελαχιστοποίηση της συνάρτησης $f(x_1, x_2) = \frac{1}{3}x_1^2 + 3x_2^2$ υπό τους περιορισμούς:

$-10 \le x_1 \le 5$ και $-8 \le x_2 \le 12$.

Η μέθοδος αυτή αποτελεί επέκταση της Μέγιστης Καθόδου, όπου μετά από κάθε βήμα το σημείο «προβάλλεται» πίσω στα όρια του εφικτού συνόλου αν έχει εξέλθει από αυτά.

### Υλοποίηση Αλγορίθμου

Η διαδικασία περιλαμβάνει τον υπολογισμό του προσωρινού σημείου $y_k$ και την εφαρμογή του τελεστή προβολής $P[\cdot]$ πάνω στους περιορισμούς:

```matlab
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
```

### Παρατηρήσεις και Συμπεράσματα

- **Σύγκλιση:** Η μέθοδος οδηγεί στο ελάχιστο εντός του εφικτού συνόλου, ακόμα και αν το ολικό ελάχιστο της συνάρτησης χωρίς περιορισμούς βρίσκεται εκτός αυτού.
- **Επίδραση Παραμέτρων:** Η επιλογή των παραμέτρων $s_k$ και $\gamma_k$ είναι κρίσιμη για τη σταθερότητα της σύγκλισης. Για μεγάλες τιμές του $\gamma_k$, παρατηρήθηκαν ταλαντώσεις γύρω από τα όρια των περιορισμών.
- **Σύγκριση:** Σε σχέση με την απλή Μέγιστη Κάθοδο, η προβολή εξασφαλίζει ότι η λύση παραμένει φυσικά αποδεκτή βάσει των προδιαγραφών του προβλήματος.

## Project: Γενετικοί Αλγόριθμοι

Στο πλαίσιο του Project, σχεδιάστηκε και υλοποιήθηκε ένας Γενετικός Αλγόριθμος (GA) σε MATLAB (χωρίς τη χρήση της έτοιμης συνάρτησης ga()), με σκοπό την εύρεση μιας αναλυτικής έκφρασης για την προσέγγιση της άγνωστης συνάρτησης:$f(u_1, u_2) = \sin(u_1 + u_2) \sin(u_2^2)$

Η προσέγγιση έγινε μέσω γραμμικού συνδυασμού έως και 15 Γκαουσιανών συναρτήσεων της μορφής:$G(u_1, u_2) = e^{- \left( \frac{(u_1-c_1)^2}{2\sigma_1^2} + \frac{(u_2-c_2)^2}{2\sigma_2^2} \right)}$

### Δομή Γενετικού Αλγορίθμου

Ο αλγόριθμος βασίζεται στις αρχές της εξέλιξης των ειδών και περιλαμβάνει τα εξής στάδια:
- **Κωδικοποίηση:** Κάθε άτομο (χρωμόσωμα) αναπαριστά τις παραμέτρους $c$ (κέντρα) και $\sigma$ (εύρη) των Γκαουσιανών.
```matlab
for i=0 : gauss_number-1 
        weights = chromosome(i*5+1); 
        u1_centers = chromosome(i*5+2); 
        u2_centers = chromosome(i*5+3); 
        u1_spreads = chromosome(i*5+4); 
        u2_spreads = chromosome(i*5+5);
    
        gaussian = exp(-(((input_data(1)-u1_centers)^2/(2*u1_spreads^2))+((input_data(2)-u2_centers)^2/(2*u2_spreads^2))));
        
        result = result + weights*gaussian; 
    end 
```
- **Συνάρτηση Καταλληλότητας (Fitness Function):** Ως κριτήριο χρησιμοποιήθηκε το Μέσο Τετραγωνικό Σφάλμα (MSE) μεταξύ των πραγματικών τιμών και των τιμών που παρήγαγε το μοντέλο.
- **Επιλογή (Selection):** Χρήση της μεθόδου Tournament Selection για την επιλογή των γονέων.
```matlab
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
```
- **Διασταύρωση & Μετάλλαξη:** Εφαρμογή τελεστών για τη δημιουργία νέων απογόνων και τη διατήρηση της γενετικής ποικιλομορφίας.
```matlab
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
```
```matlab
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
```

### Αποτελέσματα

- **Validation:** Η ποιότητα της αναλυτικής έκφρασης αξιολογήθηκε σε ξεχωριστό Validation Set, εξασφαλίζοντας ότι το μοντέλο δεν έκανε overfitting.
- **Ακρίβεια:** Ο αλγόριθμος πέτυχε ικανοποιητική προσέγγιση της επιφάνειας της $f$, αναδεικνύοντας τη δύναμη των εξελικτικών αλγορίθμων σε προβλήματα βελτιστοποίησης όπου η αναλυτική μορφή είναι άγνωστη.

