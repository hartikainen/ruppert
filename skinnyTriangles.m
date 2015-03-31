function [ skinnys ] = skinnyTriangles( TRI, V, alpha )
%SKINNYTRIANGLES Summary of this function goes here
%   Detailed explanation goes here
    x = V(1,:);
    y = V(2,:);
    for tridx=1:size(TRI, 1)
        points = V(:, TRI(tridx, :));
        a(tridx, :) = triangleAngles(points);
    end
    
    mins = min(a, [], 2);
    skinny_idx = (mins < alpha);
    skinnys = TRI(skinny_idx, :);
end

