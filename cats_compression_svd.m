clear all; close all; clc
% Read image
A = imread('photo.jpg');
figure;
image(A); axis image off
title('Original image (color)')
% Convert to grayscale (double precision)
X = double(rgb2gray(A));
figure;
imagesc(X); axis image off; colormap gray
title('Original image (grayscale)')
% Economy-size SVD
[U,S,V] = svd(X,'econ');
% Truncated SVD reconstructions
r_list = [5 10 100 853];

for r = r_list
Xapprox = U(:,1:r) * S(1:r,1:r) * V(:,1:r)';
figure;
imagesc(Xapprox); axis image off; colormap gray
title(['Truncated SVD reconstruction, r = ', num2str(r)])
end
% Cumulative proportion of singular values
singvals = diag(S);
figure;
plot(1:length(singvals), ...
cumsum(singvals)/sum(singvals), 'o-', ...
'MarkerIndices', [5 10 100 853])
xlabel('r (number of singular values)')
ylabel('Cumulative proportion')
axis tight