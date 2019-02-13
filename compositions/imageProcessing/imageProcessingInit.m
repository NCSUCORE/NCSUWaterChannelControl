%% Function to initialize the image processing block

set_param([gcb '/DotFinder'],'DotOrientation',get_param(gcb,'DotOrientation'))
set_param([gcb '/DotFinder'],'ROIPositionHoldEnable',get_param(gcb,'ROIPositionHoldEnable'))
set_param([gcb '/DotFinder'],'OverlayOutput',get_param(gcb,'OverlayOutput'))

% Calculate the rotation matrix that takes a vector in the camera frame and
% produces the vector in the ground frame.  See rotation matrix.nb in the
% documentation folder for details.
roll  = camEulerAngles_deg(3)*pi/180; % Yaw
pitch = camEulerAngles_deg(2)*pi/180; % Pitch
yaw   = camEulerAngles_deg(1)*pi/180; % Roll
cam2GroundRotationMatrix = (calculateRotationMatrix(roll,pitch,yaw))';



