function  [propied_up]=bounding_box_updated(X_up,Npop_particles,Npix_resolution)
k=0;
diference2 = zeros(Npix_resolution(2),Npix_resolution(1));

min_y = min(X_up(1,:))-2;
max_y = max(X_up(1,:))+2;
min_x = min(X_up(2,:))-2;
max_x = max(X_up(2,:))+2;

% display(min_x);
% display(min_y);
% display(max_x);
% display(max_y);

for i=1:Npix_resolution(2)
    for j = 1:Npix_resolution(1)
        I = i < max_y && i > min_y;
        J = j < max_x && j > min_x;
        if(I && J)
           diference2(i,j) = 1;
        else
           diference2(i,j) = 0;
        end
    end
end
% figure, imshow(diference2);
imagen = diference2;
%% Convert to binary image
% %threshold = graythresh(imagen);
% imagen =~im2bw(imagen);
%% Remove all object containing fewer than 30 pixels
imagen = bwareaopen(imagen,30);
pause(1)

%% Label connected components
[L Ne]=bwlabel(imagen);

%% Measure properties of image regions
propied_up=regionprops(L);
number=size(propied_up);

size_bb=number(1);

hold on
%     figure(2);
% imshow(diference);
% difference=mean(difference,3);
% figure(3);
% if  not(isempty(propied_up))
%           for n=1:size(propied_up(1),1)
%             rectangle('Position',(propied_up(n).BoundingBox),'EdgeColor','b','LineWidth',2)
%     
%           end
%            end
 end
