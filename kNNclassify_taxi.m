%% kNNclassify_taxi(k, X, y, z)

%   Prasannjeet Singh
%   24 March, 2018
%
%   Solution for Question 2, Exercise 1. Implements the function
%   kNNclassify, which takes as input an integerk, data matrix X,
%   labels y, a point z and outputs the classification of z by
%   computing the mode of it's k closest neighbors in X. To calculate
%   the distance, this function uses the Euclidean metric. In this
%   function the distance is calculated by the taxi-cab way.
%   https://en.wikipedia.org/wiki/Taxicab_geometry
%
%   Inputs:
%       k: Integer: Number of neighbors to compare from. Must be an
%       odd number.
%
%       X: The data matrix.
%
%       y: The label.
%
%       z: A vector with first and second item being the x and y
%       coordinates, respectively.
%
%   Output:
%       A console statement mentioning which category does the new
%       point belongs to, moreover a graph will also be displayed with
%       the new point.
    

function [graph, output, str] = kNNclassify_taxi (k, X, y, z)
    tempp = X;
    X(:,3) = y;
    
    if rem(k,2) == 0
        fprintf('Error: k must be an odd number for the program to run');
        return;
    end
    
    [temp, ~] = size(X);
    if k > temp
        fprintf('Error: k cannot be larger than total sample');
        return;
    end
    
    %--First, Plot the Training Data--
        plotTrainingData(tempp, y);
    %--Initial Graph Plotted--
    distanceMatrix = taxiCabDistance(z(1), z(2), X(:,1:2));
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
        %------------Boundary-----------
        radius = X(k,4);
        makeTaxiCabBoundary(radius, z(1), z(2), 0);
        %------------Boundary-----------
        output = 1;
    else
        str = sprintf([strcat('For k = ', int2str(k), ', and point = (', int2str(z(1)),',',int2str(z(2)),')\n')...
            'New Point Belongs to Group [0] (or BLUE) Category\n'...
            'The point has been marked in light blue\n'...
            'The boundary has also been marked with the color blue']);
        graph = scatter(z(1), z(2), 85, convertRGB(173,216,230), 'filled');
        %------------Boundary-----------
        radius = X(k,4);
        makeTaxiCabBoundary(radius, z(1), z(2), 1);
        %------------Boundary-----------
        output = 0;
    end
    
    %----Labelinng the Graph----
    title('Taxi-Cab Distance');
    xlabel('X-Axis');
    ylabel('Y-Axis');
    legend ('1', '0');
end

%   makeTaxiCabBoundary(distance, x, y, c)
%
%   Prasannjeet Singh
%   24 March, 2028
%
%   This function draws a boundary for taxi-cab distance. It is
%   important to note that in case of calculating a taxi-cab boundary,
%   the boundary will not be a square, but, will be a right-rhombus, or
%   a square tilted 45 degrees. More on this can be red at the
%   following link: https://en.wikipedia.org/wiki/Taxicab_geometry#Properties
%
%   Input:
%       distance: The Taxi-Cab distance.
%
%       x, y: The x and y co-ordinates, respectively.
%
%   Output:
%       The resultant taxi-cab boundary will be returned as well as
%       plotted in the graph.
    
function[graphPlot] = makeTaxiCabBoundary(distance, x, y, c)
    d = distance;
    M = [x, y+d; x+d, y; x, y-d; x-d, y; x, y+d;];
    if c == 0
        graphPlot = plot(M(:,1), M(:,2), 'r');
    else
        graphPlot = plot(M(:,1), M(:,2), 'b');
    end
end

function [distance] = taxiCabDistance (x, y, M)
    %   Prasannjeet Singh
    %   24 March, 2018
    %
    %   Calculates the Taxi-Cab distance of a point from all the other
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
    %       A vector with all the correspoinding Taxi-Cab distance in each
    %       row.
    
    [row, ~] = size(M);
    temp1(1:row) = x;
    temp2(1:row) = y;
    temp1 = temp1';
    temp2 = temp2';
    
    pointMatrix(:,1) = temp1;
    pointMatrix(:,2) = temp2;
    
    pointMatrix = pointMatrix - M;
    pointMatrix = abs(pointMatrix);
    pointMatrix = sum(pointMatrix,2);
    distance = pointMatrix;
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
