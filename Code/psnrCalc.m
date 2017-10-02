function [psnr]=psnrCalc(imtest_hr1,imtest_hr)

imtest3=imtest_hr1(:,:,1);
[m2,n3]=size(imtest3);

imtest1=imtest_hr(1:m2,1:n3,1);
[m1,n2]=size(imtest1);


lms1=0;
if(m2==m1 && n2==n3)
    for i=1:m1
        for j=1:n2
           lms1=lms1+(imtest1(i,j)-imtest3(i,j))^2;
        end
    end
else
    disp('Size mismatch');    
end

lms2=sqrt(lms1/m1/n2);
psnrlr=20*log10(255/lms2);
fprintf('\n The PSNR in LR image is : ');
disp(psnrlr);

end