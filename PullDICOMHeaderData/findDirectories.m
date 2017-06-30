function dicomDirs = findDirectories(directory)

% collect files
paths = pullFiles(directory);
dicomDirs = cell(0);

no = 0;
% iterate until there are no files left
while no ~= length(paths)
    % increment counter
    no = no+1;
    
    % extract the extension from each file in paths
    [~,~,ext] = fileparts(paths{no});
    
    % compare extension with empty string to determine if it is a folder
    if strcmp('.dcm',ext)
        dicomDirs = [dicomDirs; base];
    elseif strcmp('',ext) || length(ext)>6
        % extract files from folder and put into paths
        tempPaths = pullFiles(paths{no});
        
        % check to see if it is full of dicom files
        [base,~,ext] = fileparts(tempPaths{1});
        if strcmp('.dcm',ext) || length(ext)>20
            dicomDirs = [dicomDirs; base];
        elseif strcmp('',ext) || length(ext)>6
            paths = [paths; tempPaths];
        else
        end
    end
end

% end function
end

