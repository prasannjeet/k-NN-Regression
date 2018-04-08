%% trainingErrorMatrix()
% This functions returns a matrix with k values and their respective
% training error percentage. It then further draws a graph for the value of
% k versus the training error. This function takes the help of the other
% function [trainingError()].
%
% Inputs
%
% # X: The data matrix
% # y: The labels
%
% Output
%
% * A Matrix k versus training error.
% * The graph for the above matrix.

function [matrix, graph] = trainingErrorMatrix(X, y)
    [entries, ~] = size(X);
    if rem(entries, 2) == 0
        theLimit = entries-1;
    else
        theLimit = entries;
    end
    matrix = zeros((theLimit-1)/2+1, 2);
    matrix(:,1) = 1:2:theLimit;
    for i = 1:((theLimit-1)/2+1)
        k = i*2-1;
        matrix(i,2) = trainingError (k, X, y);
    end
    hFig = figure(21);
    set(hFig, 'Position', [0 0 1000 500]);
    subplot('position',[0.05 0.1 0.95 0.85]);
    graph = bar(matrix(:,1), matrix(:,2),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
    title('Training Error Plotted Against k');
    xlabel(strcat('k-Values ranging from',32,int2str(1),' to',32,int2str(theLimit),' (Only Odd Values)'));
    ylabel('The Training Errors');
end


%% trainingError()
%   Prasannjeet Singh
%   25 March, 2018
%
%   This function gives the training error in percentage for a given matrix
%   and the number of nearest neighbors. Moreover, it also returns the
%   output matrix, which has the points in first and second column, label
%   in the third column, where as the training label in the fourth column.
%
%   Inputs:
%       k = Number of nearest neighbors
%       X = The data matrix
%       y = The labels
%
%   Output:
%       result : The accuracy in percentage

function [result] = trainingError (k, X, y)
    %----Performing Initial Checks
    if rem(k,2) == 0
            fprintf('Error: k must be an odd number for the program to run');
            return;
    end
    [entries, ~] = size(X);
    if k > entries
        fprintf('Error: k cannot be larger than total sample');
        return;
    end
    %----
    for i = 1: entries
        xTemp = X;
        yTemp = y;
        %--Can be uncommented if the point itself should be excluded--
        % xTemp(i,:) = [];
        % yTemp(i,:) = [];
        %--Uncomment Above        
        distanceVector = euclideanDistance (X(i,1), X(i,2), xTemp);
        yTemp(:,2) = distanceVector;
        yTemp = sortrows(yTemp, 2);
        yTemp = yTemp(1:k, 1);
        ones = sum(yTemp);
        zeroes = length(yTemp) - ones;
        final = (ones > zeroes);
        resultVector(i) = (final == y(i));
    end
    total = length(resultVector);
    correct = sum(resultVector);
    
    result = correct/total*100;
    result = 100-result;
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