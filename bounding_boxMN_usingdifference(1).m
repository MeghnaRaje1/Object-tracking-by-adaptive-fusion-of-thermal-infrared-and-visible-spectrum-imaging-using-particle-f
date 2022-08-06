function  [difference,propied,size_bb]=bounding_boxMN_usingdifference(meanF,Y_k)

difference=meanF-Y_k;
difference=imcomplement(difference);
imagen=difference;
% imshow(difference);
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
display(propied);
propied(1).BoundingBox(1)=propied(1).BoundingBox(1);%-10;
propied(1).BoundingBox(2)=propied(1).BoundingBox(2);%-10;
propied(1).BoundingBox(3)=propied(1).BoundingBox(3);%+20;
propied(1).BoundingBox(4)=propied(1).BoundingBox(4);%+20;
number=size(propied);
% disp(number);
size_bb=number(1);
% disp('number of bounding box');
% disp(size_bb);

% figure(3);
% imshow(difference);
% hold on
% if  not(isempty(propied))
%           for n=1:size(propied(1),1)
%             rectangle('Position',(propied(n).BoundingBox),'EdgeColor','r','LineWidth',1)
%     
%           end
%            end
% 
% hold off
end

