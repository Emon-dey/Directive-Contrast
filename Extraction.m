clear all
close all
clc

%host image processing

i=imread('modified_image.png');

[LL,LH,HL,HH]=dwt2(i,'haar');

[LL2,LH2,HL2,HH2]=dwt2(HL,'haar');

[U_img,S_img,V_img]= svd(HL2);

%watermark processing

w=imread('logo.png');
imshow(w);
figure

[LLw,LHw,HLw,HHw]=dwt2(w,'haar');

[U_wimg,S_wimg,V_wimg]= svd(HLw);

%extraction
z=imread('watermarked_image.png');
yw=rgb2ntsc(z);

[LL_1,LH_1,HL_1,HH_1]=dwt2(yw(:,:,2),'haar');

CH=LH_1/LL_1;
CV=HL_1/LL_1;
CD=HH_1/LL_1;

T_CH=sort(0.98*CH);
T_CV=sort(0.3*CV);
T_CD=sort(0.1*CD);

m1=LL_1;
% [a,b,c]=size(m1);
% for i=1:a
%     for j=1:b
%         for k=1:c
%             if m1(i,j,k)>=500 
%                m1(i,j,k)=m1(i,j,k);
%             else
%                 m1(i,j,k)=0;
%             end
%         end
%     end
% end
% figure;imshow(m1);

n1=CH;
[a,b]=size(n1);
for i=1:a
    for j=1:b       
            if n1(i,j)>=T_CH;
               n1(i,j)=n1(i,j);
            else
                n1(i,j)=0;
            end
        end
end
%  figure;imshow(n);
%  
p1=CV;
[a,b]=size(p1);
for i=1:a
    for j=1:b        
            if p1(i,j)>=T_CV;
               p1(i,j)=p1(i,j);
            else
                p1(i,j)=0;
            end
        end
end
% figure;imshow(p);
 
q1=CD;
[a,b]=size(q1);
for i=1:a
    for j=1:b       
            if q1(i,j)>=T_CD; 
               q1(i,j)=q1(i,j);
            else
                q1(i,j)=0;
            end
        end
end
% figure;imshow(q1);

yw1=idwt2(m1,n1,p1,q1,'haar');
% figure
% imshow(double(yw1));

[LL3,LH3,HL3,HH3]=dwt2(yw1,'haar');

[LL4,LH4,HL4,HH4]=dwt2(HL3,'haar');

[U_img3,S_img3,V_img3]= svd(HL4);

S_ewat=(S_img3-S_img)/0.9;

ewat = U_wimg*S_ewat*V_wimg';

newwatermark_HL=ewat;

rgb2=idwt2(LLw,LHw,newwatermark_HL/255,HHw,'haar');imshow(rgb2);



imwrite(rgb2,'EWatermark.png','png');title('Extracted Watermark');