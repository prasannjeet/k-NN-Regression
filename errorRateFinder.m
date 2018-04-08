function [accuracy, errorRate] = errorRateFinder (k, trainX, trainy, testX, testy)
% ErrorRateFinder: This function finds the error rate and accuracy of k-NN
% algorithm for a particular value of k, given some test datay and training
% data.
% Inputs:
%   k:  The value of k in k-NN algorithm.
%   trainX: The training matrix.
%   trainy: Labels for training matrix.
%   testX: The test matrix.
%   testy: Labels for test matrix.

%% Variable settings and initialization


[rows, ~] = size(testX);
trainX(:,3) = trainy;   %Combining the inputs for simplification
testX(:,3) = testy;     %Combining the inputs for simplification

%% Now iterating through each test item to find out it's solution
% Moreover, comparing the solution with the original solution


for i = 1:rows
    testX(i,4) = kNNclassify_boundary (k, trainX, [testX(i,1), testX(i,2)]);
    testX(i,5) = testX(i,3) == testX(i,4);
end

%% Checking how many of the items returned the corret answer


correctAnswer = sum(testX(:,5));
accuracy = correctAnswer*100/rows;
errorRate = 100-accuracy;

end

%% Modified k-NN Classification for MultiClass


function [output] = kNNclassify_boundary (k, X, z)
    distanceMatrix = euclideanDistance(z(1), z(2), X(:,1:2));
    X(:,4) = distanceMatrix;
    X = sortrows(X, 4);
    clearvars logicVector;
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