function dydt = aron_model(~, y, h, r, q, gamma)
% ARON_MODEL  Aron SIR malaria model

S = y(1);
I = y(2);
R = y(3);

dS = -h*S + r*I + gamma*R;
dI =  h*S - r*I - q*I;
dR =  q*I - gamma*R;

dydt = [dS; dI; dR];
end
