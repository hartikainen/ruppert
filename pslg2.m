% c = 99
% x = 120

close all;
clear all;

figure;
axis equal;
hold on;
% img = imread('scrshot.png');
img = imread('example.png');
image(img);
[X,Y,BUTTON] = ginput;
segments = [];
last_button = -123;
len = size(X,1);
points = [X Y];
finalpoints = [];
j = 1;
for i=1:len
    btn = BUTTON(i);
    % press x for single vertices
    if (btn == 120)
        j = j+1;
        finalpoints(j,:) = points(i,:);
        continue;
    end
    % press c to connect with closest vertex
    if (btn == 99)
        cpoint = points(i,:);
        points(i,:) = [-666 -666];
        closestpoint = dsearchn(finalpoints,cpoint);
        segments = [segments [j-1 closestpoint]'];
        BUTTON(i) = last_button;
    else
        finalpoints(j,:) = points(i,:);
        j = j+1;
    end
    if (btn == last_button)
        segments = [segments [j-2 j-1]'];
    end
    last_button = btn;
end

