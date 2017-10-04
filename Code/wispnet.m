% Author - Srinath Narayanan
% For Single image SR project

%% Test code implementing paper submitted to WispNet 2016, extending the concept of MVO

% clc;
% clear all;
% close all;

%% Sets up environment
spsnr=zeros(1,11);
st=zeros(1,11);
tic;
count=1;

%% FIL and AOP are got from workspace
wrkn2='san20w27z299norm';
wrkname2=strcat('..\Data\',wrkn2,'.mat');
load(wrkname2);
clear -aopnorm;

wrkn3='san20w27z299hr';
wrkname3=strcat('..\Data\',wrkn3,'.mat');
load(wrkname3);

%% Sets up env
wb=w(1);
wl=w(2);
co=0;
cou1=0;cou2=0;
timg='lena.tiff';
imtest_hr=double(rgb2ycbcr(imread(strcat('..\Data\',timg)))); % Original image
imtest1=imtest_hr(:,:,1);
[m1,n2]=size(imtest1);

%% Interpolates and gets required images
varimg=var(reshape(imtest1,[m1*n2,1]));
imtest2=imresize(imtest1,[floor(m1/zom) floor(n2/zom)],'bilinear'); 
imtest3=imresize(imtest2,[m1 n2],'bilinear'); 
im3=imfilter(imtest3,r,'replicate');

nnn1=floor(m1/wl);
nnn2=floor(n2/wb);

%% Computes the output images
for i=1:nnn1
    for j=1:nnn2
        imgvar=imtest1((i-1)*wb+1:i*wb,(j-1)*wl+1:j*wl);
        varpatch=var(reshape(imgvar,[wb*wl,1]));
        
        if(varimg/varpatch<alp)
            tires=imtest3((i-1)*wb+1:i*wb,(j-1)*wl+1:j*wl);
            outi((i-1)*wb+1:i*wb,(j-1)*wl+1:j*wl)=aopnorm*tires;
            cou1=cou1+1;
        else
            tires=im3((i-1)*wb+1:i*wb,(j-1)*wl+1:j*wl);
            outi((i-1)*wb+1:i*wb,(j-1)*wl+1:j*wl)=imtest3((i-1)*wb+1:i*wb,(j-1)*wl+1:j*wl)+aophr*tires;
            cou2=cou2+1;
        end 
        co=co+1;
    end
end

imtest_lr=imtest_hr;
imtest_lr(:,:,1)=imtest3;

outsize=size(outi);
imsr=imtest_hr(1:outsize(1),1:outsize(2),:);
imsr(:,:,1)=outi;


%% ERROR ESTIMATION - PSNRLR
lms1=0;
for i=1:outsize(1)%m1
    for j=1:outsize(2)%n2
        lms1=lms1+(imtest1(i,j)-imtest3(i,j))^2;
    end
end
lms1=sqrt(lms1/outsize(1)/outsize(2));
psnrlr=20*log10(255/lms1);
slr=ssim_wl(imtest1(1:outsize(1),1:outsize(2)),imtest3(1:outsize(1),1:outsize(2)));


%% TO SHOW TEST HR AND LR IMAGES
% it1=ycbcr2rgb(uint8(imtest_hr(1:outsize(1),1:outsize(2),:)));
% 
% str1=strcat('..\Data\Test\col',timg,'_gnd.tiff');
% imwrite(it1,str1);
% 
% it2=ycbcr2rgb(uint8(imtest_lr(1:outsize(1),1:outsize(2),:)));
% 
% st2=strcat('..\Data\Test\col',timg,'_lr_z',num2str(zom),'.tiff');
% imwrite(it2,st2);
% 
% it3=ycbcr2rgb(uint8(imsr));            
% 
% str3=strcat('..\Data\Test\col',timg,'_out_',wrkn2,'.tiff');
% imwrite(it3,str3);

%% ERROR IN ORIGINAL LINEARLY INTERPOLATED IMAGE
lms2=0;
for i=1:outsize(1)
    for j=1:outsize(2)
        lms2=lms2+(imtest1(i,j)-imsr(i,j,1))^2;
    end
end
lms2=sqrt(lms2/outsize(1)/outsize(2));
psnrout=20*log10(255/lms2);
sout=ssim_wl(imtest1(1:outsize(1),1:outsize(2)),imsr(:,:,1));

spsnr(count)=psnrout;
disp(alp);
b=toc;
st(count)=b;
count=count+1;

%% Display eval terms
% fprintf('%0.4f\t',psnrlr);
% fprintf('%0.4f\n',psnrout)
% fprintf('%0.4f\t',slr);
% fprintf('%0.4f\n\n',sout);