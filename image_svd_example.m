A = imread("cat.jpg");

figure;
image(A); axis image off
title("original image");

X=double(rgb2gray(A));

figure;

%Scales data aotomaticall to the full colormap range 
%min first color and max to last color
% INcrease contrast for numerical matrices


imagesc(X); axis image off
title("grayscale of origina; image");

[U,S,V] = svd(X, "econ");

rank_list = [5,10,100,1000];


for r = rank_list

    Xapprox = U(:, 1:r)* S(1:r,1:r)*V(:, 1:r)';
    figure;
    imagesc(Xapprox);
    title(['TRuncated SVD, rank = ',num2str(rank_list)])
end



sigma_single_values = diag(S);

%new window
% number of singula values 1:length(sigma_single_values)(rank)
% "how many singular values have I included?"
%cumsum σ1​,σ1​+σ2​,σ1​+σ2​+σ3​,…
figure;
plot(1:length(sigma_single_values), ...
    cumsum(sigma_single_values)/sum(sigma_single_values),'o-', ...
    "MarkerIndices",[5 10 100 1000])
xlabel('number of singular values')
ylabel("cumulative proportion")

