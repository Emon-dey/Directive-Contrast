clear all
close all
clc

%image restoration_pixel restoration

y=imread('watermarked_modified_image.png');
% imshow(y);

[LL1,LH1,HL1,HH1]=dwt2(y,'haar');

RGB=imread('lena.png');
% figure;imshow(RGB);

YIQ=rgb2ntsc(RGB);
% figure;imshow(YIQ);

[LL,LH,HL,HH]=dwt2(YIQ(:,:,2),'haar');

CH=LH/LL;
CV=HL/LL;
CD=HH/LL;

T_CH=sort(0.98*CH);
T_CV=sort(0.3*CV);
T_CD=sort(0.1*CD);

m=LL;
% [a,b]=size(m);
% for i=1:a
%     for j=1:b
%             if m(i,j)<=0.95 
%                m(i,j)=m(i,j);
%             else
%                 m(i,j)=0;
%             end
%     end 
% end
% % figure;imshow(m);

n=CH;
[a,b]=size(n);
for i=1:a
    for j=1:b       
            if n(i,j)<T_CH;
               n(i,j)=n(i,j);
            else
                n(i,j)=0;
            end
        end
end
% figure;imshow(n);
 
p=CV;
[a,b]=size(p);
for i=1:a
    for j=1:b        
            if p(i,j)<T_CV;
               p(i,j)=p(i,j);
            else
                p(i,j)=0;
            end
        end
end
% figure;imshow(p);
 
q=CD;
[a,b]=size(q);
for i=1:a
    for j=1:b       
            if q(i,j)<T_CD;
               q(i,j)=q(i,j);
            else
                q(i,j)=0;
            end
        end
end
% figure;imshow(q);

LH_2=LH1+n;
HL_2=HL1+p;
HH_2=HH1+q;


z=idwt2(LL1/255,LH_2/255,HL_2/255,HH_2/255,'haar');
% figure;imshow(z)

wimg=cat(3,YIQ(:,:,1),z,YIQ(:,:,3));
% figure;imshow(wimg);

x=ntsc2rgb(wimg);
figure;imshow(x);
imwrite(x,'watermarked_image.png','png');