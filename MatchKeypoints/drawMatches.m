function drawMatches(im1, im2, matchedKeys, loc1, loc2, kM_IDs, isC)
im3 = appendimages(im1,im2);

% Show a figure with lines joining the accepted matches.
imshow(im3);
hold on;
cols1 = size(im1,2);
for i = 1:length(kM_IDs)
    if isC(i)
        idx = kM_IDs(i);
        line([loc1(idx,2) loc2(matchedKeys(idx),2)+cols1], ...
            [loc1(idx,1) loc2(matchedKeys(idx),1)], 'Color', 'c');
    end
end
hold off;