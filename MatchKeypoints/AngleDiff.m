function diffAngle = AngleDiff(angle1, angle2)
% This function takes two angles in radians and returns the difference
% between them again in radians.
%
% Inputs:
%   angle1:     first angle
%   angle2:     second angle to be subtracted from the first one
%
% Outputs:
%   diffAngle:  difference between 2 angles in radians.
%
% Example: AngleDiff(1.12, 3.02);

diffAngle = mod((angle1 + pi -  angle2), 2*pi) - pi;

% absa = (angle1 - angle2);
% diffAngle = min((2 * pi) - absa, absa);