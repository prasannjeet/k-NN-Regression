%% kNNdrawBoundary (k, X, y, arg)
%   Prasannjeet Singh
%   24 March, 2018
%   
%   Solution to the fourth question of first exercise in the assignment
%   1. This function takes an integer k, data matrix X, labels y,
%   and draws the decision boundary of the model kNNclassify.
%
%   Inputs:
%       k = The value of number of nearest neighbors
%
%       X = The data matrix.
%
%       y = The labels for graph
%
%       arg = (optional) The function will draw a normal decision
%       boundary, if the argument is unused. It will draw two separate
%       graphs with decision boundaries for euclidean and taxi-cab if
%       arg =1. If arg =2, both the graphs will be combined.
%
function [matrix] = kNNdrawBoundary (k, X, y, arg)
    temp = X;
    XCopy = X;
    X(:,3) = y;
    
    %-- Initial Checks
     if rem(k,2) == 0
        fprintf('Error: k must be an odd number for the program to run');
        return;
    end
    
    [temp2, ~] = size(X);
    if k > temp2
        fprintf('Error: k cannot be larger than total sample');
        return;
    end
    %---
    
    
%     [row, ~] = size(X);
    pixelSize = 2;
    temp = sortrows(temp, 1);
    xMin = temp(1,1);
    xMax = temp(end,1);
    temp = sortrows(temp, 2);
    yMin = temp(1,2);
    yMax = temp(end, 2);
    columns = xMax-xMin + 1;
    rows = yMax - yMin + 1;
    CME = ones (rows, columns);
    CMT = CME;
    for i = 1:rows
        for j = 1:columns
%             fprintf(strcat('Current Count: ', int2str(i), ',', int2str(j),'\n'));
            targetY = yMax - i +1;
            targetX = xMin + j -1;
            [output] = kNNclassify_boundary(k, X, [targetX, targetY]);
            [output2] = kNNclassify_taxi_boundary(k, XCopy, y, [targetX, targetY]);
            CME(i,j) = output;
            CMT(i,j) = output2;
        end
    end
    matrix = CME;
    
    u = xMin:xMax;
    v = yMax:-1:yMin;
    figure(1);
    hFig = figure(1);
    d1 = contour(u, v, CME);
    hold on;
    %--Plot the Training Data--
    plotTrainingData(XCopy, y, pixelSize);
    
    title(strcat('kNN Decision Boundary (Euclidean) for k =', int2str(k)));
    xlabel('X-Axis');
    ylabel('Y-Axis');
    
    if (exist('arg', 'var'))
        if arg == 1
            close(hFig);
            figure(2);
            hFig = figure(2);
            set(hFig, 'Position', [0 0 1000 500]);
            subplot(1,2,1);
            plotTrainingData(XCopy, y, pixelSize);
            d1 = contour(u, v, CME);
            title(strcat('kNN Decision Boundary (Euclidean) for k =', int2str(k)));
            xlabel('X-Axis');
            ylabel('Y-Axis');
            subplot(1, 2, 2);
            d2 = contour(u, v, CMT);
            hold on;
            %--Plot the Training Data--
             plotTrainingData(XCopy, y, pixelSize);

            title(strcat('kNN Decision Boundary (Taxi-Cab)for k =', int2str(k)));
            xlabel('X-Axis');
            ylabel('Y-Axis');
            
        elseif arg == 2
            figure(1);
            contour(u, v, CMT);
            hold on;
            %--Plot the Training Data--
            plotTrainingData(XCopy, y, pixelSize);

            title(strcat('kNN Decision Boundary (Euclidean and Taxi-Cab) for k =', int2str(k)));
            xlabel('X-Axis');
            ylabel('Y-Axis');
        end
    end
    
end

function [output] = kNNclassify_boundary (k, X, z)
    logArray = X(:,3);
    logArray = logArray == 1;
    logArrayInverse = ~logArray;
    red = X(logArray,:);
    blue = X(logArrayInverse,:);
    distanceMatrix = euclideanDistance(z(1), z(2), X(:,1:2));
    X(:,4) = distanceMatrix;
    X = sortrows(X, 4);
    logicVector = X(1:k,3);
    logicVector = logical(logicVector);
    redNear = sum(logicVector);
    blueNear = length(logicVector) - redNear;    
    if redNear > blueNear
        output = 1;
    else
        output = 0;
    end    
end


function [output] = kNNclassify_taxi_boundary (k, X, y, z)    
    X(:,3) = y;
    distanceMatrix = taxiCabDistance(z(1), z(2), X(:,1:2));
    X(:,4) = distanceMatrix;
    X = sortrows(X, 4);
    logicVector = X(1:k,3);
    logicVector = logical(logicVector);
    redNear = sum(logicVector);
    blueNear = length(logicVector) - redNear;    
    if redNear > blueNear
        output = 1;
    else
        output = 0;
    end
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

