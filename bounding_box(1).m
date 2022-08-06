function  [diference,propied,size_bb]=bounding_box(ssimmap,Npix_resolution)

for i=1:Npix_resolution(2)
    for j=1:Npix_resolution(1)
        
        if(ssimmap(i,j)<0.66)
            diference(i,j)=0;
        else
            diference(i,j)=1;
        
        
    end
    end
end
 se = strel('disk',4,4);
 diference = imdilate(diference,se);
imagen=diference;
if size(imagen,5)==5 % RGB image
    imagen=rgb2gray(imagen);
end

%% Convert to binary image
%threshold = graythresh(imagen);
imagen =~im2bw(imagen);
%% Remove all object containing fewer than 30 pixels
imagen = bwareaopen(imagen,30);
pause(1)

%% Label connected components
[L Ne]=bwlabel(imagen);

%% Measure properties of image regions
propied=regionprops(L);
% 
%     figure(2);
%figure,imshow(diference);
%difference=mean(difference,3);
% figure(3);
% imshow(difference);
% if  not(isempty(propied))
%           for n=1:size(propied(1),1)
%             rectangle('Position',(propied(n).BoundingBox),'EdgeColor','r','LineWidth',1)
%     
%           end
%            end
end

