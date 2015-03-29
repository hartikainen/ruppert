function [ T ] = ruppertTriangulation( points, segments, alpha )
%RUPPERTTRIANGULATION Triangulation by Ruppert algorithm.
%   Creates a triangulation for the given area, using Ruppert's
%   algorithm.

% argument 3 for the square side
[X, Y, S] = squareBound(points.x, points.y, segments, 3);


V = [X;Y];
TRI = delaunay(V');

encroached = true;
while (encroached)
    i=1;
    encroached_upon_s = true;

    clf;
    triplot(TRI, V(1, :), V(2, :));
    hold on;
    % Plot the vertices (red dots)
    plot(V(1, :), V(2, :), 'or');
    % Plot the original segments
    plot([points.x points.x(1)], [points.y points.y(1)], 'k', 'LineWidth', 3);    
    
    enroached_segments = []
    for i=1:size(S, 2)
        s = S(:, i);
        end_pts = V(:, s);
        d = pdist(end_pts'); % note the ' here.
        mid_pt = sum(end_pts, 2)/2; % mid = [(x1 + x2)/2, (y1 + y2)/2]
        
        if any(pdist2(V(:, setdiff(1:end, s))', mid_pt') < d/2)
            enroached_segments(:, end+1) = s;

            plot(mid_pt(1), mid_pt(2), 'ok');
            plot(end_pts(1, :), end_pts(2, :), 'r', 'LineWidth', 3);
            % draw the circle
            plot((d/2) * cos(0:pi/50:2*pi) + mid_pt(1), (d/2) * sin(0:pi/50:2*pi) + mid_pt(2));
        end
    end

%     while (encroached_upon_s)
%         s = S(:, i);
%         end_pts = V(:, s);
%         d = pdist(end_pts'); % note the ' here.
%         mid_pt = sum(end_pts, 2)/2; % mid = [(x1 + x2)/2, (y1 + y2)/2]
%         
%         clf;
%         triplot(TRI, V(1, :), V(2, :));
%         hold on;
%         % Plot the vertices (red dots)
%         plot(V(1, :), V(2, :), 'or');
%         % Plot the original segments
%         plot([points.x points.x(1)], [points.y points.y(1)], 'k', 'LineWidth', 3);
%         
%         plot(mid_pt(1), mid_pt(2), 'ok');
%         plot(end_pts(1, :), end_pts(2, :), 'r', 'LineWidth', 3);
%         % draw the circle
%         plot((d/2) * cos(0:pi/50:2*pi) + mid_pt(1), (d/2) * sin(0:pi/50:2*pi) + mid_pt(2));
%         
%         if any(pdist2(V(:, setdiff(1:end, s))', mid_pt') < d/2)
%             % splitSeg
%             % Add midpoint to V
%             V = [V mid_pt];
%             TRI = delaunay(V');
%             % Remove s from S
% %             S(:, i) = [];
%             i = i-1;
%             % Add the two halves s1 and s2 to S.
%             new_pt_idx = size(V, 2);
%             s1 = [s(1); new_pt_idx];
%             s2 = [s(2); new_pt_idx];
%             % [s';new_pt_idx new_pt_idx]
% %             S(:, end+1:end+2) = [s1 s2];
%         end
%         i = i+1
%         size(S, 2)
%         if (i>size(S, 2)) encroached_upon_s = false; end
%     end
    skinny_T = featureEdges(triangulation(TRI, V'), deg2rad(alpha));
    encroached = false;
end



%     T := DelaunayTriangulation(points);
%     Q := the set of encroached segments and poor quality
%     triangles;
%     while Q is not empty:                 // The main loop
%         if Q contains a segment s:
%             insert the midpoint of s into T;
%         else Q contains poor quality triangle t:
%                   8              if the circumcenter of t
%                   encroaches a segments s:
%                   9                  add s to Q;
%              else:
%    11                  insert the circumcenter of t into T;
%              end if;
%          end if;
%          update Q;
%      end while;
%      return T;
%  end Ruppert.
end
