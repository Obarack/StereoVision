%% main
close all
clear all
clc
%% first qeustion
% find stereo correspondances of two images with different window sizes
fileImL = 'imL.jpg';        % file for the left image
fileImR = 'imR.jpg';        % file for the right image

imgL = imread(fileImL);     % read the left image
imgL = double(imgL);      % convert the image from uint8 to double

imgR = imread(fileImR);     % read the right image
imgR = double(imgR);      % convert the image from uint8 to double

dispRange = [0; 15];        % range of the disparity values that is searched over
% calculate disparities with window sizes of 3x3, 5x5, 7x7
winSize = [3, 5, 7];
for i = 1:length(winSize)
    [dispMap, timeTaken] = stereoNCC(imgL, imgR, winSize(i), dispRange);
    dispMapInt = uint8(round(dispMap)*16);
    imshow(dispMapInt);
    imwrite(dispMapInt, ['dispRL', num2str(winSize(i)),'.jpg']);
    i
end

for i = 1:length(winSize)
    [dispMap, timeTaken] = stereoNCCLeft(imgL, imgR, winSize(i), dispRange);
    dispMapInt = uint8(round(dispMap)*16);
    imshow(dispMapInt);
    imwrite(dispMapInt, ['dispLR', num2str(winSize(i)),'.jpg']);
    i
end
%% second question
% compare the calculated disparities with the ground truth
score = zeros(3,1);
winSize = [3, 5, 7];
fileImgTrue = 'trueL.jpg';
imgT = imread(fileImgTrue);         % read the ground truth image
for i = 1:length(winSize)
    fileCalcDisp = ['dispLR', num2str(winSize(i)), '.jpg'];
    imgC = imread(fileCalcDisp);	% read the calculated disparity image   
    score(i) = evalAcc(imgT, imgC);	% calculate the score for each window size
end

%% third question
% improve corresping disparity map by validity checking and filling out the
% invalid pixels by estimating from their neighbouring pixels.
clear all; clc;
countInvalid = zeros(3,1);
winSize = [3, 5, 7];
fileImgTrue = 'trueL.jpg';
imgT = imread(fileImgTrue);   % read the ground truth image
for i = 1:length(winSize)
    fileImL = ['dispLR', num2str(winSize(i)), '.jpg'];
    fileImR = ['dispRL', num2str(winSize(i)), '.jpg'];
    imgL = floor(double(imread(fileImL))./16);	% read the calculated disparity image
    imgR = floor(double(imread(fileImR))./16);	% read the ground truth image
    
    [imgImproved, countInvalid(i)] = validCheck(imgL, imgR);  
    imgScaled = uint8(round(imgImproved)*16);
    imwrite(imgScaled, ['dispLImproved', num2str(winSize(i)), '.jpg']);
    scoreNew2(i) = evalAcc(imgT, imgScaled);
end
%% third question - scoring
% compare the calculated disparities of the improved image with the ground
% truth
scoreNew = zeros(3,1);
winSize = [3, 5, 7];
fileImgTrue = 'trueL.jpg';
imgT = imread(fileImgTrue);         % read the ground truth image
for i = 1:length(winSize)
    fileImpDisp = ['dispLImproved', num2str(winSize(i)), '.jpg'];
    imgImp = imread(fileImpDisp);	% read the calculated disparity image   
    scoreNew(i) = evalAcc(imgT, imgImp);	% calculate the score for each window size
end
