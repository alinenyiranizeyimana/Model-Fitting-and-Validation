
%% 1. Industrial chemical reaction

clc; close all;

load('data_W1.mat'); 

[U,S,V] = svd(X, 'econ');  

rank = 7;
U_truncated = U(:,1:rank);
S_truncated = S(1:rank,1:rank);
V_truncated = V(:,1:rank);

X_pinv_trunc = V_truncated * (S_truncated\U_truncated.');

y1 = y1(:);
y2 = y2(:);
y3 = y3(:);   

parameter_y1 = X_pinv_trunc * y1;
parameter_y2 = X_pinv_trunc * y2;  
parameter_y3 = X_pinv_trunc * y3; 


fit_y1 = X * parameter_y1;
fit_y2 = X * parameter_y2;
fit_y3 = X * parameter_y3;

residual_y1 = fit_y1 - y1;
residual_y2 = fit_y2 - y2;
residual_y3 = fit_y3 - y3;

SS_residual1 = sum(residual_y1.^2);
SS_residual2 = sum(residual_y2.^2);
SS_residual3 = sum(residual_y3.^2);

fprintf('\n******* 1. Sum of Squared Errors ***********\n');

fprintf('SSR (batch1) = %.4f, SSR (batch2) = %.4f, SSR (batch3) = %.4f\n', SS_residual1, ...
    SS_residual2, SS_residual3);


fits = {fit_y1, fit_y2, fit_y3};
ys   = {y1, y2, y3};


figure();

for i = 1:3
    yi = ys{i};
    y_fit = fits{i};

    subplot(3,1,i);
    scatter(yi, y_fit, 50, 'filled'); hold on;
  
    minvalue = min([yi; y_fit]);
    maxvalue = max([yi; y_fit]);
    plot([0 maxvalue], [0 maxvalue], 'k--');

    xlabel(sprintf('Measured y_{%d}', i));
    ylabel(sprintf('Fitted y_{%d}', i));

    title(sprintf('Batch %d: Fitted vs Measured', i));
    legend('Fitted vs Measured', 'Perfect Fit', 'Location', 'best');
    grid on;
    xlim([minvalue, maxvalue]); ylim([minvalue, maxvalue]);
end


saveas(gcf, 'Figure1_Fitted_vs_Measured.png');


%% 2. SVD economy


x = [48; 61; 81; 113; 131];
y = [91; 98; 103; 110; 112];

A = [ones(size(x)), log(x)];

[U,S,V] = svd(A, 'econ');

A_pinv = V * (S\U.');

theta = A_pinv * y;  

fprintf('\n******* 2. Theta values ***********\n');
fprintf('theta0 = %.4f, theta1 = %.4f\n', theta(1), theta(2));

x_fit = linspace(min(x)-5, max(x)+5, 100)';
y_fit = theta(1) + theta(2) * log(x_fit);

figure;
plot(x_fit, y_fit, '-k', 'LineWidth', 1.5); hold on;
scatter(x, y,60, 'b', 'filled');
xlabel('x'); ylabel('y');
title('Fit of model y = theta_0 + theta_1 ln(x) to data');
legend('Fitted model', 'Data points', 'Location', 'Northwest');
grid on;

saveas(gcf, 'Figure2_Fitted_vs_Data.png');

%% 3. Fiting linear model equation


y_data = [26.5; 57.9; 108.4; 155.9; 209.3; 272.4; 384.3];
x1 = [2.1; 4.3; 7.0; 9.1; 10.5; 12.7; 15.2];
x2 = [10.4; 15.5; 21.0; 24.9; 30.3; 33.8; 41.4];

A = [ones(size(y_data)), x1, x2, x1.*x2];

theta = pinv(A) * y_data;

fprintf('\n******* 3. Theta values ***********\n');
fprintf('theta_0 = %.4f, theta_1 = %.4f, theta_2 = %.4f, theta_{12} = %.4f\n', ...
        theta(1), theta(2), theta(3), theta(4));


y_fit = A * theta;

figure;
scatter(1:length(y_data), y_data, 60, 'k', 'filled'); hold on;
plot(y_fit, 'b--', 'LineWidth', 1);
legend('Measured', 'Fitted', 'Location', 'best');
xlabel('Index'); ylabel('y');
title('Measured vs Fitted plot of Linear model with interaction ');
grid on;


saveas(gcf, 'Figure3_Measured_vs_Intera_fitted.png');


%% Question 4

x = [5; 7; 11; 12; 15; 17; 19];
y = [0.93; 0.91; 0.84; 0.82; 0.76; 0.71; 0.66];

Y_log = log(y);         
B = [ones(size(x)), x.^2]; 
a = B \ Y_log;             
a0 = a(1); 
a1 = a(2);
theta1 = -a0; 
theta2 = -a1;

fprintf('\n******* 4. Theta values ***********\n');
fprintf('theta_1 = %.5f, theta_2 = %.5f\n', theta1, theta2);

x_fit = linspace(min(x), max(x), 100)';
y_fit = exp(-(theta1 + theta2 * x_fit.^2));   
figure;
plot(x_fit, y_fit, '-m', 'LineWidth', 1.5); hold on;
scatter(x, y, 60, 'k', 'filled');
xlabel('x'); ylabel('y');
title('Fit of model y = 1/exp(θ_1 + θ_2 x^2) to data');
legend('Fitted curve', 'Data points', 'Location', 'Northeast');
grid on;

saveas(gcf, 'Figure4_Exponential.png');

%% 5.

%****************************************************
% Aron SIR model with loss of immunity
%****************************************************


% Given 

r = 0.9;
q = 0.25;
tau = 5;
Y0 = [0.95  0.002  0.001];   
t_span = linspace(0, 50, 50);  
h_values = [5, 0.5, 0.05];

figure; hold on;
colors = ['m','k','g'];
labels = cell(1, length(h_values));

fprintf('\n******* 5. h with gamma values ***********\n');
for i = 1:length(h_values)
    h = h_values(i);

    %***********
    % Gamma 
    %***********

    gamma = (h * exp(-h*tau)) / (1 - exp(-h*tau));
    fprintf('h = %.2f  ->  gamma = %.12g\n', h, gamma);

    
    [t_sol, Y_sol] = ode45(@(t, y) aron_model_5(t, y, h, r, q, gamma), t_span, Y0);

    I_sol = Y_sol(:,2);
    plot(t_sol, I_sol, 'Color', colors(i), 'LineWidth', 1.5);

    labels{i} = sprintf('h = %.2f', h); 
end

xlabel('Time t'); ylabel('Infected I(t)');
title('Infected population I(t) in the Aron model for varying h');
legend(labels, 'Location', 'northeast');

grid on;
hold off;

saveas(gcf, 'Figure5_aron_model.png');
%% Aron model function

function dydt = aron_model_5(~, y, h, r, q, gamma)

S = y(1);
I = y(2);
R = y(3);

dS = -h*S + r*I + gamma*R;
dI =  h*S - r*I - q*I;
dR =  q*I - gamma*R;

dydt = [dS; dI; dR];
end
