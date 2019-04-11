function [side2SideDist_cm,bot2BotADist_cm,...
    bot2BotBDist_cm,slant2BotBDist_cm,CoMPositionVec_cm] = ...
    findPosition(sideDotImageCoords,bottomADotImageCoords,...
    bottomBDotImageCoords,...
    body2GroundRotationMatrix,lastCoMPositionVec_cm,...
    sideDotPositionVec_cm,bottomDotAPositionVec_cm,...
    bottomDotBPositionVec_cm,sideCameraPositionVec_cm,...
    bottomCameraPositionVec_cm,slantCameraPositionVec_cm,...
    alphaBar,alpha0,gamma,imageDims,cameraFOVAngle_deg)

%FINDPOSITION function is used to calculate center of mass position vectors
%   Function returns center of mass position vector of body in ground
%   frame, as well as distance from each camera to the centroid of each 
%   respective dot set

% Vectors that point from the CoM to the dots represented in the ground frame
side2CoMInGFVec_cm = body2GroundRotationMatrix*sideDotPositionVec_cm;
botA2CoMInGFVec_cm = body2GroundRotationMatrix*bottomDotAPositionVec_cm;
botB2ComInGFVec_cm = body2GroundRotationMatrix*bottomDotBPositionVec_cm;

% Calculate distance from camera to specific dot centroid
side2SideDist_cm  = norm(sideCameraPositionVec_cm - (lastCoMPositionVec_cm + side2CoMInGFVec_cm));
bot2BotADist_cm   = norm(bottomCameraPositionVec_cm - (lastCoMPositionVec_cm + botA2CoMInGFVec_cm));
bot2BotBDist_cm   = norm(bottomCameraPositionVec_cm - (lastCoMPositionVec_cm + botB2ComInGFVec_cm));
slant2BotBDist_cm = norm(slantCameraPositionVec_cm - (lastCoMPositionVec_cm + botB2ComInGFVec_cm));

% Find position of side dots in camera frame from side camera
sidePosVecCamFrame_cm = zeros(2,1);
sidePosVecCamFrame_cm(1) = (2*side2SideDist_cm/imageDims(1))*(sideDotImageCoords(1) - imageDims(1)/2)*tand(cameraFOVAngle_deg(1));
sidePosVecCamFrame_cm(2) = (2*side2SideDist_cm/imageDims(2))*(sideDotImageCoords(2) - imageDims(2)/2)*tand(cameraFOVAngle_deg(2));

% Find position of bottom dots A in camera frame from bottom camera
botAPosVecCamFrame_cm = zeros(2,1);
botAPosVecCamFrame_cm(1) = (2*bot2BotADist_cm/imageDims(1))*(bottomADotImageCoords(1) - imageDims(1)/2)*tand(cameraFOVAngle_deg(1));
botAPosVecCamFrame_cm(2) = (2*bot2BotADist_cm/imageDims(2))*(bottomADotImageCoords(2) - imageDims(2)/2)*tand(cameraFOVAngle_deg(2));

% Find position of bottom dots B in camera frame from bottom camera
botBPosVecCamFrame_cm = zeros(2,1);
botBPosVecCamFrame_cm(1) = (2*bot2BotBDist_cm/imageDims(1))*(bottomBDotImageCoords(1) - imageDims(1)/2)*tand(cameraFOVAngle_deg(1));
botBPosVecCamFrame_cm(2) = (2*bot2BotBDist_cm/imageDims(2))*(bottomBDotImageCoords(2) - imageDims(2)/2)*tand(cameraFOVAngle_deg(2));

% Initialize Delta with position vectors from each camera as represented in
% the camera frame
Delta = [sidePosVecCamFrame_cm(1);... % a
    sidePosVecCamFrame_cm(2);... % b
    botAPosVecCamFrame_cm(1);... % c
    botBPosVecCamFrame_cm(1);... % d
    botAPosVecCamFrame_cm(2);... % e
    botBPosVecCamFrame_cm(2)]; % f

% Calculate side, bottom A, and bottom B vectors as represented in the
% ground frame (camera to body) 
rDB = body2GroundRotationMatrix * sideDotPositionVec_cm;
rEB = body2GroundRotationMatrix * bottomDotAPositionVec_cm;
rFB = body2GroundRotationMatrix * bottomDotBPositionVec_cm;

% Initialize beta in terms of camera position vectors
beta = [rDB;rDB;rEB;rFB;rEB;rFB];

% Calculate center of mass position vector and normalize each distance from
% camera to respective dot set centroid
CoMPositionVec_cm = alphaBar*(Delta+alpha0*(gamma-beta));
side2SideDist_cm  = norm(CoMPositionVec_cm + rDB - sideCameraPositionVec_cm);
bot2BotADist_cm   = norm(CoMPositionVec_cm + rEB - bottomCameraPositionVec_cm);
bot2BotBDist_cm   = norm(CoMPositionVec_cm + rFB - bottomCameraPositionVec_cm);
slant2BotBDist_cm = norm(CoMPositionVec_cm + rFB - slantCameraPositionVec_cm);

end

