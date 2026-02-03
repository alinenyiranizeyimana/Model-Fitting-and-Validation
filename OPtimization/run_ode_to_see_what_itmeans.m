k1 = 0.4;
k2 = 0.2;

s0 = [1; 0; 0];          
tspan = [0 1];

[t,s] = ode45(@(t,s) myfirstode(t,s,k1,k2), tspan, s0);

%=========== To get at a end values of A,B,C time ===================
A1 = s(end,1);
B1 = s(end,2);
C1 = s(end,3);

fprintf("At t = %.2f: A = %.6f, B = %.6f, C = %.6f\n",t(end), A1, B1, C1);

A = s(:,1); B = s(:,2); C = s(:,3);
plot(t,A,t,B,t,C), legend('A','B','C'), grid on

%%

function ds = myfirstode(t, s, k1, k2)

A = s(1);
B = s(2);
C = s(3);

dA = -k1 * A;
dB =  k1 * A - k2 * B;
dC =  k2 * B;

ds = [dA; dB; dC];

end
