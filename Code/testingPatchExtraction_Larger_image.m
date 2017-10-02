% Test image workspace generation
% Variables/Output available - Test image, test image patches, high and low
% resolution. PSNR of low resolution image.
% Input - w=[wb wl] patch size

% NOTE : ADDPATH('C:\Users\SREENATH\Documents\MATLAB\FYP') before
% execution.

% CHECK ON HOW TO TIME THIS FUNCTION - LATER 

% OUTPUTS ti - Array contatining patches.. size = co*wb*wl;
% co - number of test image patches
% psnrlr - Low resolution PSNR

% Inputs - w=[wb,wl] - Patch size
% showimtest - A flag to(1)/not-to(0) show images in figures.
% saveornottest - to decide on saving to workspace or not. 1 - yes. 0- no

for ci=1:10
close all;
clc;
% clear all;
clearvars -except ci

% saveornottest=0;
wrkn2='san19w27z2';
% exten='.bmp';
exten='.jpg';

tic;

aop=0;
% wrkn2=input('Enter workspace .mat file name to be loaded : ','s');
wrkname2=strcat('C:\Users\SREENATH\Documents\MATLAB\FYP\',wrkn2,'.mat');
load(wrkname2);
    
% if(aop)
%     disp('Aop Loaded');
% end
% aop=re;

wb=w(1);
wl=w(2);
co=0;
zom=0.5;
% testname=input('Enter the test image name with extension : ','s');
% testname='Girl.bmp';
imtest_hr=double(rgb2ycbcr(imread(strcat('C:\Users\SREENATH\Documents\MATLAB\College\col (',num2str(ci),')',exten)))); % Original image
% imtest_hr=imresize(imtest_hr,1/3);
imtestgnd=imresize(imtest_hr,(1/zom),'bilinear'); 
% figure;
% imshow(uint8(imtestgnd));
% title('hi');
imtest1=imtest_hr(:,:,1);
% imtest1=imresize(imtest1,size(imtest1)/zom,'bilinear');
% outi=zeros(m1,n2);
[m1,n2]=size(imtest1);
% imtest2=imresize(imtest1,[100 100],'nearest'); 
imtest2=imresize(imtest1,[floor(m1/zom) floor(n2/zom)],'bilinear'); 
[m1,n2]=size(imtest2);
imtest3=imtest2;
% imtest3=imresize(imtest2,[m1 n2],'nearest'); 

nnn1=floor(m1/wl);
nnn2=floor(n2/wb);
% aop1=aop;
% aop(2,1)=(aop1(2,1)+aop(2,3))/2;
% aop(2,3)=aop(2,1);
% aop(1,2)=(aop1(1,2)+aop(3,2))/2;
% aop(3,2)=aop(1,2);
% aop(1,3)=(aop1(1,3)+aop(3,1))/2;
% aop(3,1)=aop(1,3);
% aop(1,1)=(aop1(1,1)+aop(3,3))/2;
% aop(3,3)=aop(1,1);
% aop1=aop';
% aop=(aop+aop1)/2;
% if(saveornottest)
% ti=zeros(nnn1*nnn2,wb,wl);
% end
for i=1:nnn1
    for j=1:nnn2
%         if(saveornottest)
%         ti(co+1,:,:)=imtest3((i-1)*wb+1:i*wb,(j-1)*wl+1:j*wl);
%         tires=reshape(ti(co+1,:,:),[wb,wl]);
%         else
           tires=imtest3((i-1)*wb+1:i*wb,(j-1)*wl+1:j*wl);
%         end
        outi((i-1)*wb+1:i*wb,(j-1)*wl+1:j*wl)=aop*tires;
        co=co+1;
    end
end

% imtest_lr=imtest_hr;
% imtest_lr(:,:,1)=imtest3;
% TO SHOW TEST HR AND LR IMAGES
% figure;
it1=ycbcr2rgb(uint8(imtest_hr));
% imshow(it1);
% title('Org image full resolution');
% imwrite(it1,'gnd.tiff');
str1=strcat('C:\Users\SREENATH\Documents\MATLAB\InputasLR_college\col',num2str(ci),'_gnd.tiff');
imwrite(it1,str1);

% figure;
lowsize=size(imtest2);
imtesttemplr=imtestgnd;
imtesttemplr(1:lowsize(1),1:lowsize(2),1)=imtest2;
it2=ycbcr2rgb(uint8(imtesttemplr(1:lowsize(1),1:lowsize(2),:)));
% imshow(it2);
% title('enlarged image low resolution');
st2=strcat('C:\Users\SREENATH\Documents\MATLAB\InputasLR_college\col',num2str(ci),'_lr_z',num2str(zom),'.tiff');
imwrite(it2,st2);
%  imwrite(it2,'lr.tiff');
% figure;
% imshow(ycbcr2rgb(uint8(imtest_lr)));
% title('Org image LOW resolution');


% ERROR ESTIMATION - PSNRLR
% lms1=0;
% for i=1:m1
%     for j=1:n2
%         lms1=lms1+(imtest1(i,j)-imtest3(i,j))^2;
%     end
% end
% lms1=sqrt(lms1/m1/n2);
% psnrlr=20*log10(255/lms1);
% disp(aop1);
% disp(aop);
outsize=size(outi);
% imsr=imresize(imtest_hr,[floor(m1/zom) floor(n2/zom)],'nearest'); 
% imsr=imtest2(1:outsize(1),1:outsize(2),1);
% imsr(:,:,1)=outi;

% figure;
% (1:(end-wl+1),1:(end-wb+1),:)
imtestgnd(1:outsize(1),1:outsize(2),1)=outi;
% (1:outsize(1),1:outsize(2),:)
it3=ycbcr2rgb(uint8(imtestgnd));
% imshow(it3);
% title('OUT IMAGE ');
% imwrite(it3,'out.tiff');
str3=strcat('C:\Users\SREENATH\Documents\MATLAB\InputasLR_college\col',num2str(ci),'_out_',wrkn2,'.tiff');
imwrite(it3,str3);
% ERROR IN ORIGINAL LINEARLY INTERPOLATED IMAGE
% lms2=0;
% m1 & n2
% for i=1:outsize(1)
%     for j=1:outsize(2)
%         lms2=lms2+(imtest1(i,j)-outi(i,j))^2;
%     end
% end
% lms2=sqrt(lms2/outsize(1)/outsize(2));
% psnrout=20*log10(255/lms2);
% fprintf('\n The PSNR in output image is : ');
% disp(psnrout);
% 
% fprintf('\n The PSNR in LR image is : ');
% disp(psnrlr);

% fprintf('\n The PSNR in LR image is : ');
% disp(psnr2);

% time4=toc;
% timediff2=time4-time3;
timediff2=toc;

end
% if(saveornottest)
%     wrks=input('Enter the testing image workspace filename : ','s');
%     wrkspacename=strcat('C:\Users\SREENATH\Documents\MATLAB\FYP\',wrks,'.mat');
%     save(wrkspacename,'timediff2','w','ti','co','psnrlr','psnrout','imtest_hr','imtest_lr','m1','n2');
% end
% save tryu1;