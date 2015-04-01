function [ encroached ] = encroachedUpon( s, DT )
%ENCROACHEDUPON Checks if the segment s is encroached by any vertxed v in V
%   Detailed explanation goes here
    end_pts = DT.Points(s, :);
    d = pdist(end_pts); % note the ' here.
    mid_pt = sum(end_pts) / 2; % mid = [(x1 + x2)/2, (y1 + y2)/2]

    encroached = any(pdist2(DT.Points(setdiff(1:size(DT.Points, 1), s), :), mid_pt) < d/2);
end
