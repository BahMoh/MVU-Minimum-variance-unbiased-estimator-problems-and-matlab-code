clc;
clear;
close all;

% Load in the data and add gaussian noise
data = load("x.mat");

x = data.x + randn(100,1);
% Size of the signal
N = size(data.x);
N = N(1);


% %Create matrix H 5 elements
% % It's likely that we get a singular matrix
% for n = 1:1:N
%     H(n, :) = [1, n, n^2, n^3, n^4];
% end
% % Create matrix time
% for n = 1:1:N
%     t(n, :) = [1 n n^2 n^3 n^4];
% end


% TO avoid singularity we reduce the H dimension by 1
for n = 1:1:N
    H(n, :) = [1, n, n^2, n^3];
end

%Estimated Parameters
theta_hat = inv(H' * H) * H' * x;

%Create the matrix time
for n = 1:1:N
    t(n, :) = [1 n n^2 n^3];
end
% Estimate the signal
x_hat = t * theta_hat;

% x_hat(N, 1) = 0;
%Create the estimated signal
% for n = 1:1:N
%     x_hat(n, 1) = theta_hat(1) + theta_hat(2) * n + theta_hat(3) * n^2, theta_hat(4) * n^3
% end

% calculate mse to determine the accuaracy of the estimate
mean_square_error = immse(x_hat, x);

% Cause the number of datapoints is small, the estimated siganl might not
% be a good representaion of the actual signal

figure
plot(x)
hold on 
plot(x_hat, 'r--')
title("Estination vs Noisy signal")
xlabel("Number of samples")
ylabel("signal")
legend("Measured signal", "Estimated signal")