clc;
clear all;
% function T = stable_CDM(U0, W, L, dx, dy, T0, T_left, T_right,t_sta, maxI) 
% Plot teperate at a at a stable state in Q1 

W = 6;  % Width of domain (in m), AB=CD=6m
L = 4;  % Height of domain (in m),BC=AD=4m
dx_1=0.1;  % delta x, Length of element in X direction (in m)
dy_1=0.1;  % delta y, Length of element in Y direction (in m), dx=dy

%% W=6, L=4, ∆x=0.1, ∆y=0.1, T0=100C, T_left=T_right=100C, t_sta=100s,
% max iteration=2000
Q1_T_dx01 = stable_CDM('U0', 6, 4, 0.1, 0.1, 100, 100, 100, 100, 2000);

% Plotting the results
x1=0:dx_1:W;
y1=0:dy_1:L;
figure(1)
colormap(jet);
contourf(x1,y1,Q1_T_dx01');
colorbar;
title('Temperature distribution with a plate');
xlabel('X');
ylabel('Y');

% Highlight central hole
hold on;
rectangle('Position', [2, 1, 2, 2], 'EdgeColor', 'r', 'LineWidth', 2);  % rectangle[x_min, y_min, x_max - x_min, y_max - y_min]
hold off;

% Determine the temperature at point a(1,2) at steady state
T_point_a1 = Q1_T_dx01(1/dx_1+1,2/dy_1+1);

% Temperature at point a(1,2)
fprintf('Temperature at point a(1,2) at steady state: %.2f ℃\n', T_point_a1);


%% W=6, L=4, ∆x=0.5, ∆y=0.5, T0=100C, T_left=T_right=100C, t_sta=100s,
% max iteration=1000
Q1_T_dx05 = stable_CDM('U0', 6, 4, 0.5, 0.5, 100, 100, 100, 100, 1000);
dx_2=0.5;  % delta x, Length of element in X direction (in m)
dy_2=0.5;  % delta y, Length of element in Y direction (in m), dx=dy

% Plotting the results
x2=0:dx_2:W;
y2=0:dy_2:L;
figure(2)
colormap(jet);
contourf(x2,y2,Q1_T_dx05');
colorbar;
title('Temperature distribution with a plate');
xlabel('X');
ylabel('Y');

% Highlight central hole
hold on;
rectangle('Position', [2, 1, 2, 2], 'EdgeColor', 'r', 'LineWidth', 2);  % rectangle[x_min, y_min, x_max - x_min, y_max - y_min]
hold off;

% Determine the temperature at point a(1,2) at steady state
T_point_a2 = Q1_T_dx05(1/dx_2+1,2/dy_2+1);

% Temperature at point a(1,2)
fprintf('Temperature at point a(1,2) at steady state: %.2f ℃\n', T_point_a2);


%% W=6, L=4, ∆x=1, ∆y=1, T0=100C, T_left=T_right=100C, t_sta=100s, 
% max iteration=100

Q1_T_dx1 = stable_CDM('U0', 6, 4, 1, 1, 100, 100, 100, 100, 100);
dx_3=1;  % delta x, Length of element in X direction (in m)
dy_3=1;  % delta y, Length of element in Y direction (in m), dx=dy

% Plotting the results
x3=0:dx_3:W;
y3=0:dy_3:L;
figure(3)
colormap(jet);
contourf(x3,y3,Q1_T_dx1');
colorbar;
title('Temperature distribution with a plate');
xlabel('X');
ylabel('Y');

% Highlight central hole
hold on;
rectangle('Position', [2, 1, 2, 2], 'EdgeColor', 'r', 'LineWidth', 2);  % rectangle[x_min, y_min, x_max - x_min, y_max - y_min]
hold off;

% Determine the temperature at point a(1,2) at steady state
T_point_a3 = Q1_T_dx1(1/dx_3+1,2/dy_3+1);

% Temperature at point a(1,2)
fprintf('Temperature at point a(1,2) at steady state: %.2f ℃\n', T_point_a3);
