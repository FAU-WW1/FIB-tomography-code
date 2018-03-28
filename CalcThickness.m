function [ thickness ] = CalcThickness(markers,angle,nmperpx)
% Calculates the thickness of each slice depending on the outer tracking
% marks. The variable angle defines the angle between the two tracking marks.
% The variable nmperpx defines the nm per px in the image.
% The resulting Matrix contain the pixel value and the corresponding
% nm value. The calculations based on 3072 px size image.

%% Searches for the 'L' and 'R' Tracking Marks inside the variable markers 
% and changes the size of the values in markers to Pixel

for i = 1:length(markers)
    if markers(i).name == 'L' 
       l = i; 
    end
    if markers(i).name == 'R';
       r = i; 
    end 
end
%change markers unit from Blender unit into the correct pixel size
markers(l).coordinates = markers(l).coordinates.*3072;
markers(r).coordinates = markers(r).coordinates.*3072;
 
%% Matrix which contains the Distance between the tracks
numFrames = length(markers(l).coordinates(:,1));
%creates a matrix wich contains the Distance between the tracks per image
DisTra = zeros (numFrames, 1);
%for loop gives for each image the Distance between the Tracks
for i = 1:numFrames
    xl = markers(l).coordinates(i,1);
    xr = markers(r).coordinates(i,1);
    %Limg = length between the marks for each image
    Limg = xr-xl;
    DisTra (i, 1) = Limg;
    
end
figure;plot(DisTra)
p = polyfit(1:numFrames,DisTra',1);

fitX = 1:numFrames;
fitY = fitX * p(1) + p(2);
hold on
plot(fitX, fitY);

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
% the angle between the outer tracking marks is stored in the variable
% anlge

a = deg2rad(angle);
b = length(deltaL);
thickness = zeros(b,2);
for i = 1:b;
    zi = deltaL(i,1)/tan(a/2);
    thickness(i,1) = zi;
    thickness(i,2) = zi*nmperpx;
end

end

