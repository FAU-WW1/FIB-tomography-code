function [ thicknesscell, thickstruct] = renamezvalue()
%This function opens a GUI. The user has to select the images for the
%reconstruction. The function renames the images with the slicenumber of
%each image and stores the image again in the same folder. 
%The z value inside the name is stored in a struct array and as a cell
%array. Additionally the function calculates the real thickness of each
%slice.

% files gets all the files inside the folder

[filename, pathname, ~] = uigetfile( ...
    {  '*.tif','*.tif images collected by Atlas'}, ...
    'Select the images for the image stack, please', ...
    'MultiSelect', 'on');
%files = dir(filename);
n = 'name';
files = cell2struct(filename, n, 1);
%Creates an empty cell array 
t = 0;  %for calculating the real thickness

for i = 1:length(files)
    %Divides the filename in different parts
    [~, fileN, ext] = fileparts(files(i).name);
    
        %Get the slicename
        slicen = files(i).name(7:11);
        %Get the thickness z
        zthickstr = files(i).name(15:20);
        %converts the zthick in a number
        zthick = str2double(zthickstr);
        %Write in thickness the slicenumber 
        thickstruct(i).SliceNumber = slicen;
        %Write in thickness the zthick
        thickstruct(i).TotalThickness = zthick;
       
        %Calculate the real thickness of each slice
        zreal = zthick - t;
        t = t + zreal; 
        thickstruct(i).ThicknessPerSlice = zreal;
        
        %Create a Cell array with the thickness
        thicknesscell{i,1} = slicen;
        thicknesscell{i,2} = zthick;
        thicknesscell{i,3} = zreal;
        
       %renamefiles FUNCTION
        %reconstruct oldpath of the file
        oldname = fullfile (pathname,fileN); %Builds the oldpath of the file
        B = {oldname, ext};
        oldpath = strjoin(B,''); % Add extension to the Folder Name
        
        %Construct new name of the file with new path
        newname = fileN(7:11); %searched for the numbers in the name
        newn = fullfile (pathname, newname); %Addition of Folder directory and name (without extension)
        C = {newn,ext};
        newpath = strjoin(C,''); % Add extension to the Folder Name
        
        %moves & rename the file
        movefile([oldpath],[newpath]);
    
end

end

