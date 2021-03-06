function imagesOut = alignImages(imagesIn,tracks)
% aligns images based on the shifts of the tracked markers parsed in
% 'tracks'. The shifts are relative to the first frame. The number of images
% needs to match the number of coordinates in each track. The coordinates of
% the track and images start bottom left. If multiple tracks are parsed, the
% average shift vector for each frame is calculated.

% track is a struct with track.name and track.coordinates

%% Searches for the 'ML', 'MM and 'MR' Tracking Marks inside the variable tracks
for i = 1:length(tracks)
    if tracks(i).name == 'ML' 
       ml = i; 
    end
    if tracks(i).name == 'MM';
       mm = i; 
    end 
     if tracks(i).name == 'MR';
       mr = i; 
    end 
end

%% create a cell Array called TrackNumber which has the numbers corresponding to the 
% struct array tracks

numTracks = 1;
    if exist('ml') == 1
       TrackNumber(numTracks,1) = ml;
       numTracks = numTracks+1;
    end
    if exist('mm') == 1
       TrackNumber(numTracks,1) = mm;
       numTracks = numTracks+1;
    end
    if exist('mr') == 1
       TrackNumber(numTracks,1) = mr;
    end

numFrames = length(tracks(ml).coordinates(:,1));
numImages = size(imagesIn);
numImages = numImages(3);

stackSize = size(imagesIn);
res = stackSize(1:2);

if numImages ~= numFrames
    error('number of frames does not match between images and frames');
end

%% creating shift vectors
% calculate individual shift vectors for each track
for nt = 1:numTracks
    tr = TrackNumber(nt,1);
    initialCoords = tracks(tr).coordinates(1,:);
    shift(nt).coordinates = tracks(tr).coordinates - repmat(initialCoords,numFrames,1);
end
% cretate average from individual shift vectors
avgShift = zeros(numImages,2);
for nt = 1:numTracks
    avgShift = avgShift + shift(nt).coordinates;
end
avgShift = avgShift./numTracks;

%translate relative shift (0-1) to pixel shift
avgShift = round([uminus(avgShift(:,1) * res(1)), avgShift(:,2) * res(2)]);

%% shift images based on shift vectors
%images are padded with black after shift.
for im = 1:numFrames
    imagesOut(:,:,im) = imtranslate(imagesIn(:,:,im),avgShift(im,:));
end

end
