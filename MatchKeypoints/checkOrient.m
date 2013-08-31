function isOriConsistent = checkOrient(oriK1, oriN1, oriK2, oriN2, th)
% computes the difference between the orientation of each matching
% keypoint. The function returns true or false depending on the consistency
% between two keypoint orientation.
%
% Input:
%   oriK1:              orientation of the keypoint in the first image
%   oriN1:              orientation of the neighbor in the first image
%   oriK2:              orientation of the keypoint in the second image
%   oriN2:              orientation of the neighbor in the second image
%   th:                 threshold value to be checked
%
% Output:
%   isOriConsistent:    orientation is consistent or not

if abs(AngleDiff(AngleDiff(oriK1, oriK2), ...
                 AngleDiff(oriN1, oriN2))) < th
    isOriConsistent = 1;
else
    isOriConsistent = 0;
end
