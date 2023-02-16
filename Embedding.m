clear all
close all
clc

%host image processing_1st level DWT

i=imread('modified_image.png');

[LL,LH,HL,HH]=dwt2(i,'haar');

%host image processing_2nd level DWT

[LL2,LH2,HL2,HH2]=dwt2(HL,'haar');

%host image processing_SVD processing

[U_img,S_img,V_img]= svd(HL2);

%watermark processing_1st level DWT

 w=imread('logo.png');
 imshow(w);
 figure

[LLw,LHw,HLw,HHw]=dwt2(w,'haar');

[U_wimg,S_wimg,V_wimg]= svd(HLw);

%watermark embedding

S_wimg1=S_img+(0.9*S_wimg);

%image restoration_inverse SVD

wimg = U_img*S_wimg1*V_img';

%image restoration_inverse DWT_1st level

newhost_HL2=wimg;
newhost_HL=idwt2(LL2/255,LH2/255,newhost_HL2/255,HH2/255,'haar');

%image restoration_inverse DWT_2nd level

y=idwt2(LL/255,LH/255,newhost_HL/255,HH/255,'haar');

imshow(y);
imwrite(y,'watermarked_modified_image.png','png');