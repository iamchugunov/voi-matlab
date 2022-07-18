function [desc] = read_json_describtion()
    if nargin == 0
        [file, path] = uigetfile('*.*');
        filename = fullfile(path,file);  
    end
    
    desc = jsondecode(fileread(filename));
end

