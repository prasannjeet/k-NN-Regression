function kNNdrawBoundary_multiclass (k, X, y)
% KNNDRAWBOUNDARY: This function takes an integer k, data matrix X, labels
% y, and draws the decision boundary of the model kNNclassify.
% Inputs:
%  k = The value of number of nearest neighbors
%  X = The data matrix.
%  y = The labels for graph

%% Initializing the Limits
    temp = X;
    X(:,3) = y;   
    temp = sortrows(temp, 1);
    xMin = temp(1,1);
    xMax = temp(end,1);
    temp = sortrows(temp, 2);
    yMin = temp(1,2);
    yMax = temp(end, 2);
    xMin = floor(xMin);
    xMax = ceil(xMax);
    yMin = floor(yMin);
    yMax = ceil(yMax);
    columns = xMax-xMin + 1;
    rows = yMax - yMin + 1;
    gradient = 0.2;
    p = 0;
    
%% Running Loop to Find Classification for Each Point


    for i = 1:gradient:rows
        p = p+1;
        q = 0;
        for j = 1:gradient:columns
            q = q+1;
            targetY = yMax - i +1;
            targetX = xMin + j -1;
%           fprintf(strcat('Current Count: ', num2str(targetY), ',', num2str(targetX),'\n'));
            [output] = kNNclassify_boundary(k, X, [targetX, targetY]);
            CME(p,q) = output;
        end
    end
    
%% Using the Classification Matrix Created Above to Plot Contours


    u = xMin:gradient:xMax;
    v = yMax:(gradient*-1):yMin;
    contour(u, v, CME);
    hold on;
    %--Plot the Training Data--
    gscatter(X(:,1),X(:,2), y, 'bcry');
    
%% Plotting the Labels


    title(strcat('Decision Boundary for k =', int2str(k)));
    xlabel('X-Axis');
    ylabel('Y-Axis');
end

%% Modified k-NN Classification for MultiClass


function [output] = kNNclassify_boundary (k, X, z)
    distanceMatrix = euclideanDistance(z(1), z(2), X(:,1:2));
    X(:,4) = distanceMatrix;
    X = sortrows(X, 4);
    logicVector = X(1:k,3);
    zerosN = sum(logicVector == 0);
    onesN = sum(logicVector == 1);
    twosN = sum(logicVector == 2);
    threesN = sum(logicVector == 3);
    jugaad = [zerosN, 0; onesN, 1; twosN, 2; threesN 3];
    jugaad = sortrows(jugaad, 1);
    switch jugaad(4,2)
        case 0
            output = 0;
        case 1
            output = 1;
        case 2
            output = 2;
        case 3
            output = 3;
    end
    
end

%% Function to Calculate Euclidean Distance of a Point with all the Training Data


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