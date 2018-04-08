function [compM] = heatMapGenerator(k, train_X, train_y, G)
% *Heat Map Generator* Function
% Created By : *Prasannjeet Singh*
% 4th April, 2018
%
% This functions returns a square matrix with resultant answers that were
% estimated by k-NN regression that will later be used to generated a
% heatmap in any way the user who called the function pleases. The training
% data is normalized in this process. Moreover, while this function
% evaluates k-NN regresesion for about a million points (if G=1000)
% simultaneously, it does NOT use any loops.
% Inputs:
%   k: Number of neighbours to be consideredin the regression.
%   train_X: The training data
%   train_Y: The resultant answers of the training data
%   G: G here stands for the gradient, i.e. number of rows/columns of the
%       square matrix that will be returned by the function. Example, if G
%       is chosen to be 1000, a (1000x1000) matrix will be returnd to
%       generate the heatmap. In this case (G=1000) k-NN regression will be
%       done on 100,000,0 distinct data-sets. Therefore, more the value of
%       G, means more the time it will take to run the function. However,
%       less the value of G, less will be the quality of the heatmap, i.e.
%       the heatmap may appear to be pixelated. Optimal value of G can be
%       500-1000 depending upon the computers used. imagesc() can be one of
%       the ways heatmap can be generated using the returned matrix.
%
%
% Note: *Communications System Toolbox* plugin might be needed to run this
% code, as it uses the function *vec2mat()* that converts a vector to
% matrix when columns are specified.


%% Initializing Variables
% Since we are calculating k-NN for multiple (thousands) of points, each
% point will use one layer of a 3-dimensional matrix. 

% Generating the number of points according to the specified G value
x=repmat((0:1/G:(1-1/G)),[G,1]);
x = x(:);
y = repmat(([0:1/G:(1-1/G)]'), [G,1]);
z(:,1) = x;
z(:,2) = y;
clear x; clear y;

% Normalizing the training data given
train_X(:,1) = (train_X(:,1) - min(train_X(:,1)))/(max(train_X(:,1))-min(train_X(:,1)));
train_X(:,2) = (train_X(:,2) - min(train_X(:,2)))/(max(train_X(:,2))-min(train_X(:,2)));

[testR, ~] = size(train_X);
[zR, ~] = size(z);

% Coverting test values into 3D matrix 
% Each test case in the fist row of every page (layes):
testM(1,:,:) = z'; 
% Duplicating first row of every page n times, where n is size of training data:
testM = repmat(testM, [testR,1,1]);

% Converting training values into 3D matrix
% Repeating all values to n pages, where n is number of test data
trainM = repmat(train_X, [1,1,zR]);

%% Applying k-NN Regression
% Note that variables are constantly cleared as each unused variable might
% contain as much as a million items (or more) of a high G value is
% specified.

% Euclidean Distance
newM = testM - trainM;
clear testM; clear trainM;
newM = newM .^ 2;
newM = sum(newM, 2); 
newM = newM .^ (1/2);

% The training solutions are repeated in each layer
train_y = train_y';
train_y = repmat(train_y, [1,1,zR]);

% Euclidean distances and training solutions are now clubbed together in a
% 3-D matrix where each layer contains one point. And each row contains the
% euclidean distance along with the training solution for one single point.
finalM(:,1,:) = train_y; % Training Answers
finalM(:,2,:) = newM; % Euclidean Distance
clear train_y; clear newM;

% The three dimensional matrix created above is now converted into
% 2-Dimensional matrix with each cell containing two values (Euclidean
% distance as well as the training answer) This is done by making use of
% complex numbers, where the real part contains Euclidean Distance and
% imaginary part contains the training solutions (train_y). Note that '1i'
% used below is complex item. Note relevant in this function.
compM(:,:) = finalM(:,2,:) + 1i * finalM (:,1,:); 
clear finalM;

% In further steps, firstly the matrix is sorted by the real values
% (euclidean distance, in our case). Secondly, the nearest k items are
% chosen according to the 'k' value given. Thirdly, the imaganiry values
% are now extracted (the training solutions for corresponding points, in
% our case). Finally the mean of all those points are taken to get the
% resultant solution for each of the points in a vector form. The vector
% will be of length G*G.
compM = sort(compM,'ComparisonMethod','real'); %sorted by the real part
compM = sum(imag(compM(1:k,:)))/k;

% Now the above created vector is converted into a square matrix with
% rows = columns = G, and the matrix is returned.
compM = vec2mat(compM,G);
end