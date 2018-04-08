%% *Q2 kNNclassify (k, X, y, z)*
%
% _Solution for Question 2, Exercise 1. Implements the function kNNclassify, which takes as input an integerk , data matrix X, labels y, a point z and outputs the classification of z by computing the mode of it's k closest neighbors in X. To calculate the distance, this function uses the Euclidean metric._
%
% Inputs:
%
% # k: Integer: Number of neighbors to compare from. Must be an odd number.
% # X: The data matrix.
% # y: Labels for the graph.
% # z: A vector with first and second item being the x and y coordinates, respectively.
%
% Output: A console statement mentioning which category does the new point belongs to, moreover a graph will also be displayed with the new point.

function [graph, output, str] = kNNclassify (k, X, y, z)    
    if rem(k,2) == 0
        fprintf('Error: k must be an odd number for the program to run');
        return;
    end
    [temp, ~] = size(X);
    if k > temp
        fprintf('Error: k cannot be larger than total sample');
        return;
    end
    plotTrainingData(X, y);
    hold on;
    X(:,3) = y;
    distanceMatrix = euclideanDistance(z(1), z(2), X(:,1:2));
    X(:,4) = distanceMatrix;
    X = sortrows(X, 4);
    logicVector = X(1:k,3);
    logicVector = logical(logicVector);
    redNear = sum(logicVector);
    blueNear = length(logicVector) - redNear; 
    if redNear > blueNear
        str = sprintf([strcat('For k = ', int2str(k), ', and point = (', int2str(z(1)),',',int2str(z(2)),')\n')...
            'New Point Belongs to Group [1] (or RED) Category\n'...
            'The point has been marked in pink\n'...
            'The boundary has also been marked with the color red']);
        graph = scatter(z(1), z(2), 85, convertRGB(255,192,203), 'filled');
        %------------Circle-----------
        radius = X(k,4);
        makeACircle(radius, z(1), z(2), [1 0 0]);
        %------------Circle-----------
        output = 1;
    else
        str = sprintf([strcat('For k = ', int2str(k), ', and point = (', int2str(z(1)),',',int2str(z(2)),')\n')...
            'New Point Belongs to Group [0] (or BLUE) Category\n'...
            'The point has been marked in light blue\n'...
            'The boundary has also been marked with the color blue']);
        graph = scatter(z(1), z(2), 85, convertRGB(173,216,230), 'filled');
        %------------Circle-----------
        radius = X(k,4);
        makeACircle(radius, z(1), z(2), [0 0 1]);
        %------------Circle-----------
        output = 0;
    end
    
    %----Labelinng the Graph----
    title(strcat('kNN-Euclidean | k = ', int2str(k), ' | point: (', int2str(z(1)),',',int2str(z(2)),') | Answer: ',int2str(output)));
    xlabel('X-Axis');
    ylabel('Y-Axis');
    legend ('1', '0');
    hold off;
end

%% Function to Calculate Euclidean Distance
% *Prasannjeet Singh*
% *24 March, 2018*
%
%   Calculates the euclidean distance of a point from all the other
%   points given in the matrix. Input and output format is explained
%   below:
%
%   Input:
%       x & y: x and y coordinates of the point.
%       M: The matrix containing all the other points, with the first
%       row containing x coordinates and the correspoinding second row
%       containing the y coordinates.
%
%   Output:
%       A vector with all the correspoinding euclidean distance in each
%       row.


function [distance] = euclideanDistance (x, y, M)    
    [row, ~] = size(M);
    temp1(1:row) = x;
    temp2(1:row) = y;
    temp1 = temp1';
    temp2 = temp2';
    
    pointMatrix(:,1) = temp1;
    pointMatrix(:,2) = temp2;
    
    pointMatrix = pointMatrix - M;
    pointMatrix = pointMatrix .^ 2;
    pointMatrix = sum(pointMatrix,2);
    pointMatrix = pointMatrix .^ (1/2);
    distance = pointMatrix;
end

%% Function to Draw a Circle
% *Prasannjeet Singh*
%
% *23 March, 2018*
%
% This function draws a circle in a graph for the given co-ordinates
% and other optional inputs
% Inputs:
%   x = numerical x co-ordinate for center of the circle
%   y = numerical y co-ordinate for center of the circle
%   color = color RGB vector
%   width = width of the circle in pixels
% Output:
%   graphPlot: the resultant circle plotted in a graph


function[graphPlot] = makeACircle(radius, x, y, color, width)
    c = [x y];
    
    pos = [c-radius 2*radius 2*radius];
    
    
    if (exist('color', 'var'))
        if (exist('width', 'var'))
            graphPlot = rectangle('Position',pos,'Curvature',[1 1], 'EdgeColor', color , 'LineWidth', width);
            axis equal;
            return
        end
        graphPlot = rectangle('Position',pos,'Curvature',[1 1], 'EdgeColor', color);
        axis equal;
        return
    end
    
    if (exist('width', 'var'))
            graphPlot = rectangle('Position',pos,'Curvature',[1 1], 'LineWidth', width);
            axis equal;
           
            return
    end
    
    graphPlot = rectangle('Position',pos,'Curvature',[1 1]);
    axis equal;
    return
end

%% Convert Simple RGB to MATLAB RGB Format
% Converts a simple RGB format which ranges from 0 to 255 to matlab RGB
% format which ranges from 0 to 1.

function [vector] = convertRGB(x, y, z)
    r = x/255;
    g = y/255;
    b = z/255;
    vector = [r g b];
end