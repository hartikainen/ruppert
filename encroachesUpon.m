function [ encroached_idx ] = encroachesUpon( p, S, points )
%ENCROACHESUPON Return the segments s in S echroached upon point p
%   Detailed explanation goes here
    encroached_idx = [];
    for i=1:size(S, 2)
        s = S(:, i);
        end_pts = points(s, :);
        d = pdist(end_pts); % note the ' here.
        mid_pt = sum(end_pts) / 2;
        if (pdist2(p, mid_pt) < d/2)
            encroached_idx(end+1) = i;
        end
    end

end
