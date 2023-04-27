clc;
clear;
close all;

% Parameters
A0 = 1;
A1 = 0.2;
A2 = -1;

%Sampling time
Ts = 0.1;

% Define number of data  points
N = 1000;

% Time vector
t = linspace(0, 90, N);

datapoint_length = size(t)

% Construct the signal(Actual signal + white noise of size(t)
% Noisy signal
x = A0 + A1 * sin(2*t) + A2 * exp(-0.5*t) + 0.1 * randn(datapoint_length);

% Actual signal without noise
% x = A0 + A1 * sin(2*t) + A2 * exp(-0.5*t)

% Create a place holder for Matrix H
H = zeros(N,3);

% Create the H Martix
% If the Matrix H was of shape ( ,5) or higher we would get a singular or
% near-to-singular matrix
for n = 1:1:N
    H(n, :) = [1, sin(2 * t(n)), exp(-0.5 * t(n))];
end


%Estimated Parameters
theta_hat = inv(H' * H) * H' * x';

% Estimate the signal
% Create a time matrix
for n = 1:1:N
	time(n, :) = [1, sin(2 * t(n)), exp(-0.5 * t(n))];
end

% Estimated signal
x_hat = time * theta_hat;

% We can verify that if we increase the number of datapoints we get a
% smaller MSE
MSE = immse(x, x_hat')

figure
% plot(t, x_noiseless)
plot(t, x)
hold on 
plot(t, x_hat, "r--")
xlabel("time (s)")
ylabel("signal")
title("Estimated vs Noisy signal")