function [Enhanced] = SS_Image_enh2(grayscaleIM,C0_STA,LL_GS)
%% Image enhancement through equlization and pixel streching, inspired and iterated from Toloui and Hong 2015. V1:4.26.2018
ave=mean(double(grayscaleIM(:)));
sdev=std(double(grayscaleIM(:)));
alpha=(mean(ave(:))-C0_STA*mean(sdev(:)));
beta=255/(2*CO_STA*mean(sdev(:)));
Enhanced = ((grayscaleIM-alpha).*beta)+LL_GS;
ind1 =  Enhanced(:) > 255 ;
ind2 =  Enhanced(:) < 0;
Enhanced(ind1) = 255;
Enhanced(ind2) = 0;
end
