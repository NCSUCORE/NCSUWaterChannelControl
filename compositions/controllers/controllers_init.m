% Script to initialize controllers
% This script works by searching the controllers folder, then creating a
% variant object in the base workspace for each of the found directories.
basePath = fileparts(which('WaterChannelControl.prj'));
files = dir(fullfile(basePath,'compositions','controllers')); % Search the folder
files = files([files.isdir]); % Get directories
files = files(3:end); % Delete first two which are always '.' and '..'
files = files(~strcmpi({files.name},'template')); % excluding the template file

for ii = 1:length(files)
    % Create the Simulink.Variant object
    evalin('base',...
        sprintf('VSS_%s = Simulink.Variant(''CONTROLLER==%d'');',...
        files(ii).name,ii));
    % If this is the constant setpoints controller, set that as the active
    % variant.  This essentially sets the default.
    if strcmpi(files(ii).name,'CONSTANTSETPOINTS')
       evalin('base',sprintf('CONTROLLER = %d;',ii))
    end
end

clearvars ii basePath files