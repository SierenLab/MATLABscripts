function DicomInfo = dicomfilereadCELLS(directory)
%DICOMFILEREADCELLS reads in the dicom information from an image and
%outputs it to a structure
%
% Example Input: 'C:\Experiments\TP\Subject\ScanType\Scans\Protocol\DICOM\'
% Example Output:       Filename: [1xx174 char]
%                    FileModDate: 'Date Time'
%                       FileSize: 'Number'
%                         Format: 'DICOM'
%                              etc.
%
% Author: Sami Dilger
% Modified by: Emily Hammond
% Date: 7/31/2013

% place all contents in directory folder into a structure
contents = dir(directory);

% acquire the individual directories for each slice/filename
dirs = strcat(directory,'\',contents(3).name);

% read dicom info from the first slice
%Dicom = dicomread(dirs{1});
DicomInfo = dicominfo(dirs);

end