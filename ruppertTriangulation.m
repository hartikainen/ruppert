function [ T ] = ruppertTriangulation( points, segments, threshold )
%RUPPERTTRIANGULATION Triangulation by Ruppert algorithm.
%   Creates a triangulation for the given area, using Ruppert's
%   algorithm.

% argument 3 for the square side
[X, Y, S] = squareBound(points.x, points.y, segments, 3);

DT = delaunayTriangulation([X Y]);

enroached = true;



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
