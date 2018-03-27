%% Calculation of the grid vector
nmPerPixel = 4;
sz = size(cropSE);
% sz = [141 301 153] ([high width ZTiefe])
% slice thickness in nm
sliceThick = 40;

%hight of the stack
gv{1} = linspace(0,nmPerPixel*sz(1),sz(1));
%creates a vector from 0 up to the Hight / width of the image. 
%The pixel will be turned into nm. 
%the last sz(1)gives the number of points of the vector.
%gv{1} is a vector with sz(1) points.
%Each point contains a number in nm.
%width
gv{2} = linspace(0,nmPerPixel*sz(2),sz(2)); 
%Z depth
gv{3} = linspace(0,sliceThick*sz(3),sz(3));

%% show Histogramm to find the thresholdvalue
histogram(single(cropSE(:)),255);

%% Calculate meshgrid and isosurface
[X,Y,Z] = meshgrid( gv{2}, gv{1},gv{3});
[F, V] = isosurface(X,Y,Z,cropSE,0.25);

%% with patch

pa = patch('Faces', F, 'Vertices', V, 'FaceColor','red');
%% Attempt from the matlab webpage
[X,Y,Z] = meshgrid( gv{2}, gv{1},gv{3});
isoF = isosurface(X,Y,Z,cropSE);

%% Just draw the result
pa10 = patch(isoF);
isonormals(X,Y,Z,cropSE,pa10)
pa10.FaceColor = 'none';
pa10.EdgeColor = 'blue';
daspect([1 1 1])
view(3); 
axis tight
camlight 
lighting gouraud