cameraFOV_rad         = cameraFOV_deg*pi/180;
cameraEulerAngles_rad = cameraEulerAngles_deg*pi/180;

switch lower(glassPlane)
    case 'xy'
        glassPlane = 1;
    case 'xz'
        glassPlane = 2;
end

grnd2CamRotMat = calculateRotationMatrix(...
    cameraEulerAngles_rad(1),...
    cameraEulerAngles_rad(2),...
    cameraEulerAngles_rad(3));

[~,rM,uM] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
    0,0,indOfRef,glassPlane,glassThickness);
