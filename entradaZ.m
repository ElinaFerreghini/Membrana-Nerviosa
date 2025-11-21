clear; clc; close all;

% Parámetros
c = 1; % Valor de c
b = 0.8; % Valor de b
a = 0.7; % Valor de a
X_eq = 1.2; % Punto de equilibrio
y_eq = -0.625; % Punto de equilibrio para y

global A B C D; % Declarar matrices como globales

% Matriz Jacobiana (linealización alrededor del punto de equilibrio)
A = [c * (1 - X_eq^2), c; 
     -1/c, -b/c];

% Matriz B (entrada afecta a la ecuación de dX/dt)
B = [1; 0]; % z afecta a dX/dt

% Matriz C (salida es X)
C = [1, 0]; 

% Matriz D (sin relación directa entre entrada y salida)
D = 0;

% Tiempo de simulación
tspan = [0, 20];

% Crear sistema en espacio de estados
sys = ss(A, B, C, D);

% Calcular la función de transferencia del sistema
G = tf(sys);

% Mostrar la función de transferencia
disp('Función de transferencia:');
[num, den] = tfdata(G, 'v'); % Extraer numerador y denominador
fprintf('Numerador: %s\n', mat2str(num)); % Mostrar numerador
fprintf('Denominador: %s\n', mat2str(den)); % Mostrar denominador

% Graficar la respuesta al impulso
figure;
impulse(sys);
title('Respuesta al impulso del sistema linealizado con entrada z');

% Graficar la respuesta al escalón
figure;
step(sys);
title('Respuesta al escalón del sistema linealizado con entrada z');
