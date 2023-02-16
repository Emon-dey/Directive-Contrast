clear all
close all
clc

h=imread('lena.png');imshow(h);

w=imread('watermarked_image.png');figure;imshow(w);

% x=imnoise(w,'gaussian',0,0.001);imshow(x); %gaussian_noise

% x=imnoise(w,'speckle',0.04);imshow(x); %speckle_noise

% x=imnoise(w,'salt & pepper',0.001);imshow(x); %salt_&_pepper_noise

% x=imnoise(w,'poisson');imshow(x); %poisson_noise

% x=imrotate(w,20,'crop');imshow(x); %rotation_attack

% x=imcrop(w,[75 68 340 380]);imshow(x); %crop_attack

% x=histeq(rgb2gray(w));imshow(x); %histogram_equalization

% x=imadjust(rgb2gray(w));imshow(x); %contrast adjustment

% imwrite(w,'watermarked_image.jpg','jpg'); %jpeg_compression
% x=imread('watermarked_image.jpg');

%psnr for noise attacks

[row,col] = size(h);
size_host_ = row*col;
o_double = double(h);
w_double = double(w);
s=0;
for j = 1:size_host_; % the size of the original image
s = s+(o_double(j) - w_double(j)).^2 ; 
end
mes=s./size_host_;
psnr =10*log10((255).^2/mes);

display 'Value of',psnr

%psnr for geometric attack(crop,rotate)

% [row,col] = size(x);
% size_host_ = row*col;
% o_double = double(h);
% w_double = double(x);
% s=0;
% for j = 1:size_host_; % the size of the original image
% s = s+(o_double(j) - w_double(j)).^2 ; 
% end
% mes=s./size_host_;
% psnr =10*log10((255).^2/mes);
% 
% display 'Value of',psnr

%psnr for image processing signal attack(histogram equalization,contrast
%adjustment)

% h1=rgb2gray(h);
% 
% [row,col] = size(h1);
% size_host_ = row*col;
% o_double = double(h1);
% w_double = double(x);
% s=0;
% for j = 1:size_host_; % the size of the original image
% s = s+(o_double(j) - w_double(j)).^2 ; 
% end
% mes=s./size_host_;
% psnr =10*log10((255).^2/mes);
% 
% display 'Value of',psnr