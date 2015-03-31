function [ TRI, V ] = ruppertTriangulation( V, S, alpha )
%RUPPERTTRIANGULATION Triangulation by Ruppert algorithm.
%   Creates a triangulation for the given area, using Ruppert's
%   algorithm.
X = V(1, :); Y = V(2, :);
% argument 3 for the square side
[V, S] = squareBound(V, S, 3);
original_S = S;
TRI = delaunay(V');

debug = 1;
if (debug) % plot the initial mesh
    figure(1);
    clf;
    % Plot the vertices (red dots)
    plot(V(1, :), V(2, :), 'or');
    hold on;
    % Plot the original segments
    plot([V(1, :) V(1, 1)], [V(2, :) V(2, 1)], 'k', 'LineWidth', 2);
end

% While segments encroached upon, or angles > alpha
while (true)
    angles_lt_alpha = false;

    i=1;
    while (i < size(S, 2))
        s = S(:, i);
        encroached = encroachedUpon(s, V);
        if (encroached)
            [S, V] = splitSeg(S, V, i, original_S);
            TRI = delaunay(V');

            % Used for breaking
            i = i - 1;
        end
        i = i+1;
    end

    skinny_TRI = skinnyTriangles(TRI, V, alpha);

    angles_lt_alpha = size(skinny_TRI, 1) > 0;

    if (~(angles_lt_alpha))
        break;
    end

    % Pick only the first triangle to be split. Weird, but this is how it's done in
    % the paper without enhancement.
    tr = triangulation(skinny_TRI(1, :), V');
    [p, r] = circumcenter(tr);

    encroached_idx = encroachesUpon(p, S, V);

    if (length(encroached_idx) > 0)
        for i=encroached_idx
            [S, V] = splitSeg(S, V, i, original_S);
        end
        TRI = delaunay(V');
    else
        V = [V p'];
        TRI = delaunay(V');
    end
end

debug = 1;
if (debug)
    plot([X, X(1)], [Y, Y(1)], ':r', 'LineWidth', 4);
    hold on
    triplot(TRI, V(1, :), V(2, :));
end
end
