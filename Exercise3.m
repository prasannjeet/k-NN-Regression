%% Exercise 3: k-NN Regression
% This document contains solutions for question 1 to 3 of Exercise-3.
%
% <html>
%   <link rel="stylesheet"
%   href="https://cdn.jsdelivr.net/foundation/6.2.4/foundation.min.css">
%   <link href="https://fonts.googleapis.com/css?family=Corben"
%   rel="stylesheet"> <link
%   href="https://fonts.googleapis.com/css?family=Nobile" rel="stylesheet">
%   <link href='http://fonts.googleapis.com/css?family=Ubuntu:bold'
%   rel='stylesheet' type='text/css'> <link
%   href="https://fonts.googleapis.com/css?family=Space+Mono"
%   rel="stylesheet"> <style type="text/css" > h1{font-family:'Ubuntu',
%   Helvetica, Arial,
%   sans-serif;font-size:50px;line-height:65px;color:red}h2{font-family:'Ubuntu',
%   Helvetica, Arial,
%   sans-serif;font-size:25px;line-height:33px}p{font-family:'Nobile',
%   Helvetica, Arial, sans-serif;font-size:13px;line-height:25px;
%   max-width: 1000px; word-wrap: break-word;text-align: justify;}
%   pre.codeinput,pre.codeoutput{font-family:'Space Mono',
%   monospace; max-width: 1000px;}pre.codeoutput{background-color: black;
%   color: white;}</style>
% </html>

%% Q1 Implementing k-NN Regression
% The function *kNNregression()* has been implemented and is available in this folder.

%% Q2 Testing the Regression Model
% Using the given sample data *z*
% Using the value of k as *12*

load Data/data3.mat;
kNNregression(12, train_X, train_y, z)

%%
% As can be observed, the answer matches with the one provided in the
% assignment.

%% Q3 Mean Squared Error
% As Mean Squared Error is not explicitly defined in the question, it is
% assumed to be the following:
%
% <<https://wikimedia.org/api/rest_v1/media/math/render/svg/e258221518869aa1c6561bb75b99476c4734108e>>
%
% Taken from <https://en.wikipedia.org/wiki/Mean_squared_error This Wikipedia Article.> 


load Data/data3.mat;
[rows, columns] = size(test_X);
for k = 1:10
    for i = 1:rows
        testResult(i,k) = kNNregression(k, train_X, train_y, test_X(i,:));
    end
end
testResult = ((sum((testResult-(repmat(test_y, [1,10]))) .^ 2))/rows)';
testResult(:,2) = 1:10;
thisFig = figure(3);
graph = bar(testResult(:,2), testResult(:,1),'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
title('Mean Squared Error for Different Values of k');
xlabel('k Values');
ylabel('Mean Squared Error');
snapnow;
close(thisFig);

%%
% Now let us find the value of k that minimizes the test error

testResult = sortrows(testResult, 1);
kValue = testResult(1,2)
errorValue = testResult(1,1)

%%
% Therefore, as calculated, the least test error is observed with k = 4.