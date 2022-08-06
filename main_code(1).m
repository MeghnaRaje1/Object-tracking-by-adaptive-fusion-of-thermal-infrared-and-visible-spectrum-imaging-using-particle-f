clc;
clear all;
close all;

path1='G:\project\phddat\mdv\';                    %visible frames
TV=dir(strcat(path1,'**\*.bmp'));   %directory
filenameV=sortrows({TV.name}');
[m,n]=size(filenameV);


path2='G:\project\phddat\mdt\';                     %thermal frames
TT=dir(strcat(path2,'**\*.bmp'));    %directory
filenameT=sortrows({TT.name}');
[m,n]=size(filenameT);

%mean background

calsum=0;
for k=1:10 % 245
    
    V=filenameV{k,1};  %visible frames reading
    b=char(V);
    imgv2=double(imread([path1,b]));
    calsum=calsum+imgv2;
end

calsum1=calsum/10;  %245;
calsum1=uint8(calsum1);
meanV=calsum1;


calsum=0;
for k=1:10
    T=filenameT{k,1};  %thermal frames reading
    b=char(T);
    imgt2=double(imread([path2,b]));
    calsum=calsum+imgt2;
end

calsum1=calsum/10;
meanT=uint8(calsum1);


%  meanT=imread('E:\BE project\phddat\t\img_0001.bmp');
%  meanV=imread('E:\BE project\phddat\r\img_0001.bmp');


%% Frame selection
propied_excel=[];
t=[];
v=[];
Npop_particles=5000;
Xstd_pos = 0;     % variation of position noise - gaussian %set by trial and error
Xstd_vec = 2;      % variation of velocity noise - gaussian
F_update = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];
Xtd_de=50;

Npix_resolution=[448,324];
first_frame=465;
StoreDrive = 'G:\project\Testing\final_data_with_BoundingBox';
FolderName = 'mdv';
for k3 =465:556
    
    disp('-----------------------');
    disp(k3);
    
    %SSIM calculation
    T2=filenameT{k3,1};
    hT=char(T2);
    Thermal_frame=imread([path2,hT]);
    [ssimT,mapT] = ssim(Thermal_frame,meanT);
    mapT=mean(mapT,3);
    
    
    V2=filenameV{k3,1};
    hV=char(V2);
    Visible_frame=imread([path1,hV]);
    [ssimV,mapV] = ssim(Visible_frame,meanV);
    mapV=mean(mapV,3);
    %disp('Thermal SSIM');
    %disp(ssimT);
    t=[t ssimT];
    horzcat(t);
    %disp('Visible SSIM');
    %disp(ssimV);
    v=[v ssimV];
    v=vertcat(v);
    
    if (ssimT>ssimV)                %modality selection
        disp('Thermal Modality selected')
        th=0.19;
        Y_k=Thermal_frame;
        meanF=meanT;
        ssim_val=ssimT;
        ssim_map=mapT;
        %bounding box using ssim
        [diference,propied]= bounding_box(mapV,Npix_resolution);
        %        if(k3==350)
        %         [difference,propied,size_bb]=bounding_boxMN_usingdifference(meanF,Y_k);
        %        end
        
        %Bimodal fusion
        alpha=(ssimT/(ssimT+ssimV));
        
        
    else
        disp('Visible Modality selected');
        th=0.09;
        Y_k=Visible_frame;
        meanF=meanV;
        ssim_val=ssimV;
        ssim_map=mapV;
        [diference,propied]=bounding_box(ssim_map,Npix_resolution);
        %         if(k3==728)
        %         [difference,propied,size_bb]=bounding_boxMN_usingdifference(meanF,Y_k);
        %         end
        
        %Bimodal fusion
        alpha=(ssimT/(ssimT+ssimV));
        
        
    end
    Bssim=(alpha*(mapT))+((1-alpha)*mapV);
    %STEP 1
    if(k3==first_frame)
        W=create_weight(Npop_particles); %Creating particles at initial frame
        Win=W;
        X=create_particle(propied(2),Npop_particles);
        X=round(X);
        X_in=X;
    end
    
    %STEP 2
    X= update_particle(F_update, Xstd_pos, Xstd_vec, X); %prediction
    X_up=X;
    
    
    for i=1:Npop_particles
        x=abs(round(X(2,i)));
        y=abs(round(X(1,i)));
        if(x<Npix_resolution(1) && y<Npix_resolution(2))
            ssim_Particle(i)=Bssim(y,x);
        end
    end
    
    
    %STEP 3-Measurement step - likelihood calculation
    L = likelihood(propied,ssim_val,ssim_map,ssim_Particle, X, Y_k);
    %     figure,plot(L);
    
    %STEP 4-Evaluation of importance weight
    [W]=importance_weight(W,L,Npop_particles);
    W_imp=W;
    
    %STEP 5-Resampling
    propied_excel_centroid=[];
    propied_excel_box=[];
    [W,X,propied_re]= resample_particles(X ,W,L,Npop_particles,Npix_resolution);
    if  (isempty(propied_re))
        display('**********************88');
        display(k3);
        propied_excel_centroid=[propied_excel_centroid ;[0,0] ];
        propied_excel_box=[propied_excel_box ;[0,0,0,0] ];
    else
       propied_excel_centroid=[propied_excel_centroid ;propied_re.Centroid ];
        propied_excel_box=[propied_excel_box ;propied_re.BoundingBox]; 
    end
    
    Wre=W;
    X_re=X;
    
    %Showing Particles
   
    
    figure(5)
    imshow(Y_k)
    title('+++ Showing Particles +++')
    
    hold on
    plot(X(2,:),X(1,:), 'g.');
    hold off
    
    
    hold on
    if  not(isempty(propied_re))
        for n=1:size(propied_re(1),1)
            rect= rectangle('Position',propied_re(n).BoundingBox,'EdgeColor','b','LineWidth',1.5);
             display(propied_re.BoundingBox);
            
        end
    end
    hold off
    drawnow
    fig=figure(5);
    frame = getframe(fig);
    im = frame2im(frame);
    
    ImgStoreName = sprintf('%s_%04d.bmp',FolderName,k3);
    ImgStoreName = fullfile(StoreDrive,FolderName,ImgStoreName);
    imwrite(im,ImgStoreName);
end