clc
close all

%% This is an example shows how to use assisting image to operate a marker control watershed segmentation of a low SNR image
%% the image is from reconstrcution result of oil droplet hologram with high dynamic range in size and shape.
%% Image courtsey: Johns Hopkins University, Joseph Katz group. V1:4.26.2018
% read grayscale image example
grayscale=imread('Combined_oil.tif');
grayscale_rescale=grayscale./(max(grayscale(:))-min(grayscale(:)))*255;
grayscale_rescale=uint8(grayscale_rescale);
% image enhancement
C0_STA=3.3;
LL_GS=30;
EQGS_STA_SSA=SS_Image_enh2(grayscale_rescale,C0_STA,LL_GS);
% generate binary image
m=200;
n=200;
BW_LO=SS_image_threshold_quick_sliding_Adaptive_intermode(EQGS_STA_SSA(1:2000,1:2000),m,n);
BW_LO=bwareaopen(BW_LO,4);
% generate assiting grayscale image through energy calculation, inspired
% and iterated from Kass 1998 (the Snake algorithm)
Eext = ExternalForceImage2D(double(EQGS_STA_SSA(1:2000,1:2000)),1,2,1,4);
Eext=Eext/(max(Eext(:))-min(Eext(:)));
Eext=uint8(Eext*255);
% marker control watershed segmentation
segmented_binary= SS_Assisted_watershed_segmenting (BW_LO,Eext);
%% check results
figure
imshow(grayscale);
title('Original grayscale image');
figure
imshow(grayscale);
hold on
% measure and plot the best approximation ellipses/circles, please refer to
% Karn et al. 2015 Chemical Engineering Science for details
[small_matrix,small_plot] = SS_blob_measurement_plot(segmented_binary,'b');
title('Segmentation result');