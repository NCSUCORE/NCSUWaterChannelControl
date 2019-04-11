%% Script to initialize find Position block

% Initialize distances as distance from camera to CoM.
% This is only approximatly correct, but it's sufficient
side2SideDist_init      = norm(initialCoMPositionVec_cm-sideCameraPositionVec_cm);
bot2BotADistInit_cm     = norm(initialCoMPositionVec_cm-bottomCameraPositionVec_cm);
bot2BotBDistInit_cm     = bot2BotADistInit_cm;
slant2BotBDistInit_cm   = norm(initialCoMPositionVec_cm-slantCameraPositionVec_cm);

% Get the unit vectors of the camera coordinate system from the rotation matrices
iS = side2GroundRotationMatrix(:,1);
jS = side2GroundRotationMatrix(:,2);
iA = bot2GroundRotationMatrix(:,1);
jA = bot2GroundRotationMatrix(:,2);

% Set side camera and bottom camera vectors
rSG = sideCameraPositionVec_cm;
rAG = bottomCameraPositionVec_cm;

% Initialize alpha with unit vector components for left pseudo inverse in
% next step
alpha = [iS';jS';iA';iA';jA';jA'];

% calculate alphaBar, alpha0, and gamma
alphaBar = (alpha'*alpha)\alpha';
alpha0 = blkdiag(iS',jS',iA',iA',jA',jA');
gamma = [repmat(rSG,[2 1]);repmat(rAG,[4 1])];
