directory = '\\itf-rs-store05.hpc.uiowa.edu\ct-data\animal\AP20375,AP20375\20130206,2,Private^73_SIEREN_PHENOTYPING_CANCER_PIG_2_LIZ_(Adult)';
excelDirectory = 'H:\header.xlsx';
%excelDirectory = 'H:\Experiments\TP53het_Silica\Images\DICOMHeaderInformation.xlsx';
sheet = 1;

[dirs, txt] = CompareParameters(directory,excelDirectory,sheet);