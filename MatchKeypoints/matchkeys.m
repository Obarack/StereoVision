% num = matchkeys(image1, image2)
%
% This function reads two images and their associated keypoints, and then
%   displays lines connecting the keypoints from each image that have
%   a match distance ratio less than distRatio.
%   The arguments image1 and image2 are the file names without the file
%   extensions.
% It returns the number of matches displayed.
%
% Example: matchkeys('scene','book');

function num = matchkeys(image1, image2)

% Load the images and keypoint descriptors and locations
[im1, des1, loc1] = readkeys(image1);
[im2, des2, loc2] = readkeys(image2);

% Only keep matches in which the ratio of angles from nearest to second
%   nearest neighbor is less than this threshold.
distRatio = 0.8;   

% For each descriptor in the first image, select match to second image.
des2t = des2';                 % Precompute matrix transpose
for i = 1 : size(des1,1)
   dotprods = des1(i,:) * des2t;        % Computes vector of dot products
   [vals,indx] = sort(acos(dotprods));  % Sort angles

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   if (vals(1) < distRatio * vals(2))
      matchkeys(i) = indx(1);
   else
      matchkeys(i) = 0;
   end
end

% Create a new image showing the two images side by side.
im3 = appendimages(im1,im2);

% Show a figure with lines joining the accepted matches.
imshow(im3);
hold on;
cols1 = size(im1,2);
for i = 1: size(des1,1)
  if (matchkeys(i) > 0)
    line([loc1(i,2) loc2(matchkeys(i),2)+cols1], ...
         [loc1(i,1) loc2(matchkeys(i),1)], 'Color', 'c');
  end
end
hold off;
num = sum(matchkeys > 0);



