function [min] = minFcn(s,x0,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm)

%MINFCN Summary of this function goes here
%   Detailed explanation goes here

min = objJ(updateLaw(s,x0,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm),CoMPos,rCentroidSide,rCentroidBotA,...
    rCentroidBotB,rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);

end
