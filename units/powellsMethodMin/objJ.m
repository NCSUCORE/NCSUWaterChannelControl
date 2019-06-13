function J = objJ(EulAng,CoMPos,rCentroid,uCentroid,bodyFixedVec)

%OBJJ Summary of this function goes here
%   Detailed explanation goes here

% x = [roll, pitch, yaw]

RGB = calculateRotationMatrix(EulAng(1),EulAng(2),EulAng(3));
RBG = RGB';

J = 0;

for ii = 1:length(rCentroid)
    d = uCentroid(:,ii)'*(CoMPos - RBG*bodyFixedVec - rCentroid(:,ii));
    e = dot( ((CoMPos + RBG*bodyFixedVec) - (rCentroid(:,ii) + uCentroid(:,ii)*d)),...
             ((CoMPos + RBG*bodyFixedVec) - (rCentroid(:,ii) + uCentroid(:,ii)*d)) );

    J = J + e;
end

% d1 = uCentroidSide'*(CoMPos - RBG*sideDotPosVec_cm - rCentroidSide);
% e1 = dot( ((CoMPos + RBG*sideDotPosVec_cm) - (rCentroidSide + uCentroidSide*d1)),...
%           ((CoMPos + RBG*sideDotPosVec_cm) - (rCentroidSide + uCentroidSide*d1)) );
% 
% d2 = uCentroidBotA'*(CoMPos - RBG*botADotPosVec_cm - rCentroidBotA);
% e2 = dot( ((CoMPos + RBG*botADotPosVec_cm) - (rCentroidBotA + uCentroidBotA*d2)),...
%           ((CoMPos + RBG*botADotPosVec_cm) - (rCentroidBotA + uCentroidBotA*d2)) );
% 
% d3 = uCentroidBotB'*(CoMPos - RBG*botBDotPosVec_cm - rCentroidBotB);
% e3 = dot( ((CoMPos + RBG*botBDotPosVec_cm) - (rCentroidBotB + uCentroidBotB*d3)),...
%           ((CoMPos + RBG*botBDotPosVec_cm) - (rCentroidBotB + uCentroidBotB*d3)) );
% 
% d4 = uCentroidSlant'*(CoMPos - RBG*botBDotPosVec_cm - rCentroidSlant);
% e4 = dot( ((CoMPos + RBG*botBDotPosVec_cm) - (rCentroidSlant + uCentroidSlant*d4)),...
%           ((CoMPos + RBG*botBDotPosVec_cm) - (rCentroidSlant + uCentroidSlant*d4)) );
% 
% J = e1 + e2 + e3 + e4;

end
