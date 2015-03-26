% c = 99
% x = 120

function [X,Y,S] = pslg2(filename)
    figure;
    axis equal;
    hold on;

    img = imread(filename);
    imagesc(img);
    X=[];
    Y=[];
    [xx,yy,button] = ginput(1);
    while (button ~= 120)
        X = [X xx];
        Y = [Y yy];
        plot(xx,yy,'c*');
        [xx,yy,button] = ginput(1);
    end
    segments = [];
    finalpoints = [X' Y'];

    [x,y,button] = ginput(2);
    while (button ~= 120)
        apoint = [x(1) y(1)];
        bpoint = [x(2) y(2)];
        closestpointa = dsearchn(finalpoints,apoint);
        closestpointb = dsearchn(finalpoints,bpoint);
        segments = [segments [closestpointa closestpointb]'];
        finalpointx = [finalpoints(closestpointa,1) finalpoints(closestpointb,1)];
        finalpointy = [finalpoints(closestpointa,2) finalpoints(closestpointb,2)];
        plot(finalpointx',finalpointy','r','LineWidth',2);
        [x,y,button] = ginput(2);
    end

    S = segments;
end