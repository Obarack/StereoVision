function [imgL, countInvalid] = validCheck2(imgL, imgR)
% validity check: images are matched in both directions, and pixels are
% marked invalid when the directions disagree. Then fill invalid pixels
% with the estimated values by setting them to the disparity of the nearest
% valid pixel.
% Inputs:
%   imgL:           disparity map based on left image
%   imgR:           disparity map based on right image
% Outputs:
%   imgL:           new image in which invalid pixels exchanged with
%                   estimated disparities
%   countInvalid:   number of invalid pixels

% don't consider the outer frames of the images
frameSize = 18;
imgL(1:frameSize, :) = 0;
imgL(end-frameSize+1:end, :) = 0;
imgL(:, 1:frameSize) = 0;
imgL(:, end-frameSize+1:end) = 0;

imgR(1:frameSize, :) = 0;
imgR(end-frameSize+1:end, :) = 0;
imgR(:, 1:frameSize) = 0;
imgR(:, end-frameSize+1:end) = 0;

[nr, nc] = size(imgL);
countInvalid = 0;
for i = frameSize+1:nr
    for j = frameSize+1:nc
        dispL = imgL(i,j);
        % check whether the given pixel is on the outer frame or not
        % if not continue validity checking, otherwise skip
        if j-dispL > frameSize
            dispR = imgR(i,j-dispL);
            diff = abs( dispR - dispL );
            if diff > 1
                countInvalid = countInvalid+1;
                imgL(i,j) = -1;     % mark the pixel as invalid
                invRC(countInvalid,:) = [i, j];
            end
        end
    end
end

% now find the nearest valid pixel in order to assign it to the
% corresponding invalid pixel.
for i = 1:countInvalid
    % get the row and column of the invalid pixel
    r = invRC(i,1);
    c = invRC(i,2);
    found = 0;
    % look to the neighbours of the invalid pixel
    for j = 1:frameSize-1
        for m = -j:j
            for k = -j:j
                % find the nearest neighbour who has a valid disparity value,
                % and assign it to the invalid pixel
                if m == j || m == -j || k == j || k == -j
                    if imgL(r+k, c+m) > 0         % look right
                        imgL(r, c) = imgL(r+k, c+m);
                        found = 1;
                    end
                end
                if found == 1, break; end
            end
            if found == 1
                break;
            end
        end
        if found == 1
            break;
        end
    end
end
