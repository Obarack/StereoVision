% images are previously loaded and saved into .mat files
clear all
clc
imgs = {'sb'; 'cs'; 'lib'};
for j = 1:length(imgs)
    fN = imgs{j};     % file name to be loaded
    load( fN );
    ths = [pi/8 1.5 5];
    %%
    K = 3;
    i = 1;
    % test for different values of N - neighbors to compare for consistency
    for N = 5:20
        [kM_IDs isC] = checkConsistency(matchedKeys, loc1, loc2, N, K, ths);
%         drawMatches(im1, im2, matchedKeys, loc1, loc2, kM_IDs, isC);
        sumIsC(i) = sum(isC);
        i = i + 1;
        length(kM_IDs)
    end
    fh = figure((j-1)*5+1),
    set(fh, 'color', 'white'); % sets the color to white
    p = plot(5:20, sumIsC);
    xlabel('# of neighbors (N)', 'FontSize', 24);
    ylabel('# of Matches', 'FontSize', 24);
    set(gca, 'Box', 'off', 'TickDir', 'out', 'FontSize', 24);
    set(p, 'LineStyle', '-', 'LineWidth', 1.0, 'Color', 'Black');
    set(p, 'Marker', 's', 'MarkerFaceColor', [1 1 1], 'MarkerEdgeColor', [0 0 0], 'MarkerSize', 8.0);
    saveFile = [fN 'N.png'];
    saveas(gcf, saveFile, 'png');
    clear N K saveFile kM_IDs isC sumIsC fh p;
    
    %%
    N = 20;
    i = 1;
    % test for different values of K - minimum neighbors to be consistent
    for K = 2:10
        [kM_IDs isC] = checkConsistency(matchedKeys, loc1, loc2, N, K, ths);
        sumIsC(i) = sum(isC);
        i = i + 1;
        length(kM_IDs)
    end
    % drawMatches(im1, im2, matchedKeys, loc1, loc2, kM_IDs, isC);
    fh = figure((j-1)*5+2),
    set(fh, 'color', 'white'); % sets the color to white
    p = plot(2:10, sumIsC);
    xlabel('Minimum # of neighbors (K)', 'FontSize', 24);
    ylabel('# of Matches', 'FontSize', 24);
    set(gca, 'Box', 'off', 'TickDir', 'out', 'FontSize', 24);
    set(p, 'LineStyle', '-', 'LineWidth', 1.0, 'Color', 'Black');
    set(p, 'Marker', 's', 'MarkerFaceColor', [1 1 1], 'MarkerEdgeColor', [0 0 0], 'MarkerSize', 8.0);
    saveFile = [fN 'K.png'];
    saveas(gcf, saveFile, 'png');
    clear N K saveFile kM_IDs isC sumIsC;
    
    %%
    N = 10;
    K = 3;
    i = 1;
    ths = [pi/8 1.5 5];
    % test for different threshold values for orientation
    for thOri = pi/18:pi/90:pi/6
        ths(1) = thOri;
        [kM_IDs isC] = checkConsistency(matchedKeys, loc1, loc2, N, K, ths);
        sumIsC(i) = sum(isC);
        i = i + 1;
        length(kM_IDs)
    end
    % drawMatches(im1, im2, matchedKeys, loc1, loc2, kM_IDs, isC);
    fh = figure((j-1)*5+3),
    set(fh, 'color', 'white'); % sets the color to white
    p = plot(pi/18:pi/90:pi/6, sumIsC);
    xlabel('Orientation Threshold (radians)', 'FontSize', 24);
    ylabel('# of Matches', 'FontSize', 24);
    set(gca, 'Box', 'off', 'TickDir', 'out', 'FontSize', 24);
    set(p, 'LineStyle', '-', 'LineWidth', 1.0, 'Color', 'Black');
    set(p, 'Marker', 's', 'MarkerFaceColor', [1 1 1], 'MarkerEdgeColor', [0 0 0], 'MarkerSize', 8.0);
    saveFile = [fN 'Ori.png'];
    saveas(gcf, saveFile, 'png');
    clear N K saveFile kM_IDs isC sumIsC;
    
    %%
    N = 10;
    K = 3;
    i = 1;
    ths = [pi/8 1.5 5];
    % test for different threshold values for scale
    for thSca = 1.1:0.1:2.0
        ths(2) = thSca;
        [kM_IDs isC] = checkConsistency(matchedKeys, loc1, loc2, N, K, ths);
        sumIsC(i) = sum(isC);
        i = i + 1;
        length(kM_IDs)
    end
    % drawMatches(im1, im2, matchedKeys, loc1, loc2, kM_IDs, isC);
    fh = figure((j-1)*5+4),
    set(fh, 'color', 'white'); % sets the color to white
    p = plot(1.1:0.1:2.0, sumIsC);
    xlabel('Scale Threshold (ratio)', 'FontSize', 24);
    ylabel('# of Matches', 'FontSize', 24);
    set(gca, 'Box', 'off', 'TickDir', 'out', 'FontSize', 24);
    set(p, 'LineStyle', '-', 'LineWidth', 1.0, 'Color', 'Black');
    set(p, 'Marker', 's', 'MarkerFaceColor', [1 1 1], 'MarkerEdgeColor', [0 0 0], 'MarkerSize', 8.0);
    saveFile = [fN 'Sca.png'];
    saveas(gcf, saveFile, 'png');
    clear N K saveFile kM_IDs isC sumIsC;
    
    %%
    N = 10;
    K = 3;
    i = 1;
    ths = [pi/8 1.5 5];
    % test for different threshold values for separation
    for thSep = 1.1:0.2:5.1
        ths(3) = thSep;
        [kM_IDs isC] = checkConsistency(matchedKeys, loc1, loc2, N, K, ths);
        sumIsC(i) = sum(isC);
        i = i + 1;
        length(kM_IDs)
    end
    % drawMatches(im1, im2, matchedKeys, loc1, loc2, kM_IDs, isC);
    fh = figure((j-1)*5+5),
    set(fh, 'color', 'white'); % sets the color to white
    p = plot(1.1:0.2:5.1, sumIsC);
    xlabel('Separation Threshold (ratio)', 'FontSize', 24);
    ylabel('# of Matches', 'FontSize', 24);
    set(gca, 'Box', 'off', 'TickDir', 'out', 'FontSize', 24);
    set(p, 'LineStyle', '-', 'LineWidth', 1.0, 'Color', 'Black');
    set(p, 'Marker', 's', 'MarkerFaceColor', [1 1 1], 'MarkerEdgeColor', [0 0 0], 'MarkerSize', 8.0);
    saveFile = [fN 'Sep.png'];
    saveas(gcf, saveFile, 'png');
    clear N K saveFile kM_IDs isC sumIsC;
end

