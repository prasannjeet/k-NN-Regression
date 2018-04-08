%% plotTrainingData(X, y, size)
% _This function plots the mat file given in the assignment._
%
% Inputs:
%
% # X: The Data Matrix
% # y: The labels for Graph
% # Optional Input: size (number) input the size of scatter points in pixls by using this option input. Default value used is 55.
%
% Output: A graph with blue and red scatters

function [graphPlot] = plotTrainingData(X, y, size)
    defaultPixelSize = 55;
    y = logical(y);
    yInverse = ~y;
    red = X(y,:);
    blue = X(yInverse,:);
    
    if (exist('size', 'var'))
        graphPlot = scatter(red(:,[1]), red(:,[2]), size, [1 0 0], 'filled');
        hold on;
        scatter(blue(:,[1]), blue(:,[2]), size, [0 0 1], 'filled');    
    else
        graphPlot = scatter(red(:,[1]), red(:,[2]), defaultPixelSize, [1 0 0], 'filled');
        hold on;
        scatter(blue(:,[1]), blue(:,[2]), defaultPixelSize, [0 0 1], 'filled');   
    end
     
    title('Training Data Scatter-Plot');
    xlabel('X-Axis')
    ylabel('Y-Axis')
    
    return
end
