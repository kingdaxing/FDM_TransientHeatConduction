function T = stable_CDM(U0, W, L, dx, dy, T0, T_left, T_right, t_sta, maxI) 
% Central Difference Method for 2D heat diffusion equation Ut=c^2Uxx 
% U0 = initial condition U(x,0)entered as a string 
% W = Width of domain (in m), AB=CD=6m
% L = Height of domain (in m),BC=AD=4m, W & L = Geometric Parameters for Domain
% dx=delta x, Length of element in X direction (in m)
% dy=delta y, Length of element in Y direction (in m), dx=dy=1m in Q1
% IC and BCs-Initialization is as follows
% T0 = total time 
% T_left = Left side boundary condition = T(1,:)
% T_right = Right side boundary condition = T(ssx,:)=T_right; 
% t_sta = assumption time at a stable state condition
% maxI = max iteration in convergence check

% spatial steps 
ssx=W/dx+1;  % Number of spatial steps in X direction
ssy=L/dy+1;  % Number of spatial steps in Y direction

% Mesh
x = linspace(0, dx, ssx);
y = linspace(0, dy, ssy);
[X, Y] = meshgrid(x, y);

% Create a 2m*2m central opening hole, (2 <= X <= 4) && (1 <= Y <= 3)
hole_x_left = 2/dx+1;      % top column for T_hole
hole_x_right = 4/dx+1;     % bottom column for T_hole
hole_y_bottom = 1/dy+1;    % left row for T_hole;
hole_y_top  = 3/dy+1;      % right row for T_hole;


% Initialize temparature field
% A stable state, T conditions along EFGH reach 50C as the cooling element U0(100)
T=T0*ones(ssx,ssy); % Assume initial temperature in stable condition (in C)
T(1,:)=T_left;      % Left side
T(ssx,:)=T_right;   % Right side

% Assume stable temperature along EFGH, as t->100s, T(50+50e^-0.2t)=50.
T_hole_stable = feval(U0, t_sta) ; 
T(hole_x_left:hole_x_right,hole_y_bottom:hole_y_top)=T_hole_stable;

% convergence check
% maxI = Max iteration
tolerance = 1e-4;      % tolerance 

for iteration = 1:maxI  % maxI = Max iteration
    T_new = T;
    for i = 2:ssx-1        % The left and right sides need not compute, T(1,:) = T(ssx,:) = 100
        for j = 1:ssy      % For top and bottom sides, dT/dy=0
            if j == ssy                 % Top side
               T_new(i, j) = T(i, j-1);
            elseif j==1                 % Bottom side
               T_new(i, j) = T(i, j+1); 
            elseif (i >= hole_x_left && i <= hole_x_right) && ( j >= hole_y_bottom && j <= hole_y_top) 
               T_new(i, j) = T_hole_stable;  % Inside hole, T remains 50C
            else                             % Interior nodes, CDM as dT/dt=0
               T_new(i, j) = (T(i+1, j) + T(i-1, j) + T(i, j+1) + T(i, j-1)) / 4;   
            end
        end
    end

    % Compute convergence
    max_T_change = max(max(abs(T_new - T)));
    % Store new temperate field
    T = T_new;
    
    % Check convergence
    if max_T_change < tolerance
        fprintf('Convergence reached, number of iterations: %d\n', iteration);
        break;
    end
end


end