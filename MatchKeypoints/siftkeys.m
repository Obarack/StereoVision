% siftkeys(imageFile)
%
% This function reads an image and writes its SIFT keypoints to a file.
% It uses SIFT binaries compiled for either Linux or Windows, and will not
%   run on other architectures such as Macs.
%
function siftkeys(imageFile)

% Load image
image = imread([imageFile '.jpg']);

% If you do not have the Image Processing Toolbox, you can leave out the
%   following lines as long as you input grayscale images.
if length(size(image)) > 2
   image = rgb2gray(image);
end

[rows, cols] = size(image); 

% Convert into PGM imagefile, readable by "keypoints" executable
f = fopen('tmp.pgm', 'w');
if f == -1
    error('Could not create file tmp.pgm.');
end
fprintf(f, 'P5\n%d\n%d\n255\n', cols, rows);
fwrite(f, image', 'uint8');
fclose(f);

% Call keypoints executable
if isunix
    command = '!./siftLinux ';
else
    command = '!siftWin32 ';
end
outputFile = [imageFile '.key'];
command = [command ' <tmp.pgm >' outputFile];
eval(command);

fprintf('Output SIFT keypoints in file %s\n', outputFile);

