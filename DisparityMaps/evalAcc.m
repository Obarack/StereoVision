function score = evalAcc(imgT, imgC)
% Scoring function that computes the fraction of correct pixels in imgC
% that are within 1 disparity value (equivalent to 16 values in the scaled
% image) of ground truth.
% Inputs:
%   imgT:           Groung truth image
%   imgC:           Computed disparity image
% Outputs:
%   score:          Calculated score

% don't consider the outer frame
imgC(1:18, :) = 0;          
imgC(end-17:end, :) = 0;  
imgC(:, 1:18) = 0;
imgC(:, end-17:end) = 0;

imgDif = abs(imgT-imgC);        % calculate the difference
% find the pixels that are close enough to ground truth
[r, c, v] = find(imgDif(:) < 17);
% compute the fraction of those correct pixels 
score = length(v)/(size(imgT,1)*size(imgT,2));
