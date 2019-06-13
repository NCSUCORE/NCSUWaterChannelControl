function [COMPosVec,sideDotPos_cm,botADotPos_cm,botBDotPos_cm]...
    = snellLeastSquaresPosition(rCentroid,uCentroid,body2GroundRotMat,bodyFixedVec)

% rCentroidSide,rCentroidBotA,...
%     rCentroidBotB,rCentroidSlant,uCentroidSide,uCentroidBotA,...
%     uCentroidBotB,uCentroidSlant,body2GroundRotMat,...
%     sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm)

% rCentroid,uCentroid,body2GroundRotMat,bodyFixedVec)

%snellLeastSquaresPosition 
%   Detailed explanation goes here

dotVecGF = body2GroundRotMat*bodyFixedVec;

rCentroidVec = [rCentroid(:,1);rCentroid(:,2);rCentroid(:,3);...
                rCentroid(:,4);rCentroid(:,5);rCentroid(:,6);...
                rCentroid(:,7);rCentroid(:,8);rCentroid(:,9)];
            
dotVecGFVec = [dotVecGF(:,1);dotVecGF(:,2);dotVecGF(:,3);...
               dotVecGF(:,4);dotVecGF(:,5);dotVecGF(:,6);...
               dotVecGF(:,7);dotVecGF(:,8);dotVecGF(:,9)];

P = rCentroidVec - dotVecGFVec;

U = [...
    uCentroid(:,1)  zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1);...
    zeros(3,1)      uCentroid(:,2)  zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1);...
    zeros(3,1)      zeros(3,1)      uCentroid(:,3)  zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1);...
    zeros(3,1)      zeros(3,1)      zeros(3,1)      uCentroid(:,4)  zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1);...
    zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      uCentroid(:,5)  zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1);...
    zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      uCentroid(:,6)  zeros(3,1)      zeros(3,1)      zeros(3,1);...
    zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      uCentroid(:,7)  zeros(3,1)      zeros(3,1);...
    zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      uCentroid(:,8)  zeros(3,1);...
    zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      zeros(3,1)      uCentroid(:,9)]; 

I = eye(3);
O = zeros(3);
Delta = [I -I  O  O  O  O  O  O  O;
         I  O -I  O  O  O  O  O  O;
         I  O  O -I  O  O  O  O  O;
         I  O  O  O -I  O  O  O  O;
         I  O  O  O  O -I  O  O  O;
         I  O  O  O  O  O -I  O  O;
         I  O  O  O  O  O  O -I  O;
         I  O  O  O  O  O  O  O -I;
         O  I -I  O  O  O  O  O  O;
         O  I  O -I  O  O  O  O  O;
         O  I  O  O -I  O  O  O  O;
         O  I  O  O  O -I  O  O  O;
         O  I  O  O  O  O -I  O  O;
         O  I  O  O  O  O  O -I  O;
         O  I  O  O  O  O  O  O -I;
         O  O  I -I  O  O  O  O  O;
         O  O  I  O -I  O  O  O  O;
         O  O  I  O  O -I  O  O  O;
         O  O  I  O  O  O -I  O  O;
         O  O  I  O  O  O  O -I  O;
         O  O  I  O  O  O  O  O -I;
         O  O  O  I -I  O  O  O  O;
         O  O  O  I  O -I  O  O  O;
         O  O  O  I  O  O -I  O  O;
         O  O  O  I  O  O  O -I  O;
         O  O  O  I  O  O  O  O -I;
         O  O  O  O  I -I  O  O  O;
         O  O  O  O  I  O -I  O  O;
         O  O  O  O  I  O  O -I  O;
         O  O  O  O  I  O  O  O -I;
         O  O  O  O  O  I -I  O  O;
         O  O  O  O  O  I  O -I  O;
         O  O  O  O  O  I  O  O -I;
         O  O  O  O  O  O  I -I  O;
         O  O  O  O  O  O  I  O -I;
         O  O  O  O  O  O  O  I -I];

alpha = (Delta*U)'*(Delta*U);

d = -(alpha'*alpha)\(alpha'*U'*Delta'*Delta*P);

COMPosVec = U*d+P;
COMPosVec = reshape(COMPosVec,[3 9]); % Reshape to 3 row by 9 col
COMPosVec = mean(COMPosVec,2); % take mean over columns
     
%%

% sideDotGF = body2GroundRotMat*sideDotPosVec_cm(:);
% botADotGF = body2GroundRotMat*botADotPosVec_cm(:);
% botBDotGF = body2GroundRotMat*botBDotPosVec_cm(:);
% 
% rCentroidVec = [rCentroidSide(:); rCentroidBotA(:) ; rCentroidBotB(:) ; rCentroidSlant(:)];
% COM2DotGF    = [sideDotGF ; botADotGF ; botBDotGF ; botBDotGF];
% P = rCentroidVec - COM2DotGF;
% 
% U = [...
%     uCentroidSide(:) zeros(3,1)       zeros(3,1)       zeros(3,1) ;...
%     zeros(3,1)       uCentroidBotA(:) zeros(3,1)       zeros(3,1) ;...
%     zeros(3,1)       zeros(3,1)       uCentroidBotB(:) zeros(3,1) ;...
%     zeros(3,1)       zeros(3,1)       zeros(3,1)       uCentroidSlant(:)];
% 
% I = eye(3);
% O = zeros(3);
% Delta = [I -I  O  O;
%          I  O -I  O;
%          I  O  O -I;
%          O  I -I  O;
%          O  I  O -I;
%          O  O  I -I];
%      
% alpha = (Delta*U)'*(Delta*U);
% 
% d = -(alpha'*alpha)\(alpha'*U'*Delta'*Delta*P);
% 
% COMPosVec = U*d+P;
% COMPosVec = reshape(COMPosVec,[3 4]); % Reshape to 3 row by 4 col
% COMPosVec = mean(COMPosVec,2); % take mean over columns
% 
% sideDotPos_cm = COMPosVec + sideDotGF;
% botADotPos_cm = COMPosVec + botADotGF;
% botBDotPos_cm = COMPosVec + botBDotGF;

end

