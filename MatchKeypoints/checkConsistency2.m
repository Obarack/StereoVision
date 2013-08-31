function [kM_IDs isC] = checkConsistency2(matchedKeys, loc1, loc2, N, K, ths)
% For each initial matching, this function checks the N other closest
% matched features in the first image and also checks whether at least K of
% them are consistent with the first match.
%
% Inputs:
%   matchedKeys:Initially found matching keys
%   des1:       keypoint descriptors for the first image
%   des2:       keypoint descriptors for the second image
%   loc1:       keypoint locations for the first image
%   loc2:       keypoint locations for the second image
%   N:          number of closest matched features to be checked.
%   K:          minimum number of matching neighbors that is required to
%               consider the matching being analyzed as correct.
%   ths:        threshold values for consistency checks

% first, get the IDs of the matching keypoints
kM_IDs = find(matchedKeys > 0);

% find the N-closest neighbor for each matched keypoint in the first image
[vals, idx] = findClosestFeatures(matchedKeys, kM_IDs, loc1, N);

% for each of the matched keypoint in the first image, find its neighbors'
% matching keypoints in the second image.
[nID, nMKID] = findNeighMatchKeyID(matchedKeys, idx, kM_IDs, N);

numMatched = length(kM_IDs);
% for each matched keypoint check the consistency by looking at
% a) the difference between their neighbors' orientations,
% b) the scale ratios of each keypoint-neighbor pair in 1st image and
% their corresponding pair in 2nd image.
for i = 1:numMatched
    keyID1 = kM_IDs(i);             % get the ID of the matched keypoint in 1st image
    keyID2 = matchedKeys(keyID1);	% get the ID of the matched keypoint in 2nd image
    locKey1 = loc1(keyID1,:);
    locKey2 = loc2(keyID2,:);
    % check all N-closest neighbors
    for j = 1:N
        nKeyID1 = nID(i,j);         % ID of the neighbor
        nKeyID2 = nMKID(i,j);       % ID of the corresponding keypoint in 2nd image
        % check the orientation
        isOriConsistent(i,j) = checkOrient( locKey1(4), loc1(nKeyID1,4), ...
                                            locKey2(4), loc2(nKeyID2,4), ths(1) );
        % check the scale ratio
        isScaConsistent(i,j) = checkScale( locKey1(3), loc1(nKeyID1,3), ...
                                           locKey2(3), loc2(nKeyID2,3), ths(2) );
        % check the separation of points wrt to scale change
        isSepConsistent(i,j) = checkSep( locKey1(1:2), loc1(nKeyID1,1:2), ...
                                         locKey2(1:2), loc2(nKeyID2,1:2), ...
                                         locKey1(3), loc1(nKeyID1,3), ...
                                         locKey2(3), loc2(nKeyID2,3), ths(3) );
    end
    isConsistent = isOriConsistent(i,:).*isScaConsistent(i,:).*isSepConsistent(i,:);

    if sum(isConsistent) > K
        isC(i) = 1;
    else
        isC(i) = 0;
    end
end

