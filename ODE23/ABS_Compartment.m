clear all;

s0 = [1 0 0]; 
tspan = [0,10]
k1 = 0.7;
k2 = 0.2;

opts = odeset("RelTol",1e-8, "Stats","on")

[t,s] = ode23(@ode23_function,tspan,s0,opts,k1,k2);

plot(t,s) 
legend("A","B","C")
grid on


