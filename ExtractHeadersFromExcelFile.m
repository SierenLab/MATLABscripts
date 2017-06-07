function ExtractHeadersFromExcelFile(fullFilename, headersFilename)
% Author: Emily Hammond
% Date: 2017/06/05
% Purpose: Extract data from excel spreadsheets

% Inputs:
%   - fullFilename: Excel spreadsheet that contains the full amount of data
%             StudyID	Feature1	Feature2	Feature3	Feature4
%                 A     0.53766     -0.86365	0.84037     0.52006
%                 B     1.83388     0.077359	-0.8880     -0.0200
%                 C     -2.2588     -1.21411	0.10009     -0.0347
%                 D     0.86217     -1.11350	-0.5445     -0.7981
%                 E     0.31876     -0.00684	0.30352     1.01868
%                 F     -1.3076     1.532630	-0.6003     -0.1332
%                 G     -0.4335     -0.76966	0.48996     -0.7145
%                 H     0.34262     0.371378	0.73936     1.35138
%   - extractFilename: Excel speadsheet containing the desired headers/columns to
%     extract
%             StudyID	Feature1	Feature3	Feature4
%                 A     
%                 C     
%                 D     
%                 G     
% 
% Outputs:
%   - Excel spreadsheet containing the information from the full
%     dataset for the desired headers (saved as
%     headersFilename-extracted.xlsx)
%             StudyID	Feature1	Feature3	Feature4
%                 A     0.53766     0.84037     0.52006
%                 C     -2.2588     0.10009     -0.0347
%                 D     0.86217     -0.5445     -0.7981
%                 G     -0.4335     0.48996     -0.7145

% read in data
[~,~,rawFull] = xlsread(fullFilename);
[~,headersHead,~] = xlsread(headersFilename);

% gather desired headers for the rows and columns
rowsHeaders = headersHead(:,1);
colsHeaders = headersHead(1,:);
rowsFull = rawFull(:,1);
colsFull = rawFull(1,:);

% create vectors to store the indicies for rows/columns
rowIdx = zeros(length(rowsHeaders),1);
colIdx = zeros(1,length(colsHeaders));
flag = 1; % signaling all headers have been found

% find appropriate row indices in full dataset
for ri = 1:length(rowsHeaders)
    for rj = 1:length(rowsFull)
        if strcmp(rowsHeaders{ri},rowsFull{rj})
            rowIdx(ri) = rj;
            continue
        end
    end
    
    % print out message if header does not exist
    if rowIdx(ri) == 0
        fprintf('%s header does not exist.\n Please fix and rerun program.\n',rowsHeaders{ri});
        flag = 0;
    end
end

% find appropriate colunm indices in full dataset
for ci = 1:length(colsHeaders)
    for cj = 1:length(colsFull)
        if strcmp(colsHeaders{ci},colsFull{cj})
            colIdx(ci) = cj;
            continue
        end
    end
    
    % print out message if header does not exist
    if colIdx(ci) == 0
        fprintf('%s header does not exist.\n Please fix and rerun program.\n',colsHeaders{ci});
        flag = 0;
    end
end

% continue if all headers have been found
if flag
    % extract data and store in separate variable
    ssExtracted = rawFull(rowIdx,colIdx);

    % write out to file - append ssFull filename with extracted
    loc = strfind(headersFilename,'.');
    filename = strcat(headersFilename(1:loc(end)-1),'-extracted',headersFilename(loc(end):end));
    xlswrite(filename,ssExtracted);
end

return