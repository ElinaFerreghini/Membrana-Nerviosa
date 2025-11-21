clear; clc; close all;

% Parámetros
c = 1; % Valor de c
b = 0.8; % Valor de b
a = 0.7; % Valor de a
X_eq = 1.2; % Punto de equilibrio
y_eq = -0.625; % Punto de equilibrio para y

global A; % Declarar A como global

% Calcular la matriz Jacobiana
A = [c * (1 - X_eq^2), c; 
     -1/c, -b/c];

% Calcular autovalores y autovectores
[eigenvectors, eigenvalues] = eig(A);

% Mostrar autovalores y autovectores
disp('Autovalores:');
disp(diag(eigenvalues)); % Mostrar solo los autovalores
disp('Autovectores:');
disp(eigenvectors); % Mostrar autovectores

% Tiempo de simulación
tspan = [0, 20];

% Condiciones iniciales para el sistema linealizado
initial_conditions_linear = [0, -0.8;0, -0.6;0, -0.4;0,0; 1, 0;1, -0.8;1, -0.6;
    1,-0.4; 1.2, -0.6; 2, -0.6; 2, 0; 2, 1];  % Diferentes condiciones iniciales para el sistema linealizado

% Gráfica del plano de fase
figure;
hold on;


for i = 1:size(initial_conditions_linear, 1)
    % Condiciones iniciales
    X0 = initial_conditions_linear(i, 1);
    y0 = initial_conditions_linear(i, 2);
    inicial = [X0; y0]; % Solo las variables X e y

    % Resolver el sistema de ecuaciones linealizadas
    [t, u] = ode45(@mifuncion_lineal, tspan, inicial);
    
    % Graficar la trayectoria en el plano de fase
    plot(u(:, 1), u(:, 2), 'DisplayName', ['Trayectoria inicial: (', num2str(X0), ', ', num2str(y0), ')']);
end

% Configuración de la gráfica
xlabel('X');
ylabel('y');
title('Plano de fase (X, y) - Sistema Linealizado');
legend show;
grid on;
hold off;

% Definición de la función del sistema linealizado
function dv = mifuncion_lineal(t, v)
    global A; % Usar la matriz Jacobiana global
    dv = A * (v - [1.2; -0.625]); % Linealizar alrededor del punto de equilibrio
end

