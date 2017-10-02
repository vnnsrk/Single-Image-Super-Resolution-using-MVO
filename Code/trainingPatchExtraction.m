clc;
clear;
close all;

w=[27 27]; zom=4; numimg=[1 435];

%%%%%%%%%%%%% MEDICAL IMAGES %%%%%%%

wl=w(1);
wb=w(2);

count=0;
sum=0;
asum=0;

for k=numimg(1):numimg(2)
  jpgFilename = strcat('C:\Users\srinath8n\Documents\MATLAB\Faces\t (', num2str(k),').jpg');
  img1=rgb2ycbcr(imread(jpgFilename)); % Original images
  img=double(img1(:,:,1)); % Only y component taken
  [m,n]=size(img);
%   nn1=m-wb+1;
%   nn2=n-wl+1;
  nn1=floor(m/wb);
  nn2=floor(n/wl);
    
    temp8=imresize(img,[floor(m/zom) floor(n/zom)],'bilinear');
    imtrlr=imresize(temp8,[m n],'bilinear');
    
    for ii=1:nn1
     for jj=1:nn2
        temp23=imtrlr((ii-1)*wb+1:ii*wb,(jj-1)*wl+1:jj*wl);
        temp4=img((ii-1)*wb+1:ii*wb,(jj-1)*wl+1:jj*wl);
        
        temp56=temp23';
        sum=sum+(temp23*temp56);
        asum=asum+(temp4*temp56);
        count=count+1;
        
     end
    end
end

[u, s, v]=svd(sum);
for i=1:wl 
    s(i,i)=1/s(i,i); 
end
    
aopnorm=asum*(v*s*(u'));