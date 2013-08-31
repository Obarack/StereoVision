function [nID, nMKID] = findNeighMatchKeyID(matchedKeys, idx, kM_IDs, N)
% for each matched keypoint in the first image, this funciton finds 
% neighbors' matching keypoint IDs in the second image.
% 
% Input:
%   matchedKeys:    vector containing the matching keys.
%
% Output:
%   nID:            ids of the neighbors for each matched keypoint in the 
%                   first image.
%   nMKID:          matching keypoint ids in the second image for each 
%                   neighbor of a keypoint in the first image.

matchFeatLen = length(kM_IDs);
nID = zeros(matchFeatLen, N);
nMKID = zeros(matchFeatLen, N);
for i = 1:matchFeatLen
    closestN = idx(i, 1:N);
    % for each feature in image 1, get the IDs of N-closest features and
    % find their corresponding features in the second image
    for j = 1:N
        nID(i, j) = kM_IDs(closestN(j));
        nMKID(i, j) = matchedKeys(nID(i,j));
    end
end
