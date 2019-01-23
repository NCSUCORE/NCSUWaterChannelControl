%% Function to initialize the image processing block
% Basically all this does is set the underlying parameters on the DotFinder
% block to match the parameters from this mask

set_param([gcb '/DotFinder'],'DotOrientation',get_param(gcb,'DotOrientation'))
set_param([gcb '/DotFinder'],'ROIPositionHoldEnable',get_param(gcb,'ROIPositionHoldEnable'))
set_param([gcb '/DotFinder'],'OverlayOutput',get_param(gcb,'OverlayOutput'))