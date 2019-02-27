function loadParams
% function to load params structure from .mat file
evalin('base','load(which(''params.mat''),''params'')');
end