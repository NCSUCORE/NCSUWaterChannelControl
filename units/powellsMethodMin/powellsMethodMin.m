function [CoMPos,EulerAng] = powellsMethodMin(initEulerAng,inputBus,snells)

% This function uses the outputs from the ray trace algorithm to
%   formulate an angular optimization algorithm using Powell's conjugate 
%   direction method 

% INPUTS:
% initEulerAng - initial Euler angle guess
% inputBus - input bus structure containing vectors from the origin to 
% point where ray exits glass and enters water and unit vectors to the dot
%   set centroid
% snells - snells parameter structure containing vectors from the center of
%   mass to the dot set centroid

% initEulerAng = [roll pitch yaw]

dsgnVec = zeros(100,6);

% Convergence criteria for position and angular quantities 
posConv = 0.1; % centimeters
angConv = 0.1; % degrees

% Form rCentroid, uCentroid, and bodyFixedVec vectors from structures
rCentroid = zeros(3,length(snells));
uCentroid = zeros(3,length(snells));
bodyFixedVec = zeros(3,length(snells));
for ii = 1:length(snells)
    rCentroid(:,ii) = inputBus(ii).insideGlassVec(:);
    uCentroid(:,ii) = inputBus(ii).unitVec(:);
    bodyFixedVec(:,ii) = snells(ii).bodyFixedVec(:);
end

EulerAng = initEulerAng;
for ii = 1:100
    
    % Calculate body to ground rotation matrix based on Euler angles
    RGB = calculateRotationMatrix(EulerAng(1),EulerAng(2),EulerAng(3));
    RBG = RGB';
    
    % Calculate new center of mass position with method of least squares
    % given ray trace vectors
    CoMPos = snellLeastSquaresPosition(rCentroid,uCentroid,RBG,bodyFixedVec);

    % Calculate new Euler angle prediction using Powell's method given
    % center of mass and ray trace vectors
    EulerAng = powellsMethod(EulerAng,CoMPos,rCentroid,uCentroid,bodyFixedVec);
   
    dsgnVec(ii,:) = [CoMPos(:)' EulerAng(:)'*180/pi];
    
    % Check design variables for convergence
    if ii>2 && ...
            all(abs(dsgnVec(end,1:3)-dsgnVec(end-1,1:3)) < posConv) && ...
            all(abs(dsgnVec(end,4:6)-dsgnVec(end-1,4:6)) < angConv)
       break 
    end

end

end

