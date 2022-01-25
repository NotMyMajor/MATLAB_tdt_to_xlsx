# MATLAB_tdt_to_xlsx

Reads in a .tdt file, converts it to .txt, reads this in as a cell array, then saves the cell array as a .xlsx file. Includes optional arguments for specifying saved file name, destination path, writecell WriteMode, and whether to save the .txt converion. Returns the full path of the saved .xlsx file.

# Arguments
Optional arguments are specified using the following name-value arguments:
1. "XLSXFileName", some-string-here - A filename string that will be used as the name for the final .xlsx file. Defaults to the same name as the initial .tdt file.
2. "DestinationPath", some-string-here - A path string that indicated where the final .xlsx file is saved. If you choose to save the .txt file, it will be saved here as well. Defaults to the same directory as the initial .tdt file.
3. "SaveTXT", some-logical-here - A logical argument indicating whether you want to save the .txt conversion of the .tdt or have it automatically removed once the .xlsx has been written. Defaults to false.
4. "WriteMode", some-string-here - A string argument that is passed to the writecell function's "WriteMode" argument in MATLAB to change the behavior of how writecell chooses to write or overwrite existing files. Defaults to 'replacefile'.

In cases where SaveTXT is set to false (or defaults), but a .txt already exists at the given save destination, the function will not delete the existing .txt file. This behavior can be changed by disabling lines 19 and 20 in the code.

# Output
The function saves a .xlsx file and (optionally) a .txt conversion of the initial .tdt file. It also returns the full path to the saved .xlsx file.

# Examples
Calling with default arguments and no return:
```MATLAB
tdt_to_xlsx(tdt_file);
```
Calling with return and optional arguments:
```MATLAB
path_to_saved_xlsx = tdt_to_xlsx(tdt_file, "SaveTxt", 1, "WriteMode", "overwritesheet")
```
# Limitations
My current method of checking for and replacing "missing" values is a little convoluted and could probably be a lot better. I ran into issues with cellfun and ismissing triggering on any string with spaces. Feel free to make a pull request if you have a better way of handling it.

Thanks for checking this out!
