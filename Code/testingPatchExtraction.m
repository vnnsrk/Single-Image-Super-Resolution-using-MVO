% Author - Srinath Narayanan
% For Single image SR project

% FIL and AOP are got from workspace
wrkn2='san20w27z3norm';
wrkname2=strcat('..\Data\',wrkn2,'.mat');
load(wrkname2);
aop=aopnorm;
wb=w(1);
wl=w(2);
co=0;

%% Get images
timg='lena_high.tiff';
imtest_hr=double(rgb2ycbcr(imread(strcat('..Data\',timg)))); % Original image
imtest1=imtest_hr(:,:,1);
[m1,n2]=size(imtest1);

%% Resize
imtest2=imresize(imtest1,[floor(m1/zom) floor(n2/zom)],'bicubic'); 
imtest3=imresize(imtest2,[m1 n2],'bicubic'); 

nnn1=floor(m1/wl);
nnn2=floor(n2/wb);

%% Compute the output images
for i=1:nnn1
    for j=1:nnn2
        tires=imtest3((i-1)*wb+1:i*wb,(j-1)*wl+1:j*wl);
        outi((i-1)*wb+1:i*wb,(j-1)*wl+1:j*wl)=aop*tires;
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

%% To compute HR and LR images
it1=ycbcr2rgb(uint8(imtest_hr(1:outsize(1),1:outsize(2),:)));
it2=ycbcr2rgb(uint8(imtest_lr(1:outsize(1),1:outsize(2),:)));
it3=ycbcr2rgb(uint8(imsr));   %(1:outsize(1),1:outsize(2),:)

%% TO SHOW TEST HR AND LR IMAGES
% figure;
% % sizehr=size(it1);
% % sizehr
% % imshow(it1);
% % title('Org image full resolution');
% str1=strcat('..\Data\Test\col',timg,'_gnd.tiff');
% imwrite(it1,str1);

% % figure;
% % imshow(it2);
% % sizelr=size(it2);
% % sizelr
% st2=strcat('..\Data\Test\col',timg,'_lr_z',num2str(zom),'.tiff');
% imwrite(it2,st2);
% title('Org image LOW resolution');

% figure;
% (1:(end-wl+1),1:(end-wb+1),:)     
% imshow(it3);
% title('OUT IMAGE ');
% str3=strcat('..\Data\Test\col',timg,'_out_',wrkn2,'.tiff');
% imwrite(it3,str3);

%% ERROR IN ORIGINAL LINEARLY INTERPOLATED IMAGE
lms2=0;

for i=1:outsize(1)
    for j=1:outsize(2)
        lms2=lms2+(imtest1(i,j)-outi(i,j))^2;
    end
end
lms2=sqrt(lms2/outsize(1)/outsize(2));
psnrout=20*log10(255/lms2);
sout=ssim_wl(imtest1(1:outsize(1),1:outsize(2)),outi);

%% Print statements
% fprintf('\n The PSNR in output image is : ');
% disp(psnrout);
% disp('PSNR : ');
% disp(psnr(uint8(imtest1),uint8(outi)));
% fprintf('\n The PSNR in LR image is : ');
% disp(psnr2);

%% Compute time diff
% time4=toc;
% timediff2=time4-time3;

%% Print and save work
% if(saveornottest)
%     wrks=input('Enter the testing image workspace filename : ','s');
%     wrkspacename=strcat('..\Data\',wrks,'.mat');
%     save(wrkspacename);
% end
% fprintf(strcat('For image : col',num2str(ci),' : '));
% disp('Num : ');
% disp(ci);

fprintf('%0.4f\t',psnrout);
fprintf('%0.4f\n',sout)
fprintf('%0.4f\t',psnrlr);
fprintf('%0.4f\n\n',slr);

% timediff
% timediff2
