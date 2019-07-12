function [min] = powellsMethodFcn(alpha,x,S,CoMPos,rCentroid,uCentroid,...
    bodyFixedVec)

% Minimization function used as basis for powell's method optimization.
%
% INPUTS:
% alpha - optimal scalar distance
% x0 - current Euler angle guess
% S - matrix of search directions
% CoMPos - center of mass position in ground frame 
% rCentroid - inside of glass vectors from ray trace algorithm in ground frame
% uCentroid - unit vectors from ray trace algorithm in ground grame
% bodyFixedVec - vectors from center of mass to dot set centroids

% OUTPUTS:
% min - value of J following function call

% Call objJ given current parameters
min = objJ((x + alpha*S)',CoMPos,rCentroid,uCentroid,bodyFixedVec);

end

