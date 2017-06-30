function parameters = GetParameters(structure,names)
% GETPARAMETERS obtains specific parameters from a structure array given
% the defined fieldnames supplied by the names cell array.
%
% Example inputs: structure -> reference example DICOM output from
%                       dicomfilereadCELLS.m
%                 names: create a cell array of fieldnames seen in the
%                       DICOM data
%                       ['PatientName'
%                        'ProtocolName'
%                        'StudyDate'
%                        etc.           ]
% Example output: ['PatientName'    'John'
%                  'ProtocolName'   'T1-weighted'
%                  'StudyDate'      '20130101'
%                  etc.                             ]
%
% Author: Emily Hammond
% Date: 7/31/2013

% preallocate a cell matrix to store information
parameters = cell(length(names),2);
parameters(:,1) = names;

% rasterize through names array
for i = 1:length(names)
    try
        % check and see if looking for the patient name
        if strcmp(names{i},'PatientName')
            parameters{i,2} = structure.(names{i}).FamilyName;
        elseif strcmp(names{i},'AcquisitionMatrix') || strcmp(names{i},'PixelSpacing')
            parameters{i,2} = mat2str(structure.(names{i}));
        elseif strcmp(names{i},'StudyTime')
            start = structure.AcquisitionTime;
            finish = structure.SeriesTime;
            totalSeconds = (str2double(finish(3:4)) - str2double(start(3:4)))...
                *60 + (str2double(finish(5:6)) - str2double(start(5:6)));
            totalSeconds = mod(totalSeconds + 3600,3600);
            minutes = num2str(floor(totalSeconds/60));
            seconds = num2str(mod(totalSeconds,60));
            parameters{i,2} = strcat(minutes,'min ',seconds,'sec');
        elseif ~isempty(strfind(names{i},'Radio'))
            parameters{i,2} = structure.RadiopharmaceuticalInformationSequence.Item_1.(names{i});
        elseif strcmp(names{i},'SUVcorrection')
            parameters{i,2} = SUVcalc(structure);
        elseif strcmp(names{i},'DecayTime')
            scanTime = convert2Time(num2str(floor(str2num(PETdisplay.SeriesTime))));
            startTime = convert2Time(num2str(floor(str2num(PETdisplay.RadiopharmaceuticalInformationSequence.Item_1.RadiopharmaceuticalStartTime))));
            parameters{i,2} = scanTime - startTime; %in seconds
        else
            % place name and parameter into the parameters cell matrix
            parameters{i,2} = structure.(names{i});
        end
    catch
    end
end

end