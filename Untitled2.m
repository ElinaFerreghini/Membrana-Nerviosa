% Parametros de prueba
clear all;
clc;

% Valores de b y c
b_values = [0.3, 0.5, 0.8]; % Valores de b dentro del rango permitido
c_values = [1.0, 2.0, 3.0]; % Valores de c (positivo)

for j = 1:length(b_values)
    for k = 1:length(c_values)
        b = b_values(j);
        c = c_values(k);
        z = 0; % Manteniendo z en 0
        
        % Definir el rango de valores permitidos para a (estrictamente dentro)
        a_min = 1 - (2*b)/3;
        a_max = 1;
        
        % Generar valores de a dentro del rango sin incluir los extremos
        a_values = a_min + (a_max - a_min) * [0.25, 0.5, 0.75];  % Valores internos
        
        for i = 1:length(a_values)
            a = a_values(i);

            % Definir las nullclinas
            X_nullcline = @(X) -X + (X.^3) / 3 - z;  
            y_nullcline = @(X) (-X + a) / b;

            % Usar fzero para encontrar el punto de equilibrio
            initial_guess = 1.2;  % Aproximarse al valor esperado
            equilibrium_func = @(X) X_nullcline(X) - y_nullcline(X);
            X_eq = fzero(equilibrium_func, initial_guess);  
            y_eq = y_nullcline(X_eq);

            % Mostrar el resultado
            disp(['a = ', num2str(a), ', b = ', num2str(b), ', c = ', num2str(c)]);
            disp(['Punto de equilibrio: X = ', num2str(X_eq), ', y = ', num2str(y_eq)]);
        end
    end
end

