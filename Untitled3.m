clear all;
clc;

% Parámetros del sistema
a = 0.7;  % Valor de a
b = 0.8;  % Valor de b (es necesario definir este valor)
c = 1;    % Valor de c

% Punto de equilibrio
X_eq = 1.1994; 
y_eq = -0.62426; 

% Matriz Jacobiana
J = [3 * (1 - X_eq^2), 3;
     -1/3, -b/3];

% Calcular los eigenvalores
eigenvalues = eig(J);

% Mostrar resultados
disp('Matriz Jacobiana:');
disp(J);
disp('Eigenvalores:');
disp(eigenvalues);