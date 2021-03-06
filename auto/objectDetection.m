% This program finds an image in another one
% It comes with the CV tool box in matlab

% Step 1: read in images
boxImage = rgb2gray(boxImage1);

% Step 2: Detect Feature Points
boxPoints = detectSURFFeatures(boxImage);

% Step 3: Extract Feature Descriptors
[boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);

% Step 4: Find Putative Point Matches
boxPairs = matchFeatures(boxFeatures, sceneFeatures);

% Display putatively matched features. 
matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);

% Step 5: Locate the Object in the Scene Using Putative Matches
[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');

% Get the bounding polygon of the reference image.
boxPolygon = [1, 1;...                           % top-left
        size(boxImage, 2), 1;...                 % top-right
        size(boxImage, 2), size(boxImage, 1);... % bottom-right
        1, size(boxImage, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon

% Transform the polygon into the coordinate system of the target image.
% The transformed polygon indicates the location of the object in the
% scene.
newBoxPolygon = transformPointsForward(tform, boxPolygon);    

%[xmin ymin width height]
width = newBoxPolygon(2,1) - newBoxPolygon(1,1);
height = newBoxPolygon(4,2) - newBoxPolygon(1,2);
crop_rect = [newBoxPolygon(1,1), newBoxPolygon(1,2), width, height]; 
