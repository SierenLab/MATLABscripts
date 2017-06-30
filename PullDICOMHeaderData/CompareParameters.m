function [directories,text] = CompareParameters(directory,excelDirectory,sheet)
%COMPAREPARAMETERS gathers parameters read from DICOM fileheaders from a
%variety of files. (Specifically used for the MRI data for the phenotyping
%study)
%
% Example inputs: directory -> 'C:\Experiments\TP\Subject\ScanType\Scans'
%                 scanNumbers = [2,3,9,11,16,18,19,20,21,22]
%                   (refer to which folders in the directory you want to 
%                   pull data from. If all folders are desired, input
%                   'all')
%                 excepDirectory -> excel file that contains the names of
%                   the desired header information in a column vector
%                 sheet -> sheet in excel file that had the column vector
% Example output: ['PatientName'    'Name 1'        'Name 1'       
%                  'ProtocolName'   'T1-weighted'   'T2-weighted'
%                  'StudyDate'      '20130101'      '20130101'
%                  etc.                                              ]
%
% Author: Emily Hammond
% Date: 7/31/2013

directories = findDirectories(directory);
directories = strcat(directories,'\');

% get wanted fieldnames from excel spreadsheet
[~,text,~] = xlsread(excelDirectory,sheet);
names = text(:,1);

% preallocate parameter matrix
j = size(text,2);
text = [text(:,1) cell(length(text),length(directories))];

% obtain the dicom information for each proper scan
for i = 1:length(directories)
    DicomInfo = dicomfilereadCELLS(directories{i});
    
    % obtain the proper parameters and place into complete matrix
    result = GetParameters(DicomInfo,names);
    text(:,j+1) = result(:,2);
    j=j+1;
end

directoriesTmp = cell(1,size(text,2)-1);
directoriesTmp((end-length(directories)+1):end) = directories;
text = ['Folder' directoriesTmp; text];

% place them in the excel spreadsheet
xlswrite(excelDirectory,text,sheet);

end