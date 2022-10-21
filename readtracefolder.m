function [out] = readtracefolder()
    dir1 = uigetdir;
    files = dir(dir1);
    files = files(3:end);
    for i = 1:length(files)
%     for i = 1:100
        i
        filename = fullfile(files(i).folder,files(i).name);
        [poits] = readtracefile(filename);
        out(i) = poits;
    end
end

