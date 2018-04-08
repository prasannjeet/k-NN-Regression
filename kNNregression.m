function [output] = kNNregression(k, train_X, train_y, z)
% k-NN Regression Function : This function computes the estimated output
% via the kNN regression where the answer is the mean of k nearest
% neighbors.
% Inputs:
%   k: Number of Nearest Neighbors
%   X: The training data matrix
%   y: The labels (continuous data in this case)
%   z: The n-dimensional input vector, which should match with

[rows,columns] = size(train_X);
train_X (:,(columns+2)) = (sum(((repmat(z, [rows,1]) - train_X) .^ 2),2)) .^ (1/2);
train_X (:,(columns+1)) = train_y;
train_X = sortrows(train_X, (columns+2));
output = (sum(train_X(1:k, (columns+1))))/k;
end