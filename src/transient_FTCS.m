function T = transient_FTCS(U0, W, L, dx, dy, F, total_time, dt, sst, T0, T_left, T_right) 
% Central Difference Method for 2D heat diffusion equation Ut=c^2Uxx 
% U0 = initial condition U(x,0)entered as a string 
% W = Width of domain (in m), AB=CD=6m
% L = Height of domain (in m),BC=AD=4m, W & L = Geometric Parameters for Domain
% dx=delta x, Length of element in X direction (in m)
% dy=delta y, Length of element in Y direction (in m), dx=dy=1m in Q1
% F=c*dt/dx^2/p/C, as the coefficient in transient heat conduction equation, stable when F ≤ 0.25.
% total_time
% sst=number of temporal steps, sst= (total_time+1) / dt;
% IC and BCs-Initialization is as follows
% T0 = total time 
% T_left = Left side boundary condition = T(1,:)
% T_right = Right side boundary condition = T(ssx,:)=T_right; 


ssx=W/dx+1;  % Number of spatial steps in X direction
ssy=L/dy+1;  % Number of spatial steps in Y direction

% Create a 2m*2m central opening hole, (2 <= X <= 4) && (1 <= Y <= 3)
hole_x_left = 2/dx+1;      % top column for T_hole
hole_x_right = 4/dx+1;     % bottom column for T_hole
hole_y_bottom = 1/dy+1;    % left row for T_hole;
hole_y_top  = 3/dy+1;      % right row for T_hole;

% Mesh
x = linspace(0, dx, ssx);
y = linspace(0, dy, ssy);
[X, Y] = meshgrid(x, y);

% Initialize temparature field
% T(x_index, y_index, t_index) implies temperate change respect to x, y, time
T=T0*ones(ssx,ssy,sst); % initial temperature in whole plate is 100C
T(1,:,:)=T_left;      % Left side
T(ssx,:,:)=T_right;   % Right side


%% convergence check
maxI = 100; % Max iteration
tolerance = 1e-5;      % tolerance 

for t = 2:sst-1
    for iteration = 1:maxI   % check at every time step
       T_new = T;
        for i = 2:ssx-1      % The left and right sides need not compute, T(1,:) = T(ssx,:) = 100
           for j = 1:ssy     % For top and bottom sides, dT/dy=0
             if (i >= hole_x_left && i <= hole_x_right) && ( j >= hole_y_bottom && j <= hole_y_top) 
               T_new(i,j,t) = feval(U0, t);  % Inside hole T=U0(t)
             elseif j == ssy              % Top side
               T_new(i,j,t) = T(i,j-1,t);
             elseif j == 1                % Bottom side
               T_new(i,j,t) = T(i,j+1,t);
             else                         % Interior nodes-Final form of the transient heat conduction equation
               T_new(i,j,t+1) = (1-4*F)*T(i,j,t) + F*(T(i+1,j,t) + T(i-1,j,t) + T(i,j+1,t) + T(i,j-1,t)) ; 
              end
           end
       end

    % Compute convergence
    max_T_change = max(max(abs(T_new - T)));
    % Store new temperate field
    T= T_new;   

    % Check convergence
        if max_T_change < tolerance
        fprintf('Convergence reached, number of iterations: %d\n', iteration);
           break;
        end
    end
end


% plot in m

end
