%% main
close all
clear all
clc
%% first qeustion
% find stereo correspondances of two images with different window sizes
fileImL = 'imL.jpg';        % file for the left image
fileImR = 'imR.jpg';        % file for the right image

imgL = imread(fileImL);     % read the left image
imgL = double(imgL);        % convert the image from uint8 to double

imgR = imread(fileImR);     % read the right image
imgR = double(imgR);        % convert the image from uint8 to double

fileImgTrue = 'trueL.jpg';
imgT = imread(fileImgTrue);	% read the ground truth image

dispRange = [0; 15];        % range of the disparity values that is searched over
% calculate disparities with window sizes of 3x3, 5x5, 7x7
winSize = [3, 5, 7];
for i = 1:length(winSize)
    % NCC for right image
    dispMapR = stereoNCCRight(imgL, imgR, winSize(i), dispRange);
    imgDispR = uint8(round(dispMapR)*16);
%     imwrite(imgDispR, ['dispRL', num2str(winSize(i)),'.jpg']);
%     scoreR(i) = evalAcc(imgT, imgDispR);	% calculate the score for each window size
    % NCC for left image
    dispMapL = stereoNCCLeft(imgL, imgR, winSize(i), dispRange);
    imgDispL = uint8(round(dispMapL)*16);
%     imwrite(imgDispL, ['dispLR', num2str(winSize(i)),'.jpg']);
    scoreL(i) = evalAcc(imgT, imgDispL);	% calculate the score for each window size
    % find the invalid pixels by validity chekcing and try to make an
    % estimation for those pixels in order to improve the result
    [imgImproved, countInvalid(i)] = validCheck2(dispMapL, dispMapR);
    imgScaled = uint8(round(imgImproved)*16);
% 	imwrite(imgScaled, ['dispLImproved', num2str(winSize(i)), '.jpg']);
    scoreLImp(i) = evalAcc(imgT, imgScaled);
end
