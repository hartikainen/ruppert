function [ DT, V ] = ruppertTriangulation( V, S, alpha )
%RUPPERTTRIANGULATION Triangulation by Ruppert algorithm.
%   Creates a triangulation for the given area, using Ruppert's
%   algorithm.

% argument 3 for the square side
[V, S] = squareBound(V, S, 3);
X = V(1, :); Y = V(2, :);
original_S = S;
DT = delaunayTriangulation(V');

figure(1);
clf;
hold on;
for i=1:size(S, 2)
    x = X(:, S(:, i));
    y = Y(:, S(:, i));
    plot(x, y, '-k', 'LineWidth', 2);
end
plot(V(1, :), V(2, :), '.k', 'MarkerSize', 20);

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

debug = 0;
if (debug)
    plot([X, X(1)], [Y, Y(1)], ':r', 'LineWidth', 4);
    hold on
    triplot(DT);
end
end
