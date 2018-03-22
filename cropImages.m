function imagesOut = cropImages(imagesIn, referenceImageNumber)
%GUI pops up that lets you select your area of interest. Choose reference
%image number based on which image allows you to see what you want in your
%reconstruction (such as a precipitate)
sz = size(imagesIn);
res = sz(1:2);
numImages = sz(3);

referenceImage = imagesIn(:,:,referenceImageNumber);

img = imshow(referenceImage);
hold on;

f = figure('Name','uncropped data');
img = imshow(referenceImage);
hold on;

rect = getrect(gca);
r = rectangle('Position',rect,'EdgeColor',[1 1 0],'LineWidth',5);
pause(3);

%create variable to write cropped images into

for i=1:numImages
    imagesOut(:,:,i) = imcrop(imagesIn(:,:,i), rect);
end
delete(f);

f = figure;
hold on

for i=1:numImages
imshow(imagesOut(:,:,i))
end

end
