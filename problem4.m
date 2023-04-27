clc;
clear;
close all;

t_initial = 0;
dt = 0.01;
t_final = 100;

G = tf([0.09603 -0.2176 0.2118 -0.1307 0.0449], ...
    [1 -3.897 6.537 -5.934, 2.93 -0.6273], dt)

u = 15 * randn(t_final/dt);

y(1:5) = 0;
for n = 6:1:t_final/dt
    y(n) = [y(n-1) -y(n-2) y(n-3) -y(n-4) y(n-5) u(n) u(n-1) u(n-2) u(n-3) u(n-4)]*...
    [-3.897; 6.537; -5.934; 2.93; -0.6273; 0.09603; -0.2176; 0.2118; -0.1307; 0.0449];
    
    Y(n,:) = y(n) + 0.1*randn(1, 1);
    H(n, :) = [y(n-1) -y(n-2) y(n-3) -y(n-4) y(n-5) u(n) u(n-1) u(n-2) u(n-3) u(n-4)];
end
% H(:5, :) = [zeros(5,5) randn(5,5)]
% for i = 1:5
%     H(i,:)=[0 0 0 0 0 u(1:5)]
% end
theta_hat = inv(H'*H)*H'*Y;

G_hat = tf([theta_hat(6:10)'], [1 theta_hat(1:5)'], dt)
% step(G)
step(G_hat, G)
legend("Estimated transfer function", "transfer function")