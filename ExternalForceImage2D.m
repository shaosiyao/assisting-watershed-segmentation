function Eextern = ExternalForceImage2D(I,Wline, Wedge, Wterm,Sigma)
% Eextern = ExternalForceImage2D(I,Wline, Wedge, Wterm,Sigma)
% 
% inputs, 
%  I : The image
%  Sigma : Sigma used to calculated image derivatives 
%  Wline : Attraction to lines, if negative to black lines otherwise white
%          lines
%  Wedge : Attraction to edges
%  Wterm : Attraction to terminations of lines (end points) and corners
%
% outputs,
%  Eextern : The energy function described by the image
%
% Function is written by D.Kroon University of Twente (July 2010)

Ix=double(ImageDerivatives2D(I,Sigma,'x'));
Iy=double(ImageDerivatives2D(I,Sigma,'y'));
Ixx=double(ImageDerivatives2D(I,Sigma,'xx'));
Ixy=double(ImageDerivatives2D(I,Sigma,'xy'));
Iyy=double(ImageDerivatives2D(I,Sigma,'yy'));


% Eline = imgaussian(I,Sigma);
% Eterm = (Iyy.*Ix.^2 -2*Ixy.*Ix.*Iy + Ixx.*Iy.^2)./((1+Ix.^2 + Iy.^2).^(3/2));
% Eedge = sqrt(Ix.^2 + Iy.^2); 
Eline = imgaussian(I,Sigma);
Eterm = (Iyy.*Ix.^2 -2*Ixy.*Ix.*Iy + Ixx.*Iy.^2)./((1+Ix.^2 + Iy.^2).^(3/2));
Eedge = sqrt(Ix.^2 + Iy.^2); 
Eextern= (Wline*Eline - Wedge*Eedge -Wterm * Eterm); 
% Eextern=Eline;
% Eextern=Eterm;
% Eextern=Eedge;


