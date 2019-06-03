function [x_star] = updateLaw(s,x0,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm)

%updateLaw Summary of this function goes here
%   Detailed explanation goes here

x_star = x0 - gradObjJ(x0,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm)'*s;

% x_star = x0 - gradObjJ(x0)*s;

end

