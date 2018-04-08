%% Exercise 1 k-NN Classification
% Submitted By: *Prasannjeet Singh*
%
% This file contains solution 1 through 6 of the first exercise of
% Assignment - 1.
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
%% *Q1 Plotting the training data in a scatter-plot.*
% Plotting uses the function *plotTrainingData()* which is defined in this
% folder. More about the function can be read in it's function definition.
load Data/data1.mat;
plotTrainingData(X, y, 65);
snapnow;
close;

%% *Q2 Implementing kNNclassify algorithm*
% The function *kNNclassify()* has been implemented in this folder. More
% about the function can be read in it's function definition.

%% *Q3 Classifying (-17, 14) for k=1,3 and 5.*
% Classifying the points uses *kNNclassify()* function. More about it can
% be read in it's function definition.
load Data/data1.mat;
hFig = figure(3);
set(hFig, 'Position', [0 0 1500 500]);
for i = 1:3
    subplot(1,3,i);
    [~,~,OutputMessage] = kNNclassify (i*2-1, X, y, [-17, 14])
end
snapnow
close(hFig);
%% *Q4 kNNdrawBoundary Implementation and Plotting*
% The boundary is drawin using the function *kNNdrawBoundary()* which has
% been implmented in this folder. It uses the contour() function to draw
% the boundary. More about it can be read in the function definition which
% is in this folder.
load Data/data1.mat;
hFig = figure(1);
set(hFig, 'Position', [0 0 1500 500]);
for i = 1:3
    subplot(1,3,i);
    kNNdrawBoundary(i*2-1, X, y);
end
snapnow;
close(hFig);

%% *Q5 The Training Error*
% To calculate the training error, I check whether a particular value of k
% can accurately classify an already existing point in the graph. I did
% this by using the method *trainingError()* which is implemented and
% defined in this folder. Moreover, I have also plotted a graph
% which maps the training error for each value of 'k'. This was done by the
% function *trainingErrorMatrix()* which is also implemented and defined in
% this folder.
%
% _Let us see this graph for a broad understanding:_
load Data/data1.mat;
[~,trainingErrorGraph] = trainingErrorMatrix(X,y);
snapnow;
close;
%%
% Just by looking at the image above, we can say that in most of the cases
% the training error increases as we increase the value of k. Note that the
% k value is always odd in the above graph. Let us also make a table with
% precise values of training error for a few values of k:
%
% <html> <style type="text/css"> .tg
% {border-collapse:collapse;border-spacing:0;} .tg td{font-family:Arial,
% sans-serif;font-size:14px;padding:10px
% 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
% .tg th{font-family:Arial,
% sans-serif;font-size:14px;font-weight:normal;padding:10px
% 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
% .tg
% .tg-chtt{font-weight:bold;background-color:#000000;color:#c0c0c0;border-color:inherit;vertical-align:top}
% .tg .tg-us36{border-color:inherit;vertical-align:top} </style> <table
% class="tg">
%   <tr>
%     <th class="tg-chtt">k</th> <th class="tg-chtt">Training Error</th>
%   </tr> <tr>
%     <td class="tg-us36">1</td> <td class="tg-us36">0.000</td>
%   </tr> <tr>
%     <td class="tg-us36">3</td> <td class="tg-us36">8.333</td>
%   </tr> <tr>
%     <td class="tg-us36">5</td> <td class="tg-us36">11.667</td>
%   </tr> <tr>
%     <td class="tg-us36">7</td> <td class="tg-us36">15.000</td>
%   </tr> <tr>
%     <td class="tg-us36">9</td> <td class="tg-us36">15.000</td>
%   </tr> <tr>
%     <td class="tg-us36">11</td> <td class="tg-us36">16.667</td>
%   </tr>
% </table> </html>
%%
% From the table above, it can be noticed that there is absolutely no
% training error when the value of k is 1, however, k=1 is *not* the best
% choice for generalization of the model to unseen points, because no
% matter what manner the points are scattered in the graph, the training
% error for k=1 will always be zero, because for any particular point, that
% point itself will always be the nearest (with distance = 0). This
% observation tells us that k=1 is a clear case of *overfitting*, and while
% training results might be the best in overfitting, test-results aren't.
% Moreover, any *outlier* values have a high chance of always being wrongly
% classified.
%
% Therefore a relatively larger value of k has a high probability of
% classifying test data better than k=1. However, we cannot also have a
% very high value of k, as the training error peaks as we keep increasing
% the value of k. Therefore, a value between 3 to 7 should be optimal in
% the above scenario.

%% *Q6 kNNclassify_taxi Implementation, Classification and Boundary with different values of k [1, 3, 5]*
% Drawing boundary for Taxi-Cab algorithm uses the same function as drawing
% boundary for Euclidean algorithm *kNNdrawBoundary()*. Using the optional
% fourth argument, we can draw the Taxi-Cab boundary. More details about
% the optional argument, etc. can be read in the function definition which
% is present in this same folder.
%
% *Classification of the point (-17, 14) for various values of k*
load Data/data1.mat;
hFig = figure(6);
set(hFig, 'Position', [0 0 1500 500]);
for i = 1:3
    subplot(1,3,i);
    [~,~,OutputMessage] = kNNclassify_taxi (i*2-1, X, y, [-17, 14])
end
snapnow
close(hFig);

%%
% *Let us now compare the classifications done by Taxi-Cab algorithm and
% Euclidean algorithm:*
%
% <html><style type="text/css" >
% .tg{border-collapse:collapse;border-spacing:0}.tg td{font-family:Arial,
% sans-serif;font-size:14px;padding:10px
% 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black}.tg
% th{font-family:Arial,
% sans-serif;font-size:14px;font-weight:normal;padding:10px
% 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black}.tg
% .tg-ib2w{font-weight:bold;background-color:#000;color:#efefef}.tg
% .tg-0gpb{font-weight:bold;background-color:#000;color:#efefef;vertical-align:top}.tg
% .tg-yw4l{vertical-align:top}</style> <table class="tg">
%   <tr>
%     <th class="tg-ib2w">k</th> <th class="tg-ib2w">Euclidean
%     Algorithm</th> <th class="tg-0gpb">Taxi-Cab Algorithm</th>
%   </tr> <tr>
%     <td class="tg-031e">1</td> <td class="tg-031e">1</td> <td
%     class="tg-yw4l">1</td>
%   </tr> <tr>
%     <td class="tg-031e">3</td> <td class="tg-031e">1</td> <td
%     class="tg-yw4l">0</td>
%   </tr> <tr>
%     <td class="tg-031e">4</td> <td class="tg-031e">0</td> <td
%     class="tg-yw4l">1</td>
%   </tr>
% </table></html>
%
% As we can see, except at k=1, both the algorithms produce different results.

%%
% *Drawing The Boundary for This Algorithm in Comparision with Euclidean
% Algorithm*
%
% _Note that the small dots scattered in the graph are the original points_
% _from the data1.m file. These are plotted along with the boundary for_
% _reference._
load Data/data1.mat;
for i = 1:3
    kNNdrawBoundary(i*2-1, X, y, 1);
    snapnow;
    hold off;
    close;
end