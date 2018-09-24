function [ gProp,X,Y,Z,gv, mirStack] = generalProp( imgStack, totallength, slicenumber, pixel, mikrometer )
%generalProp gives out the general properties of the image stack
%   'imgStack' is the stack of images
%   'totallength' is the total length of the image stack in µm 
%   'pixel' is the number of pixel which correspond to the µm in
%   'mikrometer'

%   'gProp' is a struct array with nanometer per pixel, slice thickness and
%   the thresholdvalue from 0-255 and 0-1


% Calculation of the nm per pixel ('npp')
npp = mikrometer * 1000 / pixel;
npp = round(npp,2);
gProp.NmPerPx = npp;

% Calculation of the slice thickness
sz = size(imgStack);
sliceThick = totallength * 1000/slicenumber;
lengthimgStack = sliceThick * (sz(3) - 1)/1000;
gProp.sliceThick = sliceThick;
gProp.lengthimgStack = lengthimgStack;

% Shows histogram to set the threshold value
%f = figure('Name','Histogram'); 
%img = histogram(imgStack);
%hold on;
%threshold = getpts(gca);
%gProp.threshold255 = threshold;
%gProp.threshold1 = threshold/255; 
%close(gcf);

% Makes the mesh for the isosurface function 
gv{1} = linspace(0,sz(1)*npp,sz(1));
gv{2} = linspace(0,sz(2)*npp,sz(2)); 
gv{3} = linspace(0,sliceThick*(sz(3)-1),sz(3));
[X,Y,Z] = meshgrid(gv{2},gv{1},gv{3});

% Mirrors the img Stack 
    for i = 1:sz(3)
    mirStack(:,:,i) = flip(imgStack(:,:,i));
    end
    
    
end

