clear all
close all
clc

RGB=imread('lena.png');
 figure;imshow(RGB);

YIQ=rgb2ntsc(RGB);
%  figure;imshow(YIQ(:,:,2));

[LL,LH,HL,HH]=dwt2(YIQ(:,:,2),'haar');

% figure,imshow(LL);title('Approximate detail');
% figure,imshow(LH);title('horizontal detail');
% figure,imshow(HL);title('vertical detail');
% figure,imshow(HH);title('diagonal detail');

CH=LH/LL;
CV=HL/LL;
CD=HH/LL;

T_CH=sort(0.98*CH);
T_CV=sort(0.3*CV);
T_CD=sort(0.1*CD);
%pixel extraction

 m=LL;
% % [a,b]=size(m);
% % for i=1:a
% %     for j=1:b
% %             if m(i,j)>=0.30 
% %                m(i,j)=m(i,j);
% %             else
% %                 m(i,j)=0;
% %             end
% %     end 
% % end
% % figure;imshow(m);
% 
n=CH;
[a,b]=size(n);
for i=1:a
    for j=1:b       
            if n(i,j)>=T_CH;
               n(i,j)=n(i,j);
            else
                n(i,j)=0;
            end
        end
end
%  figure;imshow(n);
%  
p=CV;
[a,b]=size(p);
for i=1:a
    for j=1:b        
            if p(i,j)>=T_CV;
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
            if q(i,j)>=T_CD; 
               q(i,j)=q(i,j);
            else
                q(i,j)=0;
            end
        end
end
% figure;imshow(q);
% 
% % generating modified image 
% 
y=idwt2(m,n/255,p/255,q/255,'haar');
figure;imshow(y);
imwrite(y,'modified_image.png','png');