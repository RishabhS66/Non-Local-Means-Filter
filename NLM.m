% Author: Rishabh Srivastava

% Edge preserving smoothing filters - Non Local Means

%% Reading input
Im1 = imread('lenna.noise.jpg');
[N,M] = size(Im1); % Image size
Im1 = double(Im1); % Converting image from uint8 to double for required calculations

%% Padding images to handle calculation of final pixel intensities of boundary pixels
ps = 7; % Take neighbourhood around a pixel of size (ps x ps), preferably odd
psh = floor(ps/2);
ns = 11; % Match neighbourhoods in (ns x ns) around center pixels, preferably odd
nsh = floor(ns/2);
pad_req = nsh+psh; % Padding required
Im1_pad = padarray(Im1, [pad_req pad_req], 'replicate'); % Replicates border pixel intensities 5 times
% Need to 
% Assume 7x7 patch size

%% ps x ps Gaussian Kernel
mask1 = zeros(ps,ps);
center_xy = (ps+1)/2;
for i = 1:ps
    for j = 1:ps
        mask1(i,j) = exp(-((i-center_xy)^2+(j-center_xy)^2)/(ps*ps));
    end 
end
sum_mask = sum(mask1,'all');
mask1 = mask1./sum_mask;

%% Filtering image using non local means filter
Im1_nlm = zeros(N,M); % Will store output image

sigma2 = 1000; % Variance h^2 for gaussian in Non Local Means

for i = 1:N
    for j = 1:M
        Im1_nlm(i,j) = NLM_filt(i+pad_req,j+pad_req,sigma2,Im1_pad,mask1,psh,nsh); % New pixel intensity after aplying filter
    end
end

%% Plotting input and filtered images
figure();
imshow(uint8(Im1)); % Input image
title('\fontsize{16}Original Image');

figure();
imshow(uint8(Im1_nlm)); % Output image obtained after filtering
title('\fontsize{16}Image after applying Non Local Means');

%% Function to calculate new pixel intensity after application of non local means filter at pixel
function finalvalue = NLM_filt(pi,pj,sigma2,Im,mask,psh,nsh)
%NLM returns the new pixel value

A = Im(pi-psh:pi+psh, pj-psh:pj+psh); % Neighbourhood patch around centre pixel (pi, pj)
normalising_factor = 0;
weighted_sum=0;

% Loop that iterates over pixels in 5x5 mask centred at pixel (pi,pj)
for i = pi-nsh:pi+nsh
    for j = pj-nsh:pj+nsh
        Iij = Im(i,j);
        B = Im(i-psh:i+psh,j-psh:j+psh); % Neighbourhood patch around centre pixel (i, j)
        B = A-B; % Difference between neighbourhood 
        B = B.^2; % Squared difference 
        B = B.*mask; % Gaussian weighted dquared differences
        wt = sum(B,'all'); % Gaussian weighted sum of squared differences
        wt = exp(-wt/sigma2); % Weight of neighbourhood centred at (i, j)
        normalising_factor = normalising_factor + wt;
        weighted_sum = weighted_sum + wt*Iij;    
    end
end
finalvalue = weighted_sum/normalising_factor; % Caculate new pixel intensity 
finalvalue = round(finalvalue); % Round the value to nearest integer, since pixel intensity levels are integers
end
    
