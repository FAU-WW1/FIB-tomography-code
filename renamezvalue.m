function [ thickness ] = renamezvalue( folder )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% files gets all the files inside the folder
files = dir (folder);

%Creates an empty cell array 
thickness = {};
f = 0; %prevents the cell array with empty cells
t = 0;  %for calculating the real thickness

for i = 1:length(files)
    %Divides the filename in different parts
    [~, fileN, ext] = fileparts(files(i).name);
    j = length(files(i).name); % j = Length of the name file
    if j > 10 % Just rename the file if j > 10
        %Get the slicename
        slicen = files(i).name(7:11);
        %Get the thickness z
        zthickstr = files(i).name(15:20);
        %converts the zthick in a number
        zthick = str2double(zthickstr);
        %Write in thickness the slicenumber 
        thickness {(i-f),1} = slicen;
        %Write in thickness the zthick
        thickness {(i-f),2} = zthick;
       
        %Calculate the real thickness of each slice
        zreal = zthick - t;
        t = t + zreal; 
        thickness {(i-f),3} = zreal;
        
    %renamefiles FUNCTION
        %reconstruct oldpath of the file
        oldname = fullfile (folder,fileN); %Builds the oldpath of the file
        B = {oldname, ext};
        oldpath = strjoin(B,''); % Add extension to the Folder Name
        
        %Construct new name of the file with new path
        newname = fileN(7:11); %searched for the numbers in the name
        newn = fullfile (folder, newname); %Addition of Folder directory and name (without extension)
        C = {newn,ext};
        newpath = strjoin(C,''); % Add extension to the Folder Name
        
        %moves & rename the file
        movefile([oldpath],[newpath]);
    
    else f = f + 1; %prevents the cell array with empty cells
    
    end

end

