function [distanceVec] = resolveCOM(rCentroidVec,uCentroidVec,...
    body2GroundRotMat,sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm)
%RESOLVECOM Summary of this function goes here
%   Detailed explanation goes here

sideDotGF = body2GroundRotMat*sideDotPosVec_cm;
botADotGF = body2GroundRotMat*botADotPosVec_cm;
botBDotGF = body2GroundRotMat*botBDotPosVec_cm;

COM2DotGF = [sideDotGF botADotGF botBDotGF botBDotGF];

% I = eye(3);
% U = [I -I  0  0;
%      I  0 -I  0;
%      I  0  0 -I;
%      0  I -I  0;
%      0  I  0 -I;
%      0  0  I -I];

distanceVec = inv(-(uCentroidVec'*uCentroidVec))*uCentroidVec'*(rCentroidVec + COM2DotGF);

end

