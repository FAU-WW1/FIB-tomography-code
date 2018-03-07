function imagesOut = alignImages(imagesIn,tracks)
%aligns images based on the shifts of the tracked markers parsed in
%'tracks'. The shifts are relative to the first frame. The number of images
%needs to match the number of coordinates in each track. The coordinates of
%the track and images start bottom left. If multiple tracks are parsed, the
%average shift vector for each frame is calculated.

%track is a struct with track.name and track.coordinates

numTracks = length(tracks);
numFrames = length(tracks(1).coordinates(:,1));
numImages = size(imagesIn);
numImages = numImages(3);

stackSize = size(imagesIn);
res = stackSize(1:2);

if numImages ~= numFrames
    error('number of frames does not match between images and frames');
end


%% creating shift vectors
% calculate individual shift vectors for each track
for tr = 1:numTracks
    initialCoords = tracks(tr).coordinates(1,:);
    shift(tr).coordinates = tracks(tr).coordinates - repmat(initialCoords,numFrames,1);
end
% cretate average from individual shift vectors
avgShift = zeros(numImages,2);
for tr = 1:numTracks
    avgShift = avgShift + shift(tr).coordinates;
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
