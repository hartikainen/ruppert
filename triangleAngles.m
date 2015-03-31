function [ A ] = triangleAngles( points )
%TRIANGLEANGLES Calculate the angles of a triangle specified by points
%   Detailed explanation goes here

s12 = norm(points(:, 2) - points(:, 1));
s13 = norm(points(:, 3) - points(:, 1));
s23 = norm(points(:, 3) - points(:, 2));

loc = @(s1, s2, s3) acosd((s1^2 + s2^2 - s3^2)/(2*s1*s2));

A = [loc(s13, s23, s12) loc(s12, s23, s13) loc(s12, s13, s23)];

end

