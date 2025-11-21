clear all;
clc;

% Parámetros del sistema
a = 0.7; % Ajusta dentro del rango 1 - 2b/3 < a < 1
b = 0.8; % Ajusta dentro del rango 0 < b < 1
c = 1.0; % Ajusta según la restricción b < c^2
z = 0;   % Suponemos que z = 0 en este caso

% Definir las nullclinas corregidas:
X_nullcline = @(X) -X + (X.^3) / 3 - z;  % Nullclina de X'
y_nullcline = @(X) (-X + a) / b;          % Nullclina de y'

% Rango de X para graficar
X_range = linspace(-2, 2, 100);

% Graficar las nullclinas
figure;
hold on;
plot(X_range, X_nullcline(X_range), 'r', 'LineWidth', 2); % Nullclina de X'
plot(X_range, y_nullcline(X_range), 'b', 'LineWidth', 2); % Nullclina de y'

% Usar fzero para encontrar el punto de equilibrio
% Definir la función para encontrar el valor de X donde las nullclinas se cruzan
equilibrium_func = @(X) X_nullcline(X) - y_nullcline(X); % Ecuación para el equilibrio
X_eq = fzero(equilibrium_func, 0);  % Usar fzero para encontrar el punto de equilibrio

% Encontrar el valor de y en el punto de equilibrio
y_eq = y_nullcline(X_eq);

% Mostrar el punto de equilibrio
disp('Punto de equilibrio: ');
disp(['X = ', num2str(X_eq), ', y = ', num2str(y_eq)]);

% Graficar el punto de equilibrio
plot(X_eq, y_eq, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k'); % Punto de equilibrio

% Etiquetas y leyenda
xlabel('X');
ylabel('y');
title('Intersección de las curvas X''=0 e y''=0');
legend('X'' = 0 (nullclina)', 'y'' = 0 (nullclina)', 'Punto de equilibrio', 'Location', 'Best');
grid on;
hold off;
