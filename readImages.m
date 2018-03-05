function imageStack = readImages()
%loads a number of *.tif images into a variable

[filename, pathname, filterindex] = uigetfile( ...
{  '*.tif','*.tif images files'}, ...
   'Pick tif images', ...
   'MultiSelect', 'on');

numFiles = length(filename);

for im = 1:numFiles
    imageStack(:,:,im) = imread([pathname filename{im}]);
end

end