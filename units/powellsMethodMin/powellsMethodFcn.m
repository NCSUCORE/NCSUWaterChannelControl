function [min] = powellsMethodFcn(alpha,x,S,CoMPos,rCentroid,uCentroid,...
    bodyFixedVec)

%powellsMethodFcn Summary of this function goes here
%   Detailed explanation goes here

% x = (x + alpha*S);

min = objJ((x + alpha*S)',CoMPos,rCentroid,uCentroid,bodyFixedVec);

end

