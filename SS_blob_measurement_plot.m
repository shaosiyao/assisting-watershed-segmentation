function [small_matrix,small_plot] = SS_blob_measurement_plot(bw,str)
CC2 = bwconncomp(bw,4);
L2 = labelmatrix(CC2);
b = regionprops(L2, 'Area', 'Perimeter','Centroid');
perim = cat(1,b.Perimeter);%idx0 = find(perim==0);perim(idx0)=[];
area = cat(1,b.Area);%area(idx0)=[];
centers = cat(1,b.Centroid);%centers(idx0,:)=[];
radii = perim/(2*pi) ;
ro  = perim ./ sqrt(4*pi.*area);
idx = (1:size(ro,1))';
idx3 = find(ro>=0.899 & ro<=1.111);% Use regionprops to fit ellipses - yellow
equ_dia=sqrt(radii(idx3).*radii(idx3))*2;
eccen=zeros(length(radii(idx3)),1);
idx4 = setdiff(idx,idx3);
bw1 = ismember(L2,idx3);
bw4 = ismember(L2,idx4);
small_plot = 1;
if ~isempty(idx3)
matrix1 = [centers(idx3,1) centers(idx3,2) radii(idx3) radii(idx3) equ_dia eccen];
small_plot = viscircles(centers(idx3,:), radii(idx3), 'Linewidth',1,'Edgecolor',str);%,'DrawBackGroundCircles','off');
else
    matrix1 = [];
end

CC = bwconncomp(bw4,4);
s = regionprops(CC, 'Orientation', 'MajorAxisLength', ...
    'MinorAxisLength', 'Centroid');
phi = linspace(0,2*pi,50);
cosphi = cos(phi);
sinphi = sin(phi);
centers2 = cat(1,s.Centroid);
Dmaj = cat(1,s.MajorAxisLength);
Dmin = cat(1,s.MinorAxisLength);
equ_dia=sqrt(Dmaj.*Dmin);
eccen=sqrt(1-(Dmin./Dmaj).^2);
matrix2 = [];
if ~isempty(centers2)
matrix2 = [centers2(:,1) centers2(:,2) Dmaj/2 Dmin/2 equ_dia eccen];
end

for k = 1:length(s)
    xbar = s(k).Centroid(1);
    ybar = s(k).Centroid(2);

    a = s(k).MajorAxisLength/2;
    b = s(k).MinorAxisLength/2;

    theta = pi*s(k).Orientation/180;
    R = [ cos(theta)   sin(theta)
         -sin(theta)   cos(theta)];

    xy = [a*cosphi; b*sinphi];
    xy = R*xy;

    x = xy(1,:) + xbar;
    y = xy(2,:) + ybar;

    small_plot = plot(x,y,str,'LineWidth',1);

    hold on
end

small_matrix = vertcat(matrix1,matrix2);

