function [COMPosVec] = resolveCOM(rCentroidVec,uCentroidVec,...
    body2GroundRotMat,sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm)
%RESOLVECOM Summary of this function goes here
%   Detailed explanation goes here

sideDotGF = body2GroundRotMat*sideDotPosVec_cm;
botADotGF = body2GroundRotMat*botADotPosVec_cm;
botBDotGF = body2GroundRotMat*botBDotPosVec_cm;

COM2DotGF = [sideDotGF botADotGF botBDotGF botBDotGF];

P = rCentroidVec + COM2DotGF;

I = eye(3);
delta = [I -I  0  0;
         I  0 -I  0;
         I  0  0 -I;
         0  I -I  0;
         0  I  0 -I;
         0  0  I -I];
     
alpha = uCentroidVec'*delta'*delta*uCentroidVec;

distanceVec = inv(-(alpha'*alpha))*alpha'*uCentroidVec'*delta'*delta*P;

COMPosVec = distanceVec*uCentroidVec + P;

COMPosVec = mean(COMPosVec(:,1) + COMPosVec(:,2) + COMPosVec(:,3) + COMPosVec(:,4));

end

