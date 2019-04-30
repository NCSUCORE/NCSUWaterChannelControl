function [COMPosVec,d] = resolveCOM(...
    rCentroidSide,...
    rCentroidBotA,...
    rCentroidBotB,...
    rCentroidSlant,...
    uCentroidSide,...
    uCentroidBotA,...
    uCentroidBotB,...
    uCentroidSlant,...
    body2GroundRotMat,...
    sideDotPosVec_cm, botADotPosVec_cm, botBDotPosVec_cm)

%RESOLVECOM Summary of this function goes here
%   Detailed explanation goes here

sideDotGF = body2GroundRotMat*sideDotPosVec_cm(:);
botADotGF = body2GroundRotMat*botADotPosVec_cm(:);
botBDotGF = body2GroundRotMat*botBDotPosVec_cm(:);

rCentroidVec = [rCentroidSide(:); rCentroidBotA(:) ; rCentroidBotB(:) ; rCentroidSlant(:)];
COM2DotGF    = [sideDotGF ; botADotGF ; botBDotGF ; botBDotGF];
P = rCentroidVec + COM2DotGF;

U = [...
    uCentroidSide(:) zeros(3,1)       zeros(3,1)       zeros(3,1) ;...
    zeros(3,1)       uCentroidBotA(:) zeros(3,1)       zeros(3,1) ;...
    zeros(3,1)       zeros(3,1)       uCentroidBotB(:) zeros(3,1) ;...
    zeros(3,1)       zeros(3,1)       zeros(3,1)       uCentroidSlant(:)];

I = eye(3);
O = zeros(3);
Delta = [I -I  O  O;
         I  O -I  O;
         I  O  O -I;
         O  I -I  O;
         O  I  O -I;
         O  O  I -I];
     
alpha = (Delta*U)'*(Delta*U);

d = -(alpha'*alpha)\alpha'*U'*Delta'*Delta*P;

COMPosVec = U*d+P;
COMPosVec = reshape(COMPosVec,[3 4]); % Reshape to 3 row by 4 col
COMPosVec = mean(COMPosVec,2); % take mean over columns

end

