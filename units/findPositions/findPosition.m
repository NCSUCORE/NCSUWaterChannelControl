function [side2SideDist_cm,bot2BotADist_cm,...
    bot2BotBDist_cm,slant2BotBDist_cm,CoMPositionVec_cm] = ...
    findPosition(sideDotImageCoords,bottomADotImageCoords,...
    bottomBDotImageCoords,...
    body2GroundRotationMatrix,lastCoMPositionVec_cm,...
    sideDotPositionVec_cm,bottomDotAPositionVec_cm,...
    bottomDotBPositionVec_cm,sideCameraPositionVec_cm,...
    bottomCameraPositionVec_cm,slantCameraPositionVec_cm,...
    alphaBar,alpha0,gamma,imageDims,cameraFOVAngle_deg,...
    side2GroundRotationMatrix,bot2GroundRotationMatrix,slant2GroundRotationMatrix)

% This function is used to calculate center of mass position vectors
% Returns center of mass position vector of body in ground frame, as well 
% as distance from each camera to the centroid of each respective dot set

% Vectors that point from the CoM to the dots represented in the ground frame
CoM2SideGFVec_cm = body2GroundRotationMatrix*sideDotPositionVec_cm;
CoM2BotAGFVec_cm = body2GroundRotationMatrix*bottomDotAPositionVec_cm;
CoM2BotBGFVec_cm = body2GroundRotationMatrix*bottomDotBPositionVec_cm;

% Vectors that point from dot centroid to camera in the ground frame
side2SideDotVecGF = (lastCoMPositionVec_cm + CoM2SideGFVec_cm) - sideCameraPositionVec_cm;
bot2BotADotVecGF = (lastCoMPositionVec_cm + CoM2BotAGFVec_cm) - bottomCameraPositionVec_cm;
bot2BotBDotVecGF = (lastCoMPositionVec_cm + CoM2BotBGFVec_cm) - bottomCameraPositionVec_cm;
slant2BotBDotVecGF = (lastCoMPositionVec_cm + CoM2BotBGFVec_cm) - slantCameraPositionVec_cm;

% Vectors that point from camera to dot centroid in the camera frame
side2SideDotVecCF = side2GroundRotationMatrix'*side2SideDotVecGF;
bot2BotADotVecCF = bot2GroundRotationMatrix'*bot2BotADotVecGF;
bot2BotBDotVecCF = bot2GroundRotationMatrix'*bot2BotBDotVecGF;
slant2BotBDotVecCF = slant2GroundRotationMatrix'*slant2BotBDotVecGF;

% Calculate horizontal and vertical distance from side camera to side dot centroid in camera frame 
side2SideDistHoriz_cm = norm([side2SideDotVecCF(2) side2SideDotVecCF(3)]);
side2SideDistVert_cm = norm([side2SideDotVecCF(1) side2SideDotVecCF(3)]);

% Calculate horizontal and vertical distance from bottom camera to bottom A dot centroid in camera frame 
bot2BotADistHoriz_cm = norm([bot2BotADotVecCF(2) bot2BotADotVecCF(3)]);
bot2BotADistVert_cm = norm([bot2BotADotVecCF(1) bot2BotADotVecCF(3)]);

% Calculate horizontal and vertical distance from bottom camera to bottom B dot centroid in camera frame 
bot2BotBDistHoriz_cm = norm([bot2BotBDotVecCF(2) bot2BotBDotVecCF(3)]);
bot2BotBDistVert_cm = norm([bot2BotBDotVecCF(1) bot2BotBDotVecCF(3)]);

% Calculate horizontal and vertical distance from slant camera to bottom B dot centroid in camera frame
% Not used due to inconsistencies caused by Snell's law
slant2BotBDistHoriz_cm = norm([slant2BotBDotVecCF(2) slant2BotBDotVecCF(3)]);
slant2BotBDistVert_cm = norm([slant2BotBDotVecCF(1) slant2BotBDotVecCF(3)]);

% Find position of side dots in camera frame from side camera
sidePosVecCamFrame_cm = zeros(2,1);
sidePosVecCamFrame_cm(1) = (2*side2SideDistHoriz_cm/imageDims(1))*(sideDotImageCoords(1) - imageDims(1)/2)*...
    tand(cameraFOVAngle_deg(1))*cosd(atand((2*(sideDotImageCoords(1) - imageDims(1)/2))/(imageDims(1)/2)*tan(cameraFOVAngle_deg(1))));
sidePosVecCamFrame_cm(2) = (2*side2SideDistVert_cm/imageDims(2))*(sideDotImageCoords(2) - imageDims(2)/2)*...
    tand(cameraFOVAngle_deg(2))*cosd(atand((2*(sideDotImageCoords(2) - imageDims(2)/2))/(imageDims(2)/2)*tan(cameraFOVAngle_deg(2))));

% Find position of bottom dots A in camera frame from bottom camera
botAPosVecCamFrame_cm = zeros(2,1);
botAPosVecCamFrame_cm(1) = (2*bot2BotADistHoriz_cm/imageDims(1))*(bottomADotImageCoords(1) - imageDims(1)/2)*...
    tand(cameraFOVAngle_deg(1))*cosd(atand((2*(bottomADotImageCoords(1) - imageDims(1)/2))/(imageDims(1)/2)*tan(cameraFOVAngle_deg(1))));
botAPosVecCamFrame_cm(2) = (2*bot2BotADistVert_cm/imageDims(2))*(bottomADotImageCoords(2) - imageDims(2)/2)*...
    tand(cameraFOVAngle_deg(2))*cosd(atand((2*(bottomADotImageCoords(2) - imageDims(2)/2))/(imageDims(2)/2)*tan(cameraFOVAngle_deg(2))));

% Find position of bottom dots B in camera frame from bottom camera
botBPosVecCamFrame_cm = zeros(2,1);
botBPosVecCamFrame_cm(1) = (2*bot2BotBDistHoriz_cm/imageDims(1))*(bottomBDotImageCoords(1) - imageDims(1)/2)*...
    tand(cameraFOVAngle_deg(1))*cosd(atand((2*(bottomBDotImageCoords(1) - imageDims(1)/2))/(imageDims(1)/2)*tan(cameraFOVAngle_deg(1))));
botBPosVecCamFrame_cm(2) = (2*bot2BotBDistVert_cm/imageDims(2))*(bottomBDotImageCoords(2) - imageDims(2)/2)*...
    tand(cameraFOVAngle_deg(2))*cosd(atand((2*(bottomBDotImageCoords(2) - imageDims(2)/2))/(imageDims(2)/2)*tan(cameraFOVAngle_deg(2))));

% Initialize Delta with position vectors from each camera as represented in the camera frame
Delta = [sidePosVecCamFrame_cm(1);... % a
    sidePosVecCamFrame_cm(2);... % b
    botAPosVecCamFrame_cm(1);... % c
    botBPosVecCamFrame_cm(1);... % d
    botAPosVecCamFrame_cm(2);... % e
    botBPosVecCamFrame_cm(2)]; % f

% Initialize beta in terms of camera position vectors
beta = [CoM2SideGFVec_cm;CoM2SideGFVec_cm;CoM2BotAGFVec_cm;CoM2BotBGFVec_cm;CoM2BotAGFVec_cm;CoM2BotBGFVec_cm];

% Calculate center of mass position vector and normalize each distance from
% camera to respective dot set centroid
CoMPositionVec_cm = alphaBar*(Delta+alpha0*(gamma-beta));
side2SideDist_cm  = norm(CoMPositionVec_cm + CoM2SideGFVec_cm - sideCameraPositionVec_cm);
bot2BotADist_cm   = norm(CoMPositionVec_cm + CoM2BotAGFVec_cm - bottomCameraPositionVec_cm);
bot2BotBDist_cm   = norm(CoMPositionVec_cm + CoM2BotBGFVec_cm - bottomCameraPositionVec_cm);
slant2BotBDist_cm = norm(CoMPositionVec_cm + CoM2BotBGFVec_cm - slantCameraPositionVec_cm);

end

