% function to pull files from a directory and store them in a cell
function paths = pullFiles(directory)

files = dir(directory);
paths = cell(size(files));
for i = 1:length(files)
    paths{i} = strcat(directory,'\',files(i).name);
end
paths = paths(3:end);

end
