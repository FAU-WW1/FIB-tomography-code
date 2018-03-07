function markers = loadTracks(fileNames)
%% loading in *.csv files from marker tracking and convert coordinate system
% coordinate system is still relative (not in pixels)
%fileNames of tracking is parsed as cell array {'L.csv','ML.csv',...}

%if no file names are parsed, use UI to get them

[filename, pathname, filterindex] = uigetfile( ...
    {  '*.csv','*.cvs track mark files'}, ...
    'Pick track mark traces', ...
    'MultiSelect', 'on');

if ~iscell(filename)
    filename = {filename};
end

numFiles = length(filename);


for tr = 1:numFiles
    [filepath,name,ext] = fileparts(filename{tr});
    markers(tr).name = name;
    
    markers(tr).coordinates = csvread([pathname filename{tr}]); 
end
