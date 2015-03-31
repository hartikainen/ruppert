function [ TRI, V ] = ruppertTriangulation( points, segments, alpha )
%RUPPERTTRIANGULATION Triangulation by Ruppert algorithm.
%   Creates a triangulation for the given area, using Ruppert's
%   algorithm.

% argument 3 for the square side
[X, Y, S] = squareBound(points.x, points.y, segments, 3);


V = [X;Y];
TRI = delaunay(V');

while (true)
    i=1;
    encroached_upon_s = false;
    angles_lt_alpha = false;

    clf;
    triplot(TRI, V(1, :), V(2, :));
    hold on;
    % Plot the vertices (red dots)
    plot(V(1, :), V(2, :), 'or');
    % Plot the original segments
    plot([points.x points.x(1)], [points.y points.y(1)], 'k', 'LineWidth', 3);    
    v_size = size(V, 2);

    for i=1:size(S, 2)
        s = S(:, i);
        end_pts = V(:, s);
        d = pdist(end_pts'); % note the ' here.
        mid_pt = sum(end_pts, 2) / 2; % mid = [(x1 + x2)/2, (y1 + y2)/2]

        if any(pdist2(V(:, setdiff(1:v_size, s))', mid_pt') < d/2)
            enroached_upod_s = true;
            V = [V mid_pt];
            TRI = delaunay(V');
            % Remove s from S
            % Add the two halves s1 and s2 to S.
            new_pt_idx = size(V, 2);
            s1 = [s(1); new_pt_idx];
            s2 = [s(2); new_pt_idx];
            S(:, i) = s1;
            % [s';new_pt_idx new_pt_idx]
            S(:, end+1) = s2;

            plot(mid_pt(1), mid_pt(2), 'ok');
            plot(end_pts(1, :), end_pts(2, :), 'r', 'LineWidth', 3);
            % draw the circle
            plot((d/2) * cos(0:pi/50:2*pi) + mid_pt(1), (d/2) * sin(0:pi/50:2*pi) + mid_pt(2));
        end
    end

    skinny_TRI = skinnyTriangles(TRI, V, alpha);
    angles_lt_alpha = size(skinny_TRI, 1) > 0;

    if (~(encroached_upon_s || angles_lt_alpha))
        break;
    end
    % Pick only the first triangle to be split. This is how it's done in
    % the paper without enhancement.
    tr = triangulation(skinny_TRI(1, :), V');
    [p, r] = circumcenter(tr);
    p_enroaches = false;
    
    for i=1:size(S, 2)
        s = S(:, i);
        end_pts = V(:, s);
        d = pdist(end_pts'); % note the ' here.
        mid_pt = sum(end_pts, 2) / 2;
        
        if (pdist2(p, mid_pt') < d/2)
            p_enroaches = true;
            V = [V mid_pt];
            TRI = delaunay(V');
            % Remove s from S
            % Add the two halves s1 and s2 to S.
            new_pt_idx = size(V, 2);
            s1 = [s(1); new_pt_idx];
            s2 = [s(2); new_pt_idx];
            S(:, i) = s1;
            % [s';new_pt_idx new_pt_idx]
            S(:, end+1) = s2;
        end
    end
    
    if (~p_enroaches)
        V = [V p'];
        TRI = delaunay(V');
    end
end

end
