A = [2, 3, -1; 4, -1, 2; 3, 2, -3; 1, 2, 1];
b= [5;7;8;3]

[U,S,V]= svd(A)

rank=2

u_truncated = U(:, 1:rank)
s_truncated = S(1:rank, 1:rank)
v_truncated = V(:, 1:rank)

inverse_A = v_truncated * inv(s_truncated) * u_truncated'

% Comparing inv and \ to see if there is an different 
%inverse_A_backslash = v_truncated * (s_truncated\u_truncated')
% Values found and using backslash
% If not truncked the values is the same 


x_y_z_trunck = inverse_A * b;
x_y_z_slash =  A \ b

fit_b_trunck = A* x_y_z_trunck 
fit_b_slash =A*  x_y_z_slash 

%Check the residuals ............

norm_backslash = norm(fit_b_slash - b)
norm_trunc = norm(fit_b_trunck - b)

sum_squared_slach = sum((fit_b_slash - b).^2)
sum_trunc = sum((fit_b_trunck - b).^2)