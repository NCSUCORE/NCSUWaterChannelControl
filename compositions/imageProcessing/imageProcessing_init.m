%% Function to initialize the image processing block

set_param([gcb '/DotFinder'],'DotOrientation',get_param(gcb,'DotOrientation'))
set_param([gcb '/DotFinder'],'ROIPositionHoldEnable',get_param(gcb,'ROIPositionHoldEnable'))
set_param([gcb '/DotFinder'],'OverlayOutput',get_param(gcb,'OverlayOutput'))

% Calculate the rotation matrix that takes a vector in the camera frame and
% produces the vector in the ground frame.  See rotation matrix.nb in the
% documentation folder for details.

switch lower(cameraSelection)
    case 'bottoma'
        roll  = 0;
        pitch = 180*pi/180;
        yaw   = 180*pi/180;
    case 'bottomb'
        roll  = 0;
        pitch = 180*pi/180;
        yaw   = 180*pi/180;
    case 'side'
        roll  = 0;
        pitch = 90*pi/180;
        yaw   = -90*pi/180;
    case 'slant'
        roll  = 0;
        pitch = 135*pi/180;
        yaw   = 180*pi/180;
end

cam2GroundRotationMatrix = (calculateRotationMatrix(roll,pitch,yaw))';



