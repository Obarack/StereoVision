function [distVal, idxs] = findClosestFeatures(keysMatched, kM_ids, loc1, N)
% This function finds the N closest features (in terms of location) for a
% given feature.

BIGNUM = 10^8;
lenKeys = length(kM_ids);
distKeys = zeros(lenKeys);
distVal = [];
idxs = [];
for i = 1:lenKeys
    for j = 1:lenKeys
        if i == j
            distKeys(i, j) = BIGNUM;    % set its distance to itself to a big number
        else
            % calculate the distance between two key features on image 1.
            % do not take the squareroot because only relative distance is important. 
            distKeys(i, j) = sum((loc1(kM_ids(i), 1:2) - loc1(kM_ids(j), 1:2)).^2);
        end
    end
    % sort the distances
    % vals: keeps the distances of other key features on the 1st image to
    %       itself
    % idx:  index of the sorted distance values. This index value corresponds
    %       to the index of the feature on the initial location vector.
    [vals, idx] = sort(distKeys(i,:));
    distVal = [distVal; vals];
    idxs = [idxs; idx];
%     keyID = keysMatched( kM_ids(i) );   % idx of the matching feature on the 2nd image.
end
