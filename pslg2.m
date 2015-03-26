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
finalpoints = [X Y];

plot(X,Y,'o');

[x,y,button] = ginput(2);
while (button ~= 120)
    apoint = [x(1) y(1)];
    bpoint = [x(2) y(2)];
    closestpointa = dsearchn(finalpoints,apoint);
    closestpointb = dsearchn(finalpoints,bpoint);
    segments = [segments [closestpointa closestpointb]'];
    finalpointx = [finalpoints(closestpointa,1) finalpoints(closestpointb,1)];
    finalpointy = [finalpoints(closestpointa,2) finalpoints(closestpointb,2)];
    plot(finalpointx',finalpointy');
    [x,y,button] = ginput(2);
end
