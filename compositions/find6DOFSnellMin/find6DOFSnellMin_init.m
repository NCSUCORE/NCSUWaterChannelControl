initialEulerAngles_rad   = initialEulerAngles_deg.*pi/180;

sideCamPositionVec_cm    = reshape(sideCamPositionVec_cm,[3,1]);
botCamPositionVec_cm     = reshape(botCamPositionVec_cm,[3,1]);
slantCamPositionVec_cm   = reshape(slantCamPositionVec_cm,[3,1]);

sidePositionVecBF_cm     = reshape(sidePositionVecBF_cm,[3,1]);
botAPositionVecBF_cm     = reshape(botAPositionVecBF_cm,[3,1]);
botBPositionVecBF_cm     = reshape(botBPositionVecBF_cm,[3,1]);

initialCoMPositionVec_cm = reshape(initialCoMPositionVec_cm,[3 1]);
initialEulerAngles_rad   = reshape(initialEulerAngles_rad,[3,1]);