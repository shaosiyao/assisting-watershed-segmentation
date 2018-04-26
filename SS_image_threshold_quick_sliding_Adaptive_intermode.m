
function thresholded=SS_image_threshold_quick_sliding_Adaptive_intermode(grayImage,m,n)


A = grayImage;
[mm,nn]=size(A);
newA=zeros(mm,nn);
k=double(fix(m/2));
p=double(fix(n/2));
% k2=int8(fix(m/2));
% p2=int8(fix(n/2));
[padding,~]=mode(A(:));
A2=padarray(A,[k p],padding,'both');%padding 
[mm2,nn2]=size(A2);
newA2=zeros(mm2,nn2);
count=0;
done=false;
for ii=k+1:mm+k
    for jj=p+1:nn+p
        tempmat=A2(ii-k:ii+k-1,jj-p:jj+p-1);
        calvec=reshape(tempmat,[m*n 1]);
        level=mean(calvec);
        while ~done
        count=count+1;
        g=calvec>level;
        levelnext=0.5*mean(calvec(g))+0.5*mean(calvec(~g));
        done=abs(level-levelnext)<0.5;
        level=levelnext;
        end
        newA2(ii,jj)=~(A2(ii,jj)>(level-55));% dark object with bright BG, threshold one pixel at each iteration, the calculated threshold is
       %adjusted to minimize false detection
    end
end
newA=newA2(k+1:mm+k,p+1:nn+p);

newA=logical(newA);
thresholded = newA;
