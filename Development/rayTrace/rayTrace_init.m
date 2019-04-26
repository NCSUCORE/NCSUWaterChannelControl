camEulAngles_rad = camEulAngles_deg*pi/180;
grnd2CamRotMat = calculateRotationMatrix(....
    camEulAngles_rad(1),camEulAngles_rad(2),camEulAngles_rad(3));
% Protect from div by zero or negative number
imageDimsVec_px(1) = max([imageDimsVec_px(1) eps]);
imageDimsVec_px(2) = max([imageDimsVec_px(2) eps]);