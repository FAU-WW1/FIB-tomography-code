%% Reconstruction Tutorial
% This tutorial script guides you through the Matlab functions
% you can do it step by step by clicking in the box (it appears yellow) and
% hitting Strg/Ctrl + Enter to run the single step

%% Define the Variables that are used in the functions
totallength = 1.62; %Write here the totallength of the image stack in µm (use . to separate)
totalslicenumber = 50; %Write the total slice number
pixel = 153.6;      % Write down how many pixel correspond to the variable mikrometer
mikrometer = 1;     % Write down the mikrometer number corresponding to the variable pixel
threshold = 132;    % Type in the threshold value for the isosurface 
                    % (threshold value between ionic liquid and material)

%% Loads the images into Matlab
imgStack = readImages();

%% calculate the general properties
[ gProp,X,Y,Z,gv, mirStack] = generalProp(imgStack, totallength, totalslicenumber, pixel, mikrometer);

%% calculate the isosurface
[F, V] = isosurface(X,Y,Z,imgStack,threshold);

%% isoF (saves the results from the isosurface function in one variable)
isoF.vertices = V;
isoF.faces = F;

% draw the patch 
figure;
pa = patch(isoF);
isonormals(X,Y,Z,mirStack,pa)
pa.FaceColor = 'none';
pa.EdgeColor = 'blue';
daspect([1 1 1])
view(3); 
axis tight
camlight 
lighting gouraud

%% Save the isosurface as an .obj
patch2obj(isoF);


%% Builds a volume stored in a .raw file after the generalProp function
volume2RAW(mirStack,gv);
