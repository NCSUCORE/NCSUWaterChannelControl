function createSnellsMinParams()

%CREATESNELLSMINPARAMS Summary of this function goes here
%   Detailed explanation goes here

global params;

% Camera 3
snells(1).camPosVec = [4 -10 22.5]';
snells(1).camEulAng = [3 179.4 0]';
snells(1).camDist2Glass = params.botDistancetoGlass_cm.Value;
snells(1).bodyFixedVec = [-1.134 -1.482 -4.554]';

snells(2) = snells(1);
snells(2).bodyFixedVec = [-1.134 1.482 -4.554]';
snells(3) = snells(2);
snells(3).bodyFixedVec = [2.049 0 -4.546]';

% Camera 4
snells(4).camPosVec = [0 0 23]';
snells(4).camEulAng = [1.9 185 180]';
snells(4).camDist2Glass = params.botDistancetoGlass_cm.Value;
snells(4).bodyFixedVec = [-1.134 -1.482 -4.554]';

snells(5) = snells(4);
snells(5).bodyFixedVec = [-1.134 1.482 -4.554]';
snells(6) = snells(5);
snells(6).bodyFixedVec = [2.049 0 -4.546]';

% Camera 5
snells(7).camPosVec = [-22.5 0 25.5]';
snells(7).camEulAng = [1.5 128 182]';
snells(7).camDist2Glass = params.botDistancetoGlass_cm.Value;
snells(7).bodyFixedVec = [-1.134 -1.482 -4.554]';

snells(8) = snells(7);
snells(8).bodyFixedVec = [-1.134 1.482 -4.554]';
snells(9) = snells(8);
snells(9).bodyFixedVec = [2.049 0 -4.546]';

assignin('base','snells',snells)

end

