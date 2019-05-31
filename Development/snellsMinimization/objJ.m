function J = objJ(x)

%OBJJ Summary of this function goes here
%   Detailed explanation goes here

sideInPos = tsc.rCentroidSide.Data(:,:,end);
botAInPos = tsc.rCentroidBotA.Data(:,:,end);
botBInPos = tsc.rCentroidBotB.Data(:,:,end);
slntCamPos = tsc.rCentroidSlant.Data(:,:,end);

uSide = tsc.uCentroidSide.Data(:,:,end);
uBotA = tsc.uCentroidBotA.Data(:,:,end);
uBotB = tsc.uCentroidBotB.Data(:,:,end);
uSlnt = tsc.uCentroidSlnt.Data(:,:,end);

sideDotVecBF = params.sideDotPosVec_cm.Value';
botADotVecBF = params.botADotPosVec_cm.Value';
botBDotVecBF = params.botBDotPosVec_cm.Value';

% x = [xCoM, yCoM, zCoM, roll, pitch, yaw]

RGB = calculateRotationMatrix(x(4:6));
RBG = RGB';

d1 = uSide'*(x(1:3) - RBG*sideDotVecBF)/(uSide'*sideInPos);
e1 = dot( ((x(1:3) + sideDotVecBF) - (sideInPos + uSide*d1)),((x(1:3) + sideDotVecBF) - (sideInPos + uSide*d1)) );

d2 = uBotA'*(x(1:3) - RBG*botADotVecBF)/(uBotA'*botAInPos);
e2 = dot( ((x(1:3) + botADotVecBF) - (botAInPos + uBotA*d2)),((x(1:3) + botADotVecBF) - (botAInPos + uBotA*d2)) );

d3 = uBotB'*(x(1:3) - RBG*botBDotVecBF)/(uBotB'*botBInPos);
e3 = dot( ((x(1:3) + botBDotVecBF) - (botBInPos + uBotB*d3)),((x(1:3) + botBDotVecBF) - (botAInPos + uBotB*d3)) );

d4 = uSlnt'*(x(1:3) - RBG*botBDotVecBF)/(uSlnt'*slntCamPos);
e4 = dot( ((x(1:3) + botBDotVecBF) - (slntCamPos + uSlnt*d4)),((x(1:3) + botBDotVecBF) - (slntCamPos + uSlnt*d4)) );

J = e1 + e2 + e3 + e4;

% e1 = (x(1) + sideDotVecBF(1) - sideCamPos(1) - (1/(dot(sideCamPos,uSide)))*uSide(1)*(x(1)*uSide(1) + x(2)*uSide(2) + x(3)*uSide(3)...
%     + sideDotVecBF(1)*uSide(3)*sin(x(5)) - (sideDotVecBF(2)*cos(x(4)) - sideDotVecBF(3)*sin(x(4)))*(uSide(2)*cos(x(6)) - uSide(1)*sin(x(6)))...
%     - sin(x(5))*(sideDotVecBF(3)*cos(x(4)) + sideDotVecBF(2)*sin(x(4)))*(uSide(1)*cos(x(6)) + uSide(2)*sin(x(6)))...
%     - cos(x(5))*(sideDotVecBF(3)*uSide(3)*cos(x(4)) + sideDotVecBF(1)*uSide(1)*cos(x(6)) + sideDotVecBF(2)*uSide(3)*sin(x(4)) + sideDotVecBF(1)*uSide(2)*sin(x(6)))))^2 ...
%     + (x(2) + sideDotVecBF(2) - sideCamPos(2) - (1/(dot(sideCamPos,uSide)))*uSide(2)*(x(1)*uSide(1) + x(2)*uSide(2) + x(3)*uSide(3)...
%     + sideDotVecBF(1)*uSide(3)*sin(x(5)) - (sideDotVecBF(2)*cos(x(4)) - sideDotVecBF(3)*sin(x(4)))*(uSide(2)*cos(x(6)) - uSide(1)*sin(x(6)))...
%     - sin(x(5))*(sideDotVecBF(3)*cos(x(4)) + sideDotVecBF(2)*sin(x(4)))*(uSide(1)*cos(x(6)) + uSide(2)*sin(x(6)))...
%     - cos(x(5))*(sideDotVecBF(3)*uSide(3)*cos(x(4)) + sideDotVecBF(1)*uSide(1)*cos(x(6)) + sideDotVecBF(2)*uSide(3)*sin(x(4)) + sideDotVecBF(1)*uSide(2)*sin(x(6)))))^2 ...
%     + (x(3) + sideDotVecBF(3) - sideCamPos(3) - (1/(dot(sideCamPos,uSide)))*uSide(3)*(x(1)*uSide(1) + x(2)*uSide(2) + x(3)*uSide(3)...
%     + sideDotVecBF(1)*uSide(3)*sin(x(5)) - (sideDotVecBF(2)*cos(x(4)) - sideDotVecBF(3)*sin(x(4)))*(uSide(2)*cos(x(6)) - uSide(1)*sin(x(6)))...
%     - sin(x(5))*(sideDotVecBF(3)*cos(x(4)) + sideDotVecBF(2)*sin(x(4)))*(uSide(1)*cos(x(6)) + uSide(2)*sin(x(6)))...
%     - cos(x(5))*(sideDotVecBF(3)*uSide(3)*cos(x(4)) + sideDotVecBF(1)*uSide(1)*cos(x(6)) + sideDotVecBF(2)*uSide(3)*sin(x(4)) + sideDotVecBF(1)*uSide(2)*sin(x(6)))))^2;
% 
% e2 = (x(1) + botADotVecBF(1) - botCamPos(1) - (1/(dot(botCamPos,uBotA)))*uBotA(1)*(x(1)*uSide(1) + x(2)*uSide(2) + x(3)*uSide(3)...
%     + sideDotVecBF(1)*uSide(3)*sin(x(5)) - (sideDotVecBF(2)*cos(x(4)) - sideDotVecBF(3)*sin(x(4)))*(uSide(2)*cos(x(6)) - uSide(1)*sin(x(6)))...
%     - sin(x(5))*(sideDotVecBF(3)*cos(x(4)) + sideDotVecBF(2)*sin(x(4)))*(uSide(1)*cos(x(6)) + uSide(2)*sin(x(6)))...
%     - cos(x(5))*(sideDotVecBF(3)*uSide(3)*cos(x(4)) + sideDotVecBF(1)*uSide(1)*cos(x(6)) + sideDotVecBF(2)*uSide(3)*sin(x(4)) + sideDotVecBF(1)*uSide(2)*sin(x(6)))))^2 ...
%     + (x(2) + sideDotVecBF(2) - sideCamPos(2) - (1/(dot(sideCamPos,uSide)))*uSide(2)*(x(1)*uSide(1) + x(2)*uSide(2) + x(3)*uSide(3)...
%     + sideDotVecBF(1)*uSide(3)*sin(x(5)) - (sideDotVecBF(2)*cos(x(4)) - sideDotVecBF(3)*sin(x(4)))*(uSide(2)*cos(x(6)) - uSide(1)*sin(x(6)))...
%     - sin(x(5))*(sideDotVecBF(3)*cos(x(4)) + sideDotVecBF(2)*sin(x(4)))*(uSide(1)*cos(x(6)) + uSide(2)*sin(x(6)))...
%     - cos(x(5))*(sideDotVecBF(3)*uSide(3)*cos(x(4)) + sideDotVecBF(1)*uSide(1)*cos(x(6)) + sideDotVecBF(2)*uSide(3)*sin(x(4)) + sideDotVecBF(1)*uSide(2)*sin(x(6)))))^2 ...
%     + (x(3) + sideDotVecBF(3) - sideCamPos(3) - (1/(dot(sideCamPos,uSide)))*uSide(3)*(x(1)*uSide(1) + x(2)*uSide(2) + x(3)*uSide(3)...
%     + sideDotVecBF(1)*uSide(3)*sin(x(5)) - (sideDotVecBF(2)*cos(x(4)) - sideDotVecBF(3)*sin(x(4)))*(uSide(2)*cos(x(6)) - uSide(1)*sin(x(6)))...
%     - sin(x(5))*(sideDotVecBF(3)*cos(x(4)) + sideDotVecBF(2)*sin(x(4)))*(uSide(1)*cos(x(6)) + uSide(2)*sin(x(6)))...
%     - cos(x(5))*(sideDotVecBF(3)*uSide(3)*cos(x(4)) + sideDotVecBF(1)*uSide(1)*cos(x(6)) + sideDotVecBF(2)*uSide(3)*sin(x(4)) + sideDotVecBF(1)*uSide(2)*sin(x(6)))))^2;

end
