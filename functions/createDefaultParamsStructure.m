function createDefaultParamsStructure()
% This function creates the params structure in the base workspace and then
% saves it to paramsData/params.mat

% Syntax is createParam(name,value,min,max,description)

createParam('roiSideHoldPosition_px',[500 500],0,2040,...
    'Default image [row col] coordinates of roi in side camera.')

createParam('roiBottomAHoldPosition_px',[500 500],0,2040,...
    'Default image [row col] coordinates of roi in bottom camera for dot set A.')

createParam('roiBottomBHoldPosition_px',[500 500],0,2040,...
    'Default image [row col] coordinates of roi in bottom camera for dot set B.')

createParam('roiSlantHoldPosition_px',[500 500],0,2040,...
    'Default image [row col] coordinates of roi in slant camera.')

% Get the full path to the directory
paramsDir = what('paramsData');
evalin('base',['save(''' paramsDir.path filesep 'params.mat'',''params'');'])

end