function renameFiles(directory, action, phrase, endIdentifier)
% Author: Emily Hammond
% Date: 2017.06.07

% Purpose: Rename image (including mhd) files by removing or inserting text
% into their filenames. Works best with the same type of file and uniform
% filenames. It will add/remove text to all files within the folder given
% they have the appropriate endIdentifier text.
%
% Inputs:
%   - directory: location to folder that contains the files for renaming
%   - action: 'insert' or 'remove' designating the desire to insert text
%   into the filename or remove text from the filename
%   - phrase: the text to remove or insert
%   - endIdentifier: text within the filename that denotes where the text
%   should be inserted or where the text that should be removed is located
%
% Example:
%   renameFiles('C:\path\to\directory','insert','CTProtocolName','.mhd')

% more to directory
cd(directory);

% gather files | first 2 are place holders
files = dir(directory);
L = length(files);

% cell array to hold old and new names
names = cell(L-2,2);

% parse through files
for i = 3:L
    
    % gather old names
    oldname = files(i,1).name;
    names{i-2,1} = oldname;
    
    if strcmp(action,'insert')
        
        % find location to enter in phrase
        loc = strfind( files(i,1).name, endIdentifier );
        
        if( isempty(loc) )
            continue
        end
        
        % create new string name
        newname = strcat(oldname(1:loc(1)-1),phrase,oldname(loc(1):end));
        names{i-2,2} = newname;
        
        % rename files
        [~, ~, ~] = movefile(oldname,newname);
        
        % determine if these are mhd files
        if( strfind(oldname,'mhd') )
            
            if( strfind(endIdentifier,'.mhd') )
                endIdentifier = '.raw';
            end
            
            % open mhd file
            fin = fopen(newname,'r');
            
            % read in lines of file
            idk = 0;
            lines = cell(15,1);
            while( ~feof(fin) )
                idk = idk+1;
                lines{idk} = fgetl(fin);
                if( ~isempty( strfind( lines{idk}, 'ElementDataFile' ) ) )
                    loc2 = strfind( lines{idk}, endIdentifier );
                    lines{idk} = strcat('ElementDataFile = ',newname(1:end-4),endIdentifier);
                end
            end
            
            fclose(fin);
            
            % write out lines to file
            fout = fopen(newname,'w+');
            for k = 1:length(lines)
                fprintf(fout,'%s\n',lines{k});
            end
            fclose(fout);
        end
    end
        
    if strcmp(action,'remove')
        
        % find location to enter in phrase
        locStart = strfind( files(i,1).name, phrase );
        locEnd = strfind( files(i,1).name, endIdentifier );
        
        if( isempty(locEnd) || isempty(locStart) )
            continue
        end
        
        % create new string name
        newname = strcat(oldname(1:locStart(1)-1),oldname(locEnd(1):end));
        names{i-2,2} = newname;
        
        % rename files
        [~, ~, ~] = movefile(oldname,newname);
        
        % determine if these are mhd files
        if( strfind(oldname,'mhd') )
            
            if( strfind(endIdentifier,'.mhd') )
                endIdentifier = '.raw';
            end
            
            % open mhd file
            fin = fopen(newname,'r');
            
            % read in lines of file
            idk = 0;
            lines = cell(15,1);
            while( ~feof(fin) )
                idk = idk+1;
                lines{idk} = fgetl(fin);
                if( ~isempty( strfind( lines{idk}, 'ElementDataFile' ) ) )
                    loc2Start = strfind( lines{idk}, phrase );
                    loc2End = strfind( lines{idk}, endIdentifier );
                    lines{idk} = strcat('ElementDataFile = ',newname(1:end-4),endIdentifier);
                end
            end
            
            fclose(fin);
            
            % write out lines to file
            fout = fopen(newname,'w+');
            for k = 1:length(lines)
                fprintf(fout,'%s\n',lines{k});
            end
            fclose(fout);
        end
    end
end

return
