function isPosSepConsistent = checkSep(loc1k, loc1n, loc2k, loc2n, ...
                                       sca1k, sca1n, sca2k, sca2n, th)
% This function checks that the separation of points in each image is
% consistent with the scale change.
%
% Input:
%   loc1k:          location for the keypoint in the 1st image
%   loc1n:          location for the keypoint's neighbor in the 1st image
%   loc2k:          location for the keypoint in the 2nd image
%   loc2n:          location for the keypoint's neighbor in the 2nd image
%   sca1k:          scale of the keypoint in the 1st image
%   sca1n:          scale of the keypoint's neighbor in the 1st image
%   sca2k:          scale of the keypoint in the 2nd image
%   sca2n:          scale of the keypoint's neighbor in the 2nd image
%
% Output:
%   isPosSepConsistent:     return consistent or not.

scaRatio1 = sca1k/sca1n;
scaRatio2 = sca2k/sca2n;

sep1 = sqrt((loc1k(1)-loc1n(1))^2+(loc1k(2)-loc1n(2))^2);
sep2 = sqrt((loc2k(1)-loc2n(1))^2+(loc2k(2)-loc2n(2))^2);

scaleRatio = scaRatio1/scaRatio2;
sepRatio   = sep1/sep2;

if sepRatio > scaleRatio
    if (sepRatio/scaleRatio) < th
        isPosSepConsistent = 1;
    else
        isPosSepConsistent = 0;
    end
else
    if (scaleRatio/sepRatio) < th
        isPosSepConsistent = 1;
    else
        isPosSepConsistent = 0;
    end
end