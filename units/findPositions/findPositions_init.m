% Initialize distances as distance from camera to CoM.
% This is only approximatly correct, but it's sufficient
side2SideDist_init      = norm(initialCoMPositionVec_cm-sideCameraPositionVec_cm);
bot2BotADistInit_cm     = norm(initialCoMPositionVec_cm-bottomCameraPositionVec_cm);
bot2BotBDistInit_cm     = bot2BotADistInit_cm;
slant2BotBDistInit_cm   = norm(initialCoMPositionVec_cm-slantCameraPositionVec_cm);
