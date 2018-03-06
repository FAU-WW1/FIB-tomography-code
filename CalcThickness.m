function [ thickness ] = CalcThickness(angle,nmperpx)
% Calculates the thickness of each slice depending on the outer tracking
% marks. The variable angle defines the angle between the two tracking marks.
% The variable nmperpx defines the nm per px in the image.
% The resulting Matrix contain the pixel value and the corresponding
% nm value. The calculations based on 3072 px size image.

%% Load Tracks
[filename, pathname, ~] = uigetfile( ...
    {  '*.csv','*.cvs track mark files'}, ...
    'Pick the tracks to calculate the thickness', ...
    'MultiSelect', 'on');
numFiles = length(filename);
if ~iscell(filename)
    filename = {filename};
end

for tr = 1:numFiles
    [pathname,name,~] = fileparts(filename{tr});
    markers(tr).name = name;
        markers(tr).coordinates = csvread([pathname filename{tr}]); 
        %change markers unit from Blender unit into the correct pixel size
        markers(tr).coordinates = markers(tr).coordinates.*3072;
end
 
%% Matrix which contains the Distance between the tracks
numFrames = length(markers(1).coordinates(:,1));
%creates a matrix wich contains the Distance between the tracks per image
DisTra = zeros (numFrames, 1);
%for loop gives for each image the Distance between the Tracks
for i = 1:numFrames
    xl = markers(1).coordinates(i,1);
    xr = markers(2).coordinates(i,1);
    yl = markers(1).coordinates(i,2);
    yr = markers(2).coordinates(i,2);
    Limg = sqrt((xr-xl)^2 + (yr-yl)^2);
    DisTra (i, 1) = Limg;
end

%% calculate delta L 
% delta L is a matrix with one column. The values in the cells correspond to
% the difference in the Distances between the Tracks between two images.
% The values are divided by 2 because they are getting smaller on both sides

deltaL = zeros(numFrames-1,1);
for i = 1:(numFrames-1)
    l = DisTra(i,1) - DisTra(i+1,1);
    deltaL (i,1) = (l/2);
end

%% calculate from deltaL the thickness between the slices
% the last slice has no thickness.
% the angle between the outer tracking marks is 60°

a = deg2rad(angle);
b = length(deltaL);
thickness = zeros(b,2);
for i = 1:b;
    zi = tan(a)*deltaL(i,1);
    thickness(i,1) = zi;
    thickness(i,2) = zi*nmperpx;
end

end

