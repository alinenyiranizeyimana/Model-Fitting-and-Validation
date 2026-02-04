clear; close all; clc

t = [0 60 120 180 240 300 360 420 480 540 840 1020 1320]';  
T_observed = [31 28 24 20 17.5 15.5 13.5 12 11 10 8 7 6.5]';

T_water = 5;
T_air   = 23;
T0 = T_observed(1);

%======== initial guess [k1 k2] 
k0=[0.01 0.01];



options = optimset('Display','iter','TolFun',1e-10,'TolX',1e-10, ...
                   'MaxFunEvals',5000,'MaxIter',5000);

[k_opt ssmin] = fminsearch(@ss_temperature, k0,[options], t , T_observed,T0,T_water, T_air);



k1 = k_opt(1);
k2 = k_opt(2);

fprintf('k1 = %.8g 1/s\n', k1);
fprintf('k2 = %.8g 1/s\n', k2);
fprintf('SSmin = %.8g\n', ssmin);

% Plot fit
T_fit = temperature_model(t, T0, k_opt, T_water, T_air);

figure;
plot(t, T_observed, 'o', t, T_fit, '-'); grid on
xlabel('time (s)'); ylabel('Temperature (^oC)')
legend('Observed','Model fit')


%==================== FUNCTIONS  ====================

%%

function ss = ss_temperature(k, t, T_obs, T0, Twater, Tair)
    T_fit = temperature_model(t, T0, k, Twater, Tair);
    ss = sum((T_obs - T_fit).^2);
end


%%
function T_fit = temperature_model(t, T0, k, Twater, Tair)

    [tSol, TSol] = ode45(@temperature_ODE, t, T0, [], k, Twater, Tair);

    T_fit = TSol;
end



function dTdt = temperature_ODE(~, T, k, Twater, Tair)
    dTdt = -k(1)*(T - Twater) - k(2)*(T - Tair);
end
