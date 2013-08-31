% matchkeys('images/library','images/library2')
clear all
clc
close all
imgs = {'sb'; 'cs'; 'lib'};    
i = 1;
for j = 1:length(imgs)
    fN = imgs{j};     % file name to be loaded
    load( fN );
    ths = [0.25 1.4 3.8; 0.2 1.3 1.3; 0.55 1.6 2.5];
    %%
    N = 10;
    K = 3;
    [kM_IDs isC] = checkConsistency2(matchedKeys, loc1, loc2, N, K, ths(j,:));
    sumIsC(i) = sum(isC)
    figure,
    drawMatches(im1, im2, matchedKeys, loc1, loc2, kM_IDs, isC);
    i = i + 1;
    length(kM_IDs)
end

