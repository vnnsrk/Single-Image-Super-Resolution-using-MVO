% Author - Srinath Narayanan
% For Single image SR project

%% IGNORE
%% Test script to verify code work

% clc;
% clear all;
% close all;

for i=1:10
    aop=0;timediff=0; w=0 ;zom=0;
    [aop,timediff, w ,zom]=trainingPatchExtraction([27 27],i,[1 91]);
    r=strcat('ap',num2str(i));
    save(r,'aop','timediff','w','zom');
end
for j=1:10
    r=strcat('ap',num2str(j));
    for k=1:10
        [timediff2(j,k),psnrlr(j,k),psnrout(j,k)]=testingPatchExtraction(0,k,r,'lena_high.tiff');
%         close all;
    end
end