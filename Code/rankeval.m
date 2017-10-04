% Author - Srinath Narayanan
% For Single image SR project


%% rankeval - Computes the MVO, the rank and the time taken for the evaluation
% Params :
% w - Window size
% zom - zoom factor
% numimg - Number of images

function [sum,asum,rk2,timediff] = rankeval(w,zom,numimg)

    % example input
    % w=[3 3];
    % zom=2;
    % numimg=[1 435];
    ty=tic;

    wl=w(1);
    wb=w(2);
    count=0;
    sum=0;
    rlr=0;
    rhr=0;
    rk2=0;
    for k=numimg(1):numimg(2)
      % use faces folder for face images. (1,435 )Image pool\Faces
      jpgFilename = strcat('..\Data\Faces\t (', num2str(k),').jpg');
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

          if(rank(floor(temp23))<(wl))
              rlr=rlr+1; 
          end

          if(rank(floor(temp4))<wb)
              rhr=rhr+1; 
          end

          temp56=temp23';
          sum=sum+(temp23*temp56);
          asum=asum+(temp4*temp56);
          count=count+1;
       end
      end
    end
    if(rank(sum)<wl)
           rk2=rk2+1; 
    end

    timediff=toc(ty);
end