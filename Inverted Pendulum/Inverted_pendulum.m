clear;clc; close all

% Basic Inverted Pendulum Physics Simulation with no Controller/ Motor Torques

% 1. Simulation Time Setup
dt = 0.01;
t_final = 5;

Simulation = 0:dt:t_final;

N = length(Simulation);

% 2. System Constraints

g = 9.81;
L = 1.0;

theta_free = zeros(1,N);
omega_free = zeros(1,N);
theta_free(1) = deg2rad(45);


for i = 1:N-1
    
    alpha_free = (-g/L) * sin(theta_free(i));

    omega_free(i+1) = omega_free(i) + alpha_free * dt;
    theta_free(i+1) = theta_free(i) + omega_free(i+1)  * dt;

end


% 3. Plotting the results

figure;   % Opens a clean plotting window
subplot(2,1,1);                   
plot(Simulation, rad2deg(theta_free), 'b-', 'LineWidth', 2); 
grid on;                            % Adds a grid so you can read values

% Add engineering context
xlabel('Time (seconds)');
ylabel('Pendulum Angle (degrees)');
title('Simple Pendulum Free Response');






%% Inverted Pendulum with motor torques

theta = zeros(1,N);
omega = zeros(1,N);
theta(1) = deg2rad(60);

% Setting up Gains

Kp = 40;    % Proportional Gain
Ki = 0;    % Integral Gain (Keep at 0 for now)
Kd = 25;    % Derivative Gain

target = pi;


% --- ANIMATION WINDOW SETUP ---
figure('Position', [300, 200, 600, 600]); % Open a square window
hold on; grid on;
axis([-1.5*L, 1.5*L, -1.5*L, 1.5*L]);     % Fix the coordinate boundaries
axis square;                             % Keep aspect ratio 1:1

% Draw the fixed base pivot point
plot(0, 0, 'ks', 'MarkerSize', 10, 'MarkerFaceColor', 'k'); 

% INITIAL DRAW: Create the rod and mass graphic handles
% We initialize them with the starting position data
x_tip = L * sin(theta(1));
y_tip = -L * cos(theta(1));

% 'h_rod' represents the line, 'h_mass' represents the circle on the tip
h_rod  = plot([0, x_tip], [0, y_tip], 'b-', 'LineWidth', 3);
h_mass = plot(x_tip, y_tip, 'ro', 'MarkerSize', 12, 'MarkerFaceColor', 'r');

title('Live Inverted Pendulum Simulation');
xlabel('X Position (m)');
ylabel('Y Position (m)');

for i = 1:N-1

    err = theta(i) - target;    % error Term 

    u = -(Kp*err + Kd*omega(i)); % control input

    alpha = (-g/L) * sin(theta(i)) + u ;

    omega(i+1) = omega(i) + alpha * dt;      % step update
    theta(i+1) = theta(i) + omega(i+1) * dt; % step update

     % --- ANIMATION UPDATE ---
    % Calculate the new tip coordinates based on the next angle
    x_next = L * sin(theta(i+1));
    y_next = -L * cos(theta(i+1));
    
    % Instantly update the existing graphic handles with new coordinates
    set(h_rod, 'XData', [0, x_next], 'YData', [0, y_next]);
    set(h_mass, 'XData', x_next, 'YData', y_next);
    
    % Force MATLAB to flush the graphics queue and draw immediately
    drawnow; 

end

%subplot(2,1,2);
%plot(Simulation,rad2deg(theta),'r',LineWidth= 1.2);
%xlabel("Time"); ylabel("theta");
%title("Inverted Pendulum with PD controller");
%grid on;



