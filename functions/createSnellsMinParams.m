function createSnellsMinParams()

% This function creates the snells object for use find6DoFSnellMin9_cl bus.
% Object contains camera and dot parameters.

global params;

% Side Camera
snells(1).camPosVec = params.sideCamPosVec_cm.Value';
snells(1).camEulAng = params.sideCamEulAng_deg.Value';
snells(1).camDist2Glass = params.sideDistancetoGlass_cm.Value;
snells(1).bodyFixedVec = params.sideDotPosVec_cm.Value';

% snells(2) = snells(1);
% snells(2).bodyFixedVec = [-1.134 1.482 -4.554]';
% snells(3) = snells(2);
% snells(3).bodyFixedVec = [2.049 0 -4.546]';

% Bottom Camera
snells(2).camPosVec = params.botCamPosVec_cm.Value';
snells(2).camEulAng = params.botCamEulAng_deg.Value';
snells(2).camDist2Glass = params.botDistancetoGlass_cm.Value;
snells(2).bodyFixedVec = params.botADotPosVec_cm.Value';

snells(3) = snells(2);
snells(3).bodyFixedVec = params.botBDotPosVec_cm.Value';

% snells(5) = snells(4);
% snells(5).bodyFixedVec = [-1.134 1.482 -4.554]';
% snells(6) = snells(5);
% snells(6).bodyFixedVec = [2.049 0 -4.546]';

% Slant/Periscope Camera
snells(4).camPosVec = params.prscpeCamPosVec_cm.Value';
snells(4).camEulAng = params.prscpeCamEulAng_deg.Value';
snells(4).camDist2Glass = params.botDistancetoGlass_cm.Value;
snells(4).bodyFixedVec = params.topDotPosVec_cm.Value';

% snells(8) = snells(7);
% snells(8).bodyFixedVec = [-1.134 1.482 -4.554]';
% snells(9) = snells(8);
% snells(9).bodyFixedVec = [2.049 0 -4.546]';

assignin('base','snells',snells)

end

