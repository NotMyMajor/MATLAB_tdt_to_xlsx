%  Copyright (C) 2022  Rhys Switzer

%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.

%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.

function output_file = tdt_to_xlsx(tdt_file, options)

% Specify input arguments, name-value pairs, and default values.
arguments
   
    tdt_file (1,1) string {mustBeFile}
    options.XLSXFileName (1,1) string = tdt_file
    options.DestinationPath (1,1) string {mustBeFolder} = fileparts(tdt_file)
    options.SaveTXT (1,1) logical = 0
    options.WriteMode (1,1) string = 'replacefile'
    
end

% Convert .tdt file to .txt and save.
[~, tempfile] = fileparts(tdt_file);
options.XLSXFileName = append(tempfile, ".xlsx");
con_file = fullfile(options.DestinationPath, tempfile);
con_file = append(con_file, ".txt");
if not(exist(con_file, 'file'))
    copyfile(tdt_file, con_file);
else
    options.SaveTXT = 1;
end

% Read in cell array from .txt file.
cur_tdt = readcell(con_file, 'Delimiter', '\t');

% Get rid of any <missing> values to prepare for saving.
mask = cellfun(@(x) ismissing(x), cur_tdt, 'UniformOutput', false);
mask2 = cell2mat(cellfun(@(x) length(x)>1, cur_tdt, 'UniformOutput', false));
mask(mask2) = {false};
mask = cell2mat(mask);
cur_tdt(mask) = {NaN};

% Export cell array as .xlsx file to destination folder.
output_file = fullfile(options.DestinationPath, options.XLSXFileName);
writecell(cur_tdt, output_file, 'WriteMode', options.WriteMode);

% Delete the .txt file if indicated.
if not(options.SaveTXT)
    delete(con_file);
end

end % tdt_to_xlsx
