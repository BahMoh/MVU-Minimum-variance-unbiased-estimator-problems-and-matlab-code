clc;
clear;
close all;

%x(n) = A + B*n + w(n)

A = 1;
B = 2;
N = 1000;
w = 10 * randn(N, 1);
for n = 1:1:N
    x(n) = A + B * (n) + w(n);
end

% Matrix H
for n= 1:1:N
    H(n,:) = [1 n];
end
theta_hat = inv(H' * H) * H' * x';




% Create matrix time
for n = 1:1:N
    t(n, :) = [1 n];
end
% Estimate the signal
x_hat = t * theta_hat;


%inv(H'*H)*H'*x
figure
hold on
xlabel('time(s)')
ylabel('signal')
plot(x_hat, 'r--')
plot(x)
legend('Estimated', 'Measured x')
