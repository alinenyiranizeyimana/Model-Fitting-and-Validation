t_span = [0,100];
n_0 = [40;9];
[t,n] = ode23(@predator_prey_0de23, t_span, n_0);
figure(1)
plot(t, n(:,1), 'b-', 'LineWidth', 1.5)
hold on
plot(t, n(:,2), 'r-', 'LineWidth', 1.5)
hold off
xlabel('Time')
ylabel('Population')
legend('Prey (N_h)', 'Predators (N_p)')
title('Predator-Prey Dynamics')
grid on






