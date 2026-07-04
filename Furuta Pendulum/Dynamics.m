clear; clc; close all

%% Main Simulation Code

params.L1 = 0.278;
params.l1 = 0.150;
params.l2 = 0.148;

params.m1 = 0.300;
params.m2 = 0.075;

params.J1 = 2.48e-2;
params.J2 = 3.86e-3;

params.b1 = 1.00e-4;
params.b2 = 2.80e-4;

params.g = 9.81;

params.tau2 = 0;

% Equivalent inertia definitions
params.J1_bar = params.J1 + params.m1*params.l1^2;
params.J2_bar = params.J2 + params.m2*params.l2^2;
params.J0_bar = params.J1_bar + params.m2*params.L1^2;

%% PD / state-feedback gains
% x_error = [theta1_error; theta2_error_from_upright; theta1dot; theta2dot]
params.K = [-0.0432, 3.6260, -0.0902, 0.7924];

% Motor torque saturation
params.tauMax = 0.3;

% Desired arm angle
params.theta1_ref = 0;

% State:
% x = [theta1; theta2; theta1dot; theta2dot]
% theta2 = pi is upright

x0 = [0;
      0;
      0;
      0];

tspan = 0:0.01:10;

[t,x] = ode45(@(t,x) furuta_paper_dynamics_PD(t,x,params), tspan, x0);

%% Plot raw angles
figure
plot(t, rad2deg(x(:,1)), 'LineWidth', 1.5)
hold on
plot(t, rad2deg(x(:,2)), 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel('Angle (deg)')
legend('\theta_1 arm','\theta_2 pendulum')
grid on

%% Plot pendulum error from upright
theta2_from_upright = atan2(sin(x(:,2) - pi), cos(x(:,2) - pi));

figure
plot(t, rad2deg(theta2_from_upright), 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel('\theta_2 error from upright (deg)')
title('Pendulum Stabilization Around Upright')
grid on


%% Furuta Pendulum Dynamics with PD Controller

function dx = furuta_paper_dynamics_PD(t,x,params)

m2 = params.m2;
L1 = params.L1;
l2 = params.l2;

J0 = params.J0_bar;
J2 = params.J2_bar;

b1 = params.b1;
b2 = params.b2;
g  = params.g;

tau2 = params.tau2;

theta1    = x(1);
theta2    = x(2);
theta1dot = x(3);
theta2dot = x(4);

%% Angle errors

% Arm angle error
e_theta1 = atan2(sin(theta1 - params.theta1_ref), ...
                 cos(theta1 - params.theta1_ref));

% Pendulum angle error relative to upright
e_theta2 = atan2(sin(theta2 - pi), ...
                 cos(theta2 - pi));

x_error = [e_theta1;
           e_theta2;
           theta1dot;
           theta2dot];

%% PD / state-feedback torque

tau1 = -params.K * x_error;

% Saturate motor torque
tau1 = max(min(tau1, params.tauMax), -params.tauMax);

%% Dynamics from paper Eq. (31)

M = [J0 + J2*sin(theta2)^2,       m2*L1*l2*cos(theta2);
     m2*L1*l2*cos(theta2),        J2];

N = [-m2*L1*l2*sin(theta2)*theta2dot^2 ...
     + theta1dot*theta2dot*J2*sin(2*theta2) ...
     + b1*theta1dot;

     -0.5*theta1dot^2*J2*sin(2*theta2) ...
     + b2*theta2dot ...
     + g*m2*l2*sin(theta2)];

u = [tau1;
     tau2];

qdd = M \ (u - N);

dx = [theta1dot;
      theta2dot;
      qdd(1);
      qdd(2)];

end