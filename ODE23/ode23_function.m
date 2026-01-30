function ds = ode23_function(~,s,k1,k2)

A = s(1);
B = s(2);
C = s(3);

dA = -k1*A;
dB = k1*A - k2*B;
dC = k2*B;
ds = [dA;dB;dC];

end