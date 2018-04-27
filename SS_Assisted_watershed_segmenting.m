function [segmented_binary] = SS_Assisted_watershed_segmenting (binaryIM,assistingIM)
%% Marker control watershed segmentation for binary image with low SNR, the marker generation is through local extended H-minima
%% of the assisted image. This algorithm is inspired and iterated from Gonzalez and Woods 2008.

BW=medfilt2(binaryIM,[2,2]);
Pre_marker=imextendedmin(assistingIM,4,8);
Pre_marker=imfill(Pre_marker,'holes');
BW=imfill(BW,'holes');
Image_marker=Pre_marker.*BW;


Lim=watershed(bwdist(Image_marker));
em=Lim==0;
f2=~em.*BW;
segmented_binary=logical(f2);

end
