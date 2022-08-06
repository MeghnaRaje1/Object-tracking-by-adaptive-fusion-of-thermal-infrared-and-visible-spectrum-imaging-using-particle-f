image_names = {'img_0460.bmp', 'img_0461.bmp', 'img_0462.bmp','img_0463.bmp'};

 vid=VideoReader('G:\project\phddat\cdv1\video.avi');
 numFrames = vid.NumberOfFrames;
 n=numFrames;
 for i = 1:n
 frames = read(vid,i);
 imwrite(frames,['Image' int2str(i), '.jpg']);
 im(i)=image(frames);
 end