function output_file = tdt_to_xlsx(tdt_file, options)

arguments
   
    tdt_file (1,1) string {mustBeFile}
    options.XLSXFileName (1,1) string = tdt_file
    options.DestinationPath (1,1) string {mustBeFolder} = fileparts(tdt_file)
    options.SaveTXT (1,1) logical = 0
    options.WriteMode (1,1) string = 'replacefile'
    
end

[~, tempfile] = fileparts(tdt_file);
options.XLSXFileName = append(tempfile, ".xlsx");
con_file = fullfile(options.DestinationPath, tempfile);
con_file = append(con_file, ".txt");
if not(exist(con_file, 'file'))
    copyfile(tdt_file, con_file);
else
    options.SaveTXT = 1;
end
cur_tdt = readcell(con_file, 'Delimiter', '\t');
mask = cellfun(@(x) ismissing(x), cur_tdt, 'UniformOutput', false);
mask2 = cell2mat(cellfun(@(x) length(x)>1, cur_tdt, 'UniformOutput', false));
mask(mask2) = {false};
mask = cell2mat(mask);
cur_tdt(mask) = {NaN};
output_file = fullfile(options.DestinationPath, options.XLSXFileName);
writecell(cur_tdt, output_file, 'WriteMode', options.WriteMode);
if not(options.SaveTXT)
    delete(con_file);
end

end % tdt_to_xlsx