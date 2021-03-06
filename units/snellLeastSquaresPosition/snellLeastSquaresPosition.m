function [COMPosVec,sideDotPos_cm,botADotPos_cm,botBDotPos_cm,topDotPos_cm]...
    = snellLeastSquaresPosition(rCentroidSide,rCentroidBotA,...
        rCentroidBotB,rCentroidSlant,uCentroidSide,uCentroidBotA,...
        uCentroidBotB,uCentroidSlant,body2GroundRotMat,...
        sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm,topDotPosVec_cm)

% (rCentroidSide,rCentroidBotA,...
%         rCentroidBotB,rCentroidSlant,uCentroidSide,uCentroidBotA,...
%         uCentroidBotB,uCentroidSlant,body2GroundRotMat,...
%         sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm,topDotPosVec_cm)
    
% This function calculates the center of mass of the body based on the
% inputs from the ray trace algorithm. 

% INPUTS:
% rCentroidSide - vector from origin to point where ray exits glass and 
%   enters water from side camera, in the ground frame 
% rCentroidBotA - vector from origin to point where ray exits glass and 
%   enters water from bottom camera, in the ground frame 
% rCentroidBotB - vector from origin to point where ray exits glass and 
%   enters water from bottom camera, in the ground frame 
% rCentroidSlant - vector from origin to point where ray exits glass and 
%   enters water from slant camera, in the ground frame 
% uCentroidSide - unit vector pointing into the water towards the side dot
%   set
% uCentroidBotA - unit vector pointing into the water towards the bottom A 
%   dot set
% uCentroidBotB - unit vector pointing into the water towards the bottom B
%   dot set
% uCentroidSlant - unit vector pointing into the water towards the bottom B
%   dot set
% body2GroundRotMat - unit delayed rotation matrix describing the
%   orientation of the body
% sideDotPosVec_cm - vector from the center of mass to the centroid of the 
% side dot set in the body frame
% botADotPosVec_cm - vector from the center of mass to the centroid of the 
% bottom A dot set in the body frame
% botBDotPosVec_cm - vector from the center of mass to the centroid of the
% bottom B dot set in the body frame
% topDotPosVec_cm - vector from the center of mass to the centroid of the 
% top dot set in the body frame

% OUTPUTS:
% COMPosVec - position of the center of mass of the body in the ground frame
% sideDotPos_cm - position of the side dot set in the ground frame
% botADotPos_cm - position of the bottom A dot set in the ground frame
% botBDotPos_cm - position of the bottom B dot set in the ground frame
% topDotPos_cm - position of the top dot set in the ground frame

% Rotate dot set vectors into the ground frame
sideDotGF = body2GroundRotMat*sideDotPosVec_cm(:);
botADotGF = body2GroundRotMat*botADotPosVec_cm(:);
botBDotGF = body2GroundRotMat*botBDotPosVec_cm(:);
topDotGF = body2GroundRotMat*topDotPosVec_cm(:);

% Concatenate ray and dot set vectors vertically into 12x1 vector
rCentroidVec = [rCentroidSide(:); rCentroidBotA(:); rCentroidBotB(:); rCentroidSlant(:)];
COM2DotGF    = [sideDotGF; botADotGF; botBDotGF; topDotGF];

% Subtraction due to dot set vectors direction away from center of mass
P = rCentroidVec - COM2DotGF;

% Form block diagonal matrix populated by unit vectors toawrds dot sets
U = [...
    uCentroidSide(:) zeros(3,1)       zeros(3,1)       zeros(3,1) ;...
    zeros(3,1)       uCentroidBotA(:) zeros(3,1)       zeros(3,1) ;...
    zeros(3,1)       zeros(3,1)       uCentroidBotB(:) zeros(3,1) ;...
    zeros(3,1)       zeros(3,1)       zeros(3,1)       uCentroidSlant(:)];

% Form block diagonal martix which comprises the least squares subtraction
I = eye(3);
O = zeros(3);
Delta = [I -I  O  O;
         I  O -I  O;
         I  O  O -I;
         O  I -I  O;
         O  I  O -I;
         O  O  I -I];

% Perform the minimization to calculate the optimal distance from the ray
% exiting the glass to the dot set centroid
alpha = (Delta*U)'*(Delta*U);
d = -(alpha'*alpha)\(alpha'*U'*Delta'*Delta*P);

% Calculate the center of mass position based on the calculated distance
COMPosVec = U*d+P;
COMPosVec = reshape(COMPosVec,[3 4]); % Reshape to 3 row by 4 col
COMPosVec = mean(COMPosVec,2); % take mean over columns

% Calculate the position of the centroid of each dot set in the ground
% frame
sideDotPos_cm = COMPosVec + sideDotGF;
botADotPos_cm = COMPosVec + botADotGF;
botBDotPos_cm = COMPosVec + botBDotGF;
topDotPos_cm = COMPosVec + topDotGF;

%% Least squares formulation for Powell's method optimization algorithm

% (rCentroid,uCentroid,body2GroundRotMat,bodyFixedVec)

% dotVecGF = body2GroundRotMat*bodyFixedVec;
% 
% rCentroidVec = [rCentroid(:,1);rCentroid(:,2);rCentroid(:,3);...
%                 rCentroid(:,4)];
% 
% dotVecGFVec = [dotVecGF(:,1);dotVecGF(:,2);dotVecGF(:,3);...
%                dotVecGF(:,4)];
% 
% P = rCentroidVec - dotVecGFVec;
% 
% U = [...
%     uCentroid(:,1)  zeros(3,1)      zeros(3,1)      zeros(3,1);...
%     zeros(3,1)      uCentroid(:,2)  zeros(3,1)      zeros(3,1);...
%     zeros(3,1)      zeros(3,1)      uCentroid(:,3)  zeros(3,1);...
%     zeros(3,1)      zeros(3,1)      zeros(3,1)      uCentroid(:,4)]; 
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
% % Delta = [I -I  O  O  O  O  O  O  O;...
% %          I  O -I  O  O  O  O  O  O;...
% %          I  O  O -I  O  O  O  O  O;...
% %          I  O  O  O -I  O  O  O  O;...
% %          I  O  O  O  O -I  O  O  O;...
% %          I  O  O  O  O  O -I  O  O;...
% %          I  O  O  O  O  O  O -I  O;...
% %          I  O  O  O  O  O  O  O -I;...
% %          O  I -I  O  O  O  O  O  O;...
% %          O  I  O -I  O  O  O  O  O;...
% %          O  I  O  O -I  O  O  O  O;...
% %          O  I  O  O  O -I  O  O  O;...
% %          O  I  O  O  O  O -I  O  O;...
% %          O  I  O  O  O  O  O -I  O;...
% %          O  I  O  O  O  O  O  O -I;...
% %          O  O  I -I  O  O  O  O  O;...
% %          O  O  I  O -I  O  O  O  O;...
% %          O  O  I  O  O -I  O  O  O;...
% %          O  O  I  O  O  O -I  O  O;...
% %          O  O  I  O  O  O  O -I  O;...
% %          O  O  I  O  O  O  O  O -I;...
% %          O  O  O  I -I  O  O  O  O;...
% %          O  O  O  I  O -I  O  O  O;...
% %          O  O  O  I  O  O -I  O  O;...
% %          O  O  O  I  O  O  O -I  O;...
% %          O  O  O  I  O  O  O  O -I;...
% %          O  O  O  O  I -I  O  O  O;...
% %          O  O  O  O  I  O -I  O  O;...
% %          O  O  O  O  I  O  O -I  O;...
% %          O  O  O  O  I  O  O  O -I;...
% %          O  O  O  O  O  I -I  O  O;...
% %          O  O  O  O  O  I  O -I  O;...
% %          O  O  O  O  O  I  O  O -I;...
% %          O  O  O  O  O  O  I -I  O;...
% %          O  O  O  O  O  O  I  O -I;...
% %          O  O  O  O  O  O  O  I -I];
% 
% alpha = (Delta*U)'*(Delta*U);
% 
% d = -(alpha'*alpha)\(alpha'*U'*Delta'*Delta*P);
% 
% COMPosVec = U*d+P;
% COMPosVec = reshape(COMPosVec,[3 4]); % Reshape to 3 row by 9 col
% COMPosVec = mean(COMPosVec,2); % take mean over columns
% 
% sideDotPos_cm = COMPosVec + dotVecGFVec(1:3);
% botADotPos_cm = COMPosVec + dotVecGFVec(4:6);
% botBDotPos_cm = COMPosVec + dotVecGFVec(7:9);
% topDotPos_cm = COMPosVec + dotVecGFVec(10:12);

end

