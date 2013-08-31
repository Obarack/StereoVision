function isScConsistent = checkScale(scK1, scN1, scK2, scN2, th)
% The function computes the ratio between the scale of a keypoint and its
% neighbor for both images, and also checks their consistency.
%
% Input:
%   scK1:               scale of the keypoint in the first image
%   scN1:               scale of the neighbor of the keypoint in the first
%                       image
%   scK2:               scale of the keypoint in the second image
%   scN2:               scale of the neighbor of the keypoint in the second
%                       image
%   th:                 threshold value to be checked
%
% Output:
%   isScConsistent:     scale is consistent or not

scRatio1 = scK1/scK2;
scRatio2 = scN1/scN2;
if scRatio1 > scRatio2
    if (scRatio1/scRatio2) < th
        isScConsistent = 1;
    else
        isScConsistent = 0;
    end
else
    if (scRatio2/scRatio1) < th
        isScConsistent = 1;
    else
        isScConsistent = 0;
    end
end