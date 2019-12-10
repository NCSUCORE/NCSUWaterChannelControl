%% Script to initialize Find Unit Vectors block

% Convert from degrees to radians
sideEulerAngles_rad = sideEulerAngles_deg.*pi/180;
botEulerAngles_rad = botEulerAngles_deg.*pi/180;
slantEulerAngles_rad = slantEulerAngles_deg.*pi/180;

% Calculate rotation matrix for each camera
GFC2Side   = calculateRotationMatrix(sideEulerAngles_rad(1),sideEulerAngles_rad(2),sideEulerAngles_rad(3));
GFC2Bottom = calculateRotationMatrix(botEulerAngles_rad(1),botEulerAngles_rad(2),botEulerAngles_rad(3));
GFC2Slant  = calculateRotationMatrix(slantEulerAngles_rad(1),slantEulerAngles_rad(2),slantEulerAngles_rad(3));

% Initialize ASB as side and bottom rotation matrices (4x3)
% ASB = [GFC2Side(1,:);GFC2Side(2,:);GFC2Bottom(1,:);GFC2Bottom(2,:)];

% Initialize ABL as bottom and slant rotation matrices (4x3)
% ABL = [GFC2Bottom(1,:);GFC2Bottom(2,:);GFC2Slant(1,:);GFC2Slant(2,:)];

% Calculate DSB and DBL by performing left psuedo inverse of respective ASB
% and ABL matrices (3x4)
% DSB = (ASB'*ASB)\ASB';
% DBL = (ABL'*ABL)\ABL';

% Reshape all position vectors to be columns
sideCamPositionVec_cm   = reshape(sideCamPositionVec_cm,[3,1]);
botCamPositionVec_cm    = reshape(botCamPositionVec_cm,[3,1]);
slantCamPositionVec_cm  = reshape(slantCamPositionVec_cm,[3,1]);
sidePositionVecBF_cm    = reshape(sidePositionVecBF_cm,[3,1]);
botAPositionVecBF_cm    = reshape(botAPositionVecBF_cm,[3,1]);
botBPositionVecBF_cm    = reshape(botBPositionVecBF_cm,[3,1]);
topPositionVecBF_cm     = reshape(topPositionVecBF_cm,[3,1]);