function [ DT, V ] = ruppertTriangulation( V, S, alpha )
%RUPPERTTRIANGULATION Triangulation by Ruppert algorithm.
%   Creates a triangulation for the given area, using Ruppert's
%   algorithm.

% argument 3 for the square side
[V, S] = squareBound(V, S, 3);
X = V(1, :); Y = V(2, :);
original_S = S;
DT = delaunayTriangulation(V');

% While segments encroached upon, or angles > alpha
while (true)
    angles_lt_alpha = false;

    i=1;
    while (i < size(S, 2))
        s = S(:, i);
        encroached = encroachedUpon(s, DT);
        if (encroached)
            [S, DT] = splitSeg(S, DT, i, original_S);

            % Used for breaking
            i = i - 1;
        end
        i = i+1;
    end

%     tr = triangulation(DT(:,:), DT.Points);
%     fe = featureEdges(tr, deg2rad(alpha));
%     skinny_TRI = skinnyTriangles(TRI, V, alpha);
    skinny_TRI = skinnyTriangles(DT(:,:), DT.Points', alpha);

    angles_lt_alpha = size(skinny_TRI, 1) > 0;

    if (~(angles_lt_alpha))
        break;
    end

    % Pick only the first triangle to be split. Weird, but this is how it's done in
    % the paper without enhancement.
    tr = triangulation(skinny_TRI(1, :), DT.Points);
    [p, r] = circumcenter(tr);

encroached_idx = encroachesUpon(p, S, DT.Points);

    if (length(encroached_idx) > 0)
        for i=encroached_idx
            [S, DT] = splitSeg(S, DT, i, original_S);
        end
    else
        DT.Points(end+1, :) = p;
    end
end

debug = 1;

if (debug)
    figure(1);
    clf;
    hold on;
    % Plot the actual triangulation
    triplot(DT, 'k');
    for i=1:size(original_S, 2)
        x = X(:, original_S(:, i));
        y = Y(:, original_S(:, i));
        plot(x, y, '-r', 'LineWidth', 2);
    end
    plot(X, Y, '.k', 'MarkerSize', 20);
    title(sprintf('Delaunay Refinement triangulation with alpha=%.2f degrees', alpha));
end
end
