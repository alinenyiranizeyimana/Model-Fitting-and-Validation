% Fitting a linear model to data
% The data:
X = [100.0 2.0
220.0 2.0
100.0 4.0
220.0 4.0
75.1 3.0
244.8 3.0
160.0 1.5
160.0 4.4
160.0 3.0
75.1 3.0
75.1 3.0];
Y = [25.0 14.0 6.9 5.9 14.1 9.3 18.2 5.6 9.6 14.9 14.8]';
n = length(Y); % number of data points
% constructing the design matrix
X2 = [ones(n,1) X X(:,1).^2 X(:,1).*X(:,2) X(:,2).^2];
b = X2\Y; % LSQ fit
yfit = X2*b; % model response
% visualizing the fit
plot(1:n,Y,'o',1:n,yfit); title('model fit');