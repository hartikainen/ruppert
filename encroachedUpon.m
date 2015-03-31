function [ encroached ] = encroachedUpon( s, V )
%ENCROACHEDUPON Checks if the segment s is encroached by any vertxed v in V
%   Detailed explanation goes here
    end_pts = V(:, s)';
    d = pdist(end_pts); % note the ' here.
    mid_pt = sum(end_pts, 2) / 2; % mid = [(x1 + x2)/2, (y1 + y2)/2]

    encroached = any(pdist2(V(:, setdiff(1:size(V, 2), s))', mid_pt') < d/2);
end
