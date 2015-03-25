function [X, Y, S] = squareBound(X, Y, S, k)
%SQUAREBOUND Summary of this function goes here
%   Detailed explanation goes here

% Find the extremes.
xmin=min(X); xmax=max(X); xmid = (xmax + xmin) / 2;
ymin=min(Y); ymax=max(Y); ymid = (ymax + ymin) / 2;

width = xmax-xmin;
height = ymax-ymin;

span = k * max(width, height) / 2;

Bxmin = xmid - span;
Bxmax = xmid + span;
Bymin = ymid - span;
Bymax = ymid + span;

BX = [Bxmin Bxmax Bxmin Bxmax];
BY = [Bymin Bymin Bymax Bymax];
BS = [1 1 2 3; 2 3 4 4] + length(S);

X = [X BX];
Y = [Y BY];
S = [S BS];

end

