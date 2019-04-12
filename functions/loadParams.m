function loadParams

% This function used to load params structure from .mat file

% Evaluate params structure into base workspace
evalin('base','load(which(''params.mat''),''params'')');

end