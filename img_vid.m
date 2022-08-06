fileNames = dir(fullfile('G:\project\phddat\cdv1\','*.bmp'));
N = length(fileNames);
for k = 1:N
  filename = fileNames(k).name;
  C(:,:,k) = imread(filename);
end
mplay(C)