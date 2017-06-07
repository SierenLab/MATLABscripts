README.txt

These scripts pull data from DICOM headers.

1. Create an excel spreadsheet that contains a list of tags (in the first column) that you want to pull from the DICOMs.HeaderData.xlsx contains a list of common tags that will pull the appropriate information from MR and CT DICOM files.
Modality
Manufacturer
ManufacturerModelName
PatientName
PatientID
StudyDate
StudyTime
SeriesDescription
SeriesTime
AcquisitionTime
PatientWeight
CTParameters
KVP
XrayTubeCurrent
Exposure
SpiralPitchFactor
PETParameters
SeriesType
Radiopharmaceutical
DecayTime
RadiopharmaceuticalStartTime
RadionuclideTotalDose
RadionuclideHalfLife
Units
DecayCorrection
SUVcorrection
MRIParameters
MRAcquisitionType
RepetitionTime
EchoTime
FlipAngle
VariableFlipAngleFlag
NumberOfAverages
NumberOfPhaseEncodingSteps
EchoTrainLength
InPlanePhaseEncodingDirection
SAR
RECONParameters
ConvolutionKernel
ReconstructionMethod
ReconstructionDiameter
FieldOfViewShape
CorrectedImage
AcquisitionMatrix
Rows
Columns
PixelSpacing
SliceThickness

3. Open MATLAB and define:
   - directory = '/path/to/directoryContainingDICOMFolders' (will parse through all folders until it finds the ones that contain DICOM files)
   - excelDirectory = '/path/to/excelSpreadsheet/excelName.xlsx'
   - sheet = scalar of sheet that contains the column of tag names

4. Run CompareParameters function
   - CompareParameters(directory,excelDirectory,sheet)

5. Open excel spreadsheet to find all the DICOM tags pulled from each scan