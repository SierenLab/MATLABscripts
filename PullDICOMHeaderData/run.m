directory = 'C:\Experiments\DICOMdata\AP60459\TP3';
excelDirectory = strcat(directory,'\HeaderData.xlsx');
sheet = 1;

[dirs, txt] = CompareParameters(directory,excelDirectory,sheet);