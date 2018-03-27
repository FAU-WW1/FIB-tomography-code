%% Große Ziel isosurface und patch funktionieren

%% Größe von ausschnitt
sz = size(cropSE);

%% Berechnung der Gridvektoren
nmPerPixel = 4;
sz = size(cropSE);
% sz = [141 301 153] ([high width ZTiefe])
% slice thickness in nm
sliceThick = 9.5757;

%Höhe des Stacks
gv{1} = linspace(0,nmPerPixel*sz(1),sz(1));
%erschafft einen Vektor der von 0 bis zur Höhe/Breite des Bildes geht. Die
%Pixelanzahl wird dabei in nm umgerechnet. 
%Das letzte sz(1) sagt aus wie viele einzelne Punkte der Vektor hat.
%Raus kommt ein Vektor mit sz(1) Punkten die jeweils eine Zahl in nm
%beeinhaltet.
% sz(1) = 141

%Breite
gv{2} = linspace(0,nmPerPixel*sz(2),sz(2)); 

%Z Tiefe
gv{3} = linspace(0,sliceThick*sz(3),sz(3));
% rechnet dabei die Dicke der einzelnen Slice mitrein.

%% Zeige ein Histogramm um Schwellenwert zu finden
histogram(single(cropSE(:)),255);

%% mit Meshgrid
[X,Y,Z] = meshgrid( gv{2}, gv{1},gv{3});
[F, V] = isosurface(X,Y,Z,cropSE,0.25);

%% mit patch

pa = patch('Faces', F, 'Vertices', V, 'FaceColor','red');
%% Versuch aus Matlab
[X,Y,Z] = meshgrid( gv{2}, gv{1},gv{3});
isoF = isosurface(X,Y,Z,cropSE);

%% nur Zeichnen
pa10 = patch(isoF);
isonormals(X,Y,Z,cropSE,pa10)
pa10.FaceColor = 'none';
pa10.EdgeColor = 'blue';
daspect([1 1 1])
view(3); 
axis tight
camlight 
lighting gouraud