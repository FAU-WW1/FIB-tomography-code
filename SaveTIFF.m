function [ ] = SaveTIFF( folderName, imgStack )
%Saves the images in a new folder
%   folderName must be written in the function as string: 'folderName'

%create new folder and change storage path to the new folder
oldpath = cd;
mkdir (folderName);
cd (folderName);

%save each image in the new folder
for K=1:length(imgStack(1, 1, :))
   outputFileName = sprintf('img_%d.tif',K);
   imwrite(imgStack(:, :, K), outputFileName);
end

%change the storage folder back
cd ..;
end

