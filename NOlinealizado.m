clear; clc; close all;

% Definición de parámetros
global c a b z
c = 1;   % Puedes cambiar el valor de c si es necesario
a = 0.7; % Asegúrate que 1 - 2b/3 < a < 1
b = 0.8; % 0 < b < 1
z = 0;   % Manteniendo z en 0 VER QUE PASA SI Z ES UN DELTA DE DIRAC!

% Definir el tiempo de simulación
tspan = [0, 20];

% Valores iniciales
initial_conditions = [0, -0.8; 0, -0.6; 0, -0.4; 0, 0; 1, 0; 1, -0.8; 1, -0.6; 1, -0.4; 1.2, -0.6; 2, -0.6; 2, 0; 2, 1]; % Diferentes condiciones iniciales

% Preparar la figura para el diagrama de fase
figure;
hold on;

% Simulación para diferentes condiciones iniciales
for i = 1:size(initial_conditions, 1)
    % Condiciones iniciales
    X0 = initial_conditions(i, 1);
    y0 = initial_conditions(i, 2);
    inicial = [X0; y0]; % Solo las variables X e y

    % Resolver el sistema de ecuaciones
    [t, u] = ode45(@mifuncion, tspan, inicial);
    
    % Graficar la trayectoria en el plano de fase
    plot(u(:, 1), u(:, 2), 'DisplayName', ['Trayectoria inicial: (', num2str(X0), ', ', num2str(y0), ')']);
end

% Configuración de la gráfica
xlabel('X');
ylabel('y');
title('Plano de fase (X, y)');
legend show;
grid on;
hold off;

% Preparar otra figura para las soluciones temporales
figure;
hold on;

% Graficar las soluciones temporales (X(t) y y(t)) para cada condición inicial
for i = 1:size(initial_conditions, 1)
    % Condiciones iniciales
    X0 = initial_conditions(i, 1);
    y0 = initial_conditions(i, 2);
    inicial = [X0; y0]; % Solo las variables X e y

    % Resolver el sistema de ecuaciones
    [t, u] = ode45(@mifuncion, tspan, inicial);
    
    % Graficar X(t)
    subplot(2, 1, 1); % Dos gráficos en una misma figura (uno para X y otro para y)
    plot(t, u(:, 1), 'DisplayName', ['X(t) inicial: (', num2str(X0), ', ', num2str(y0), ')']);
    hold on;
    
    % Graficar y(t)
    subplot(2, 1, 2);
    plot(t, u(:, 2), 'DisplayName', ['y(t) inicial: (', num2str(X0), ', ', num2str(y0), ')']);
    hold on;
end

% Configuración de la gráfica para X(t)
subplot(2, 1, 1);
xlabel('Tiempo');
ylabel('X(t)');
title('Solución temporal X(t)');
legend show;
grid on;

% Configuración de la gráfica para y(t)
subplot(2, 1, 2);
xlabel('Tiempo');
ylabel('y(t)');
title('Solución temporal y(t)');
legend show;
grid on;

hold off;

% Función que define las ecuaciones del sistema
function dv = mifuncion(t, v)
    global c a b z
    X = v(1); 
    y = v(2); 
    dv = zeros(2, 1);
    dv(1) = c * (y + X - (X^3) / 3 + z); % Ecuación (1)
    dv(2) = -(X - a + b * y) / c;        % Ecuación (2)
end
