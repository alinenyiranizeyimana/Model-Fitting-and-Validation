
%% Data


% Initial guess
k1 = 0.3;
k2 = 0.2;

teta = [k1 k2];


ydata = [1.0003   0.0001   -0.0002
         0.4962   0.4512    0.0527
         0.2455   0.5928    0.1601
         0.1227   0.5969    0.2812
         0.0613   0.5448    0.3953
         0.0299   0.4723    0.4976
         0.0146   0.4004    0.5843
         0.0074   0.3354    0.658
         0.0031   0.2787    0.7184
         0.0011   0.2297    0.768
         0.0012   0.1879    0.8107];





%% Optimizer (fminisearch

% ============ Continue give the values of k1, k2 until the 
% SS is the least smaller


t = [0:1:10]';
y = ydata(:,2);

data = [t,y];

s0= [1 0 0];

parameter_theta_optimizer = fminsearch(@objective_ABC_least, ...
    teta , [ ], s0,data);



%%%% ODE to plot the proved teta

k1 = parameter_theta_optimizer(1);
k2 = parameter_theta_optimizer(2);
[t,s] = ode23(@slopeode,t,s0,[],k1,k2);
figure;
plot(t,y,'o',t,s)











%% Objective function that get's the values of A,B,C 

% But since we have B obseved we will compute all and compare the 
% B computed and the observed


function lsq = objective_ABC_least(teta , s0, data)

t= data(:,1);

B_obs = data(:,2);

k1 = teta(1); 
k2 = teta(2);

[t, Computed] = ode23(@slopeode, t, s0, [], k1, k2);


B_computed = Computed(:,2);

lsq = sum((B_obs - B_computed).^2);


figure(1); clf;
plot(t, B_obs, 'o', t, B_computed, '-');
grid on;
legend('Observed B','Model B');
title(sprintf('k1=%.4f, k2=%.4f, LSQ=%.6g', k1, k2, lsq));

% update the figure window right now. without waiting to finish the code 
drawnow;   

end












%% Slope calculation to be used by ODE

function dslope = slopeode(t,s, k1,k2)

A= s(1);
B = s(2);
C = s(3);

dA = -k1*A;
dB = k1*A - k2*B;
dC = k2*B;

dslope = [dA; dB; dC];

end