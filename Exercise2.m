%% Exercise 2 - Multi Class k-NN
% Submitted by *Prasannjeet Singh*
%
% This file contains solution 1 to 3 of Exercise-2 of Assignment 1.
%
% *Notes*
%
% * All the function implementations are done in external files, which are
% all included within this folder. More details about each implemented
% function can be found in their respective .m files.
% * Console outputs are shown in black background and white text.
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

%% Q1 Plotting the training data in a ScatterPlot
% This can simply be done by using the inbuilt *gscatter()* function:

clear all;
load Data/data2.mat;
thisFig = figure(1);
gscatter(train_X(:,1),train_X(:,2), train_y, 'brgk', 'phd*');
snapnow;
close(thisFig);

%% Q2 Drawing the Decision Boundary
% This uses the function *kNNdrawBoundary_multiclass()* which is defined in this
% folder. More details about the function can be read in it's file.


load Data/data2.mat;
thisFig = figure(2);
set(thisFig, 'Position', [0 0 2000 500]);
for i = 1:4
    subplot(1,4,i);
    kNNdrawBoundary_multiclass (i*2-1, train_X, train_y);
end
snapnow;
close(thisFig);

%% Q3 Finding the Error Rate from Test Data
% This uses the *errorRateFinder()* function, which is defined in this
% folder. More details about the function can be read in it's file.
%
% *Plotting Error Rate vs _k_ for the given test data*

% Initialization
load Data/data2.mat;
[rows, ~] = size(train_X);

% Running loop to find accuracy and error rates for each k
clearvars theMatrix;
theMatrix = ones(rows,2);
for i = 1:rows
    [~,er] = errorRateFinder(i,train_X,train_y,test_X,test_y);
    theMatrix(i,:) = [i, er];
end

% Now plotting the above generated matrix
hFig = figure(3);
set(hFig, 'Position', [0 0 1000 500]);
subplot('position',[0.05 0.1 0.95 0.85]);
graph = bar(theMatrix(:,1), theMatrix(:,2),'FaceColor',[0 .5 .5]);
title('Error Plotted Against k');
xlabel(strcat('k-Values ranging from',32,int2str(1),' to',32,int2str(rows)));
ylabel('The Training Errors');
snapnow;
close(hFig);

%%
% As can be observed clearly, error increases gradually as we incease the
% value of k. Moreover, after a certain value of k, the error peaks up and
% then stays constant. Let us now find the value of k for which the error
% was the least and also the error percentage for that k.

leastError = sortrows(theMatrix, 2);
kValue = leastError(1,1)
ErrorValue = leastError(1,2)

%%
% *Therefore, the value of k with the smallest error (7.8%) is 29.*