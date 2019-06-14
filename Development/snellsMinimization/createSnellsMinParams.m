function createSnellsMinParams()

%CREATESNELLSMINPARAMS Summary of this function goes here
%   Detailed explanation goes here

global params;

snells(1).camPosVec = params.botCamPosVec_cm.Value(:);
snells(1).camEulAng = params.botCamEulAng_deg.Value(:);
snells(1).camDist2Glass = params.botDistancetoGlass_cm.Value;
snells(1).bodyFixedVec = params.botADotPosVec_cm.Value(:);

snells(2) = snells(1);
snells(3) = snells(2);

snells(4).camPosVec = params.botCamPosVec_cm.Value(:);
snells(4).camEulAng = params.botCamEulAng_deg.Value(:);
snells(4).camDist2Glass = params.botDistancetoGlass_cm.Value;
snells(4).bodyFixedVec = params.botADotPosVec_cm.Value(:);

snells(5) = snells(4);
snells(6) = snells(5);

snells(7).camPosVec = params.botCamPosVec_cm.Value(:);
snells(7).camEulAng = params.botCamEulAng_deg.Value(:);
snells(7).camDist2Glass = params.botDistancetoGlass_cm.Value;
snells(7).bodyFixedVec = params.botBDotPosVec_cm.Value(:);

snells(8) = snells(7);
snells(9) = snells(8);

assignin('base','snells',snells)

end

