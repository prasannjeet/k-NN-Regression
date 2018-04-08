%% Exercise 4: Assignment 1
% This document contains the solution to VG exercise of the assignment 1.
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

%% Generating the Heat Map
%
% Note that I have used two features from the sample data provided to us
% (data3.mat) to generate the heat map, as it might be insightful to
% observe the heat-map of real data, rather than looking at the heatmap of
% a randomly generated data.
%
% The features used for generating heat-map are:
%
% # Wheel-Base (Column _1_ in data3.mat), and
% # Engine-Size (Column _6_ in data3.mat).
%
% Both the data mentioned above are normalized in the function
% implementation.

% Clearing the workspace, loading the data, then selecting the data-sets
% as described above.
clear all;
load Data/data3.mat
heatX = train_X(:,[1,6]);

%% The Gradient Value and K
% Gradient value can be specified below. The returned matrix will be a two
% dimensional square matrix with dimensions G*G. Thus, a total of G*G test
% sets are generated on which k-NN regression is applied and the results
% are returned in a square matrix. *A higher value of G will result in
% less-pixelated heat map, however, it will take longer to execute.*
% No loops are used. The data sets will always be normalized in the range
% of 0-G, as G will be the length and height of the graph. K was randomly
% chosen to be 12. Both the values can be changed to see varied results.
G = 500;
k = 12;

%% Generating Heat-Map 
% Note that below function will accept any two features (from any data
% source) to create a heat matrix, as long as there are only two features
% and are distributed in two columns, and the second parameter contains the
% training data solution.
[heatMatrix] = heatMapGenerator(k, heatX, train_y, G);

%% Plotting the Heat-Map in a 2-D graph
% Following is the generated graph:
hFig1 = figure(4);
h1 = axes;
imagesc(heatMatrix), colorbar, colormap(flipud(hot));
set(h1, 'XAxisLocation', 'Top');
title('Heat Map for Car Prices');
xlabel('Wheel-Base');
ylabel('Engine-Size');
snapnow;
close(hFig1);

%%
% The heatmap generated above is exactly as we expected it to be. As can be
% observed in the sample data, cost of the vehicle increase when wheel-base
% or engine size is increased, we can observe the same trend in the image
% above. Note that the range of X and Y axis are normalized according to
% the value of G chosen by us.
%
% *Additionally*, since I chose the value of G as 500, a lower value of G
% would have created a pixelated graph as below. However, the trends would
% not change.

heatMatrix2 = heatMatrix([1:ceil(G/100):G], [1:ceil(G/100):G]);
hFig2 = figure(5);
h1 = axes;
imagesc(heatMatrix2), colorbar, colormap(flipud(hot));
set(h1, 'XAxisLocation', 'Top');
title('Heat Map for Car Prices');
xlabel('Wheel-Base');
ylabel('Engine-Size');
snapnow;
close(hFig2);

%% Generating 3-D surface heat map
% Note that to generate a surface plot, the size of the matrix had to be
% proportionally minimized to reduce the enumber of edges (the black lines
% in the graph that show the depth), which made the graph un-interpretable.
% However, the trends shown will be exactly the same.

heatMatrix3 = heatMatrix([1:ceil(G/10):G], [1:ceil(G/10):G]);
hFig3 = figure(6);
h1 = axes;
surf(heatMatrix3), colorbar, colormap(flipud(hot));
set(h1, 'XAxisLocation', 'Top');
title('3-D Heat Map for Car Prices');
xlabel('Wheel-Base');
ylabel('Engine-Size');
snapnow;
close(hFig3);

% Rotated Graph

hFig4 = figure(7);
h1 = axes;
theGraph = surf(heatMatrix3); colorbar, colormap(flipud(hot));
set(h1, 'XAxisLocation', 'Top');
title('3-D Heat Map for Car Prices (Rotated)');
xlabel('Wheel-Base');
ylabel('Engine-Size');
direction = [0 0 1];
rotate(theGraph,direction,-75)
snapnow;
close(hFig4);

%%
% Function used to create the heat-map was *imagesc()*, and
%
% The function used to create the 3d heat map was *surf()*.
%
% I chose these functions as they don't require any new library inclusions
% and moreover, they are easy to use. *surf()* can also be easily rotated
% and snapped for different representations. Moreover, I changed the
% colormap to *red* to signify that a _heatmap_ is drawn. However, I prefer
% the idea of representing the heatmap in two dimensions as we already have
% color labels which makes us understand which area of the graph has a
% higher price. Furthermore, using less data-sets to plot the the heatmap,
% in a way, gave me an idea of how screen resolutions (eg. in
% mobile-phones) work, where less dots per inches (dpi) phones creates
% images with lesser quality as compared to phones with high dpi.