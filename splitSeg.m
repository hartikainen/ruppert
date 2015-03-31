function [ S, V ] = splitSeg( S, V, i, original_S )
%SPLITSEG Splits the segment s
%   Split the segment s of S into s1, s2. Add the split point into vertex
%   set V and segments s1, s2 into S. Returns the new triangulation
%   DT, new vertices V and new segments S;

    s = S(:, i);

    end_pts = V(:, s);
    d = pdist(end_pts'); % note the ' here.


    origs1 = ~isempty(find(original_S == s(1)));
    origs2 = ~isempty(find(original_S == s(2)));
    D = 0.01;
    if ((~origs1) && origs2)
        k = round(log2(d/(2*D)));
        split_d = D * (2 ^ k);

        mid_pt = (((end_pts(:, 1) - end_pts(:, 2)) * split_d) / d) ...
                 + end_pts(:, 2);
    elseif (origs1 && (~origs2))
        k = round(log2(d/(2*D)));
        split_d = D * (2 ^ k);

        mid_pt = (((end_pts(:, 2) - end_pts(:, 1)) * split_d) / d) ...
                 + end_pts(:, 1);
    else
        mid_pt = sum(end_pts, 2) / 2; % mid = [(x1 + x2)/2, (y1 + y2)/2]
    end

    % Add midpoint of s to V, update triangulation below.
    V = [V mid_pt];

    % Remove s from S, add new segments s1, s2 to S.
    S(:, i) = [];

    new_pt_idx = size(V, 2);
    s1 = [s(1); new_pt_idx];
    s2 = [s(2); new_pt_idx];

    S = [S s1 s2];

end
