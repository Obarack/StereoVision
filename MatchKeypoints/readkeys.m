% [image, keyDescriptors, keyVectors] = readkeys(imageName)
%
% This function reads an image and its associated SIFT keypoints.
%
% The argument imageName gives the file name without its extensions.
%   The image is read from the PGM format file imageName.pgm while the
%   keypoints are read from imageName.key.
%
% readkeys returns the following 3 arguments:
%    image: the image array in double format
%    keyDescriptors: a K-by-128 matrix, where each row gives a descriptor
%         for one of the K keypoints.  The descriptor is a vector of 128
%         values with unit length.
%    keyVector: K-by-4 matrix, in which each row has the 4 values specifying
%         a keypoint (row, column, scale, orientation).  The orientation
%         is in the range [-PI, PI] radians.

function [image, keyDescriptors, keyVectors] = readkeys(imageName)

% Load the image
image = imread([imageName '.jpg']);

% Open the key file and check its header
file = fopen([imageName '.key'], 'r');
if file == -1
    error('Could not open key file.');
end
[header, count] = fscanf(file, '%d %d', [1 2]);
if count ~= 2
    error('Invalid key file beginning.');
end
num = header(1);  % Number of keypoints
len = header(2);
if len ~= 128
    error('Keypoint descriptor length invalid (should be 128).');
end

keyVectors = [];
keyDescriptors = [];

for i = 1:num
    [vector, count] = fscanf(file, '%f', [1 4]); %row col scale ori
    if count ~= 4
        error('Invalid keypoint file format');
    end
    keyVectors = [keyVectors; vector]; % adds a new row
    
    [descriptor, count] = fscanf(file, '%f', [1 len]);
    if (count ~= 128)
        error('Invalid keypoint file value.');
    end
    % Normalize each input vector to unit length.
    descriptor = descriptor / sqrt(sum(descriptor.^2));
    keyDescriptors = [keyDescriptors; descriptor];
end
fprintf('Read %d keypoints.\n', num);
fclose(file);

