clc;
clear all;
% T = transient_FDM(U0, W, L, dx, dy, F, total_time, dt, T0, T_left, T_right) 
% Q2 plot temperature change over time

W = 6;  % Width of domain (in m), AB=CD=6m
L = 4;  % Height of domain (in m),BC=AD=4m

%% Q2_1: ∆x=∆y=0.1, F=0.25, total time=100s, ∆t=1, sst=101
Q2_t1_F025 = transient_FTCS('U0', 6, 4, 0.1, 0.1, 0.25, 100, 1,101, 100, 100, 100);
% W=6, L=4, ∆x=∆y=0.1, F=0.25, total time=100s, ∆t=1, T0=100C, T_left=T_right=100C, 

% Initialize
dx=0.1;  % delta x, Length of element in X direction (in m)
dy=0.1;  % delta y, Length of element in Y direction (in m), dx=dy
sst=101; %sst=number of temporal steps, sst=(total_time+1)/dt;
x=0:dx:W;
y=0:dy:L;

% Plot transient heat conduction results at t=1s and t=100s in 3D figure
for step = 1:49:sst-1
    % obtain current time T
    current_T_1 = Q2_t1_F025(:, :, step);
    x=0:dx:W;
    y=0:dy:L;
    % Plot 3-dimensition figure, temperate T at z-direction, T over time
    figure(step);
    surf(x, y, current_T_1', 'EdgeColor', 'none');
    colorbar;
    xlabel('X');
    ylabel('Y');
    zlabel('Temperature');
    title(['Temperature distribution in transient heat condition - time steps:' num2str(step)]);
    
   % Highlight central hole
   hold on;
   xh = [2, 2, 4, 4];
   yh = [1, 3, 3, 1];
   zh = [50, 50, 50, 50];
   patch(xh, yh, zh, 'b', 'EdgeColor', 'r', 'FaceAlpha', 1);
   hold off;

   pause(0.1);
end


% Plot stable results at t=100s in 2D figure to compared with Q1
T_final_1 = squeeze(Q2_t1_F025(:, :, sst-1));
figure(2);
colormap(jet);
contourf(x,y,T_final_1');
colorbar;
title('Temperature in Q2 at t=100s (sst=101) ');
xlabel('X');
ylabel('Y');
hold on;
% Highlight the central hole
rectangle('Position', [2, 1, 2, 2], 'EdgeColor', 'r', 'LineWidth', 2); 
hold off;

% Temperature at point a(1,2)
T_point_1 = squeeze(Q2_t1_F025(1/dx+1,2/dy+1, :)); 
time_steps = 1:sst;
% Plot Temperature distribution at point a
figure(3);
plot(time_steps, T_point_1, 'b-', 'LineWidth', 2);
xlabel('Time step');
ylabel('Temperature');
title('Temperature distribution at point a(1,2) over time');
grid on;


%% Q2_2: ∆x=∆y=0.1, F=0.1, total time=100s, ∆t=0.1, sst=1010
Q2_t01_F01 = transient_FTCS('U0', 6, 4, 0.1, 0.1, 0.1, 100, 0.1, 1010, 100, 100, 100);
% W=6, L=4, ∆x=∆y=0.1, F=0.25, total time=100s, ∆t=1, T0=100C, T_left=T_right=100C, 

% Initialize
dx=0.1;  % delta x, Length of element in X direction (in m)
dy=0.1;  % delta y, Length of element in Y direction (in m), dx=dy
sst_2=1010; %sst=number of temporal steps, sst=(total_time+1)/dt;
x=0:dx:W;
y=0:dy:L;

% Plot transient heat conduction results at t=1s and t=100s in 3D figure
for step = 1:500:sst_2-1
    % obtain current time T
    current_T_2 = Q2_t01_F01(:, :, step);
    x=0:dx:W;
    y=0:dy:L;
    % Plot 3-dimensition figure, temperate T at z-direction, T over time
    figure(step);
    surf(x, y, current_T_2', 'EdgeColor', 'none');
    colorbar;
    xlabel('X');
    ylabel('Y');
    zlabel('Temperature');
    title(['Temperature distribution in transient heat condition - time steps:' num2str(step)]);
    
   % Highlight central hole
   hold on;
   xh = [2, 2, 4, 4];
   yh = [1, 3, 3, 1];
   zh = [50, 50, 50, 50];
   patch(xh, yh, zh, 'b', 'EdgeColor', 'r', 'FaceAlpha', 1);
   hold off;

   pause(0.1);
end


% Plot stable results at t=100s with more time steps in 2D figure to compared with Q1
T_final_2 = squeeze(Q2_t01_F01(:, :, sst_2-1));
figure(4);
colormap(jet);
contourf(x,y,T_final_2');
colorbar;
title('Temperature in Q2 at t=100s (sst=1010)');
xlabel('X');
ylabel('Y');
hold on;
% Highlight the central hole
rectangle('Position', [2, 1, 2, 2], 'EdgeColor', 'r', 'LineWidth', 2); 
hold off;

% Temperature at point a(1,2)
T_point_2 = squeeze(Q2_t01_F01(1/dx+1,2/dy+1, :)); 
time_steps_2 = 1:sst_2;
% Plot Temperature distribution at point a
figure(5);
plot(time_steps_2, T_point_2, 'b-', 'LineWidth', 2);
xlabel('Time step');
ylabel('Temperature');
title('Temperature distribution at point a(1,2) over time');
grid on;

