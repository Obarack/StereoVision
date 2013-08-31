function [dispMap, timeTaken] = stereoNCCLeft(imgL, imgR, winSize, dispRange)
% Compute stereo correspondances of two images by Normalized Cross
% Correlation (NCC)
% Inputs:
%   imgL:           Left image
%   imgR:           Right image
%   winSize:        Window Size
%   dispRange:      Holds minimum and maximum disparities - 2x1
% Outputs:
%   dispMap:        Calculated disparities
%   totTime:        Time taken

%%
[numOfRows, numOfCols] = size(imgL);    % get the image size
dispMap = zeros(numOfRows, numOfCols);  % initialize disparity image
hwin = (winSize-1)/2;                   % half of the window size
borderRow = numOfRows-hwin-dispRange(2);	% decide on upto which row to check
borderCol = numOfCols-hwin-dispRange(2);    % decide on upto which column to check

for i = 1+hwin+dispRange(2):borderRow   % traverse rows
    for j = 1+hwin+dispRange(2):borderCol            % traverse columns
        prevNCC = 0.0;
        highestCorr = dispRange(1);
        normCoefSegL = sum( sum( imgL(i-hwin:i+hwin, j-hwin:j+hwin).^2 ) );
        for curDisp = dispRange(1):dispRange(2)
            % correlation of the left image segment with the right image
            % segment which is shifted by the current disparity value
            corr = sum( sum( imgL(i-hwin:i+hwin, j-hwin:j+hwin) .* ...
                    imgR(i-hwin:i+hwin, j-hwin-curDisp:j+hwin-curDisp) ) );
            % normalization coefficient
            normCoefSegR = sum( sum( imgR(i-hwin:i+hwin, ...
                                    j-hwin-curDisp:j+hwin-curDisp).^2 ) );
            normCoef = sqrt(normCoefSegR*normCoefSegL);
            % calculate the NCC for the given disparity
            currentNCC = corr/normCoef;     
            % check if the correlation is higher than the previous ones, if
            % that is the case then save those values
            if (prevNCC < currentNCC)       
                prevNCC = currentNCC;
                highestCorr = curDisp;
            end
        end
        dispMap(i,j) = highestCorr;
    end
end
