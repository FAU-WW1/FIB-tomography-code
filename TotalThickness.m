function [ tpx, tnm, ts ] = TotalThickness( markers, angle, nmperpx )
%Calculates the total Thickness of the Image stack
%% markers = variable with the loaded tracks
% angle = angle between the outer tracking marks
% nmperpx = nm per pixel
% tpx = total thickness in px
% tnm = total thickness in nm
% ts = mean thickness per slice

% change the angle into radian
ang = deg2rad(angle);

%gpx = general pixel number per image
gpx = 3072;
for i = 1:length(markers)
    if markers(i).name == 'L' 
       l = i; 
    end
    if markers(i).name == 'R';
       r = i; 
    end 
end

lastI = length(markers(l).coordinates);
%% Get the coordinates and change them from Blender into pixel size

% xlf = x left first image
xlf = markers(l).coordinates(1,1)*gpx;
% xrf = x right first image
xrf = markers(r).coordinates(1,1)*gpx;
% xll = x left last image
xll = markers(l).coordinates(lastI,1)*gpx;
% xlr = x right last image
xrl = markers(r).coordinates(lastI,1)*gpx;

%% Calculate the distance between the two marks

%xf = Distance between the two outer marks at the first image
xf = xrf - xlf;
%xl = Distance between the two outer marks at the last image
xl = xrl - xll;

%% Divide the distance by 2 and calculate the tan
%lf length of the first image to the origin of the triangle
lf = (xf/2)/tan(ang/2);
%lf length of the last image to the origin of the triangle
ll = (xl/2)/tan(ang/2);

%% Total thickness

% complete thickness of the image stack in px
tpx = abs(ll - lf);
% in nm
tnm = tpx * nmperpx;

%% Thickness per slice

ts = tnm / (lastI-1)
end