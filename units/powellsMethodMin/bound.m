function [sLeft,sRight] = bound(s0,x0,S,CoMPos,rCentroid,uCentroid,...
    bodyFixedVec,stepSize,fHandle)

% Function to bound a given function around an inital guess.
%
% INPUTS:
% s0 - initial guess
% x0 - current Euler angle guess
% S - matrix of search directions
% CoMPos - center of mass position in ground frame 
% rCentroid - inside of glass vectors from ray trace algorithm in ground frame
% uCentroid - unit vectors from ray trace algorithm in ground grame
% bodyFixedVec - vectors from center of mass to dot set centroids
% stepSize - initial step size (step size may be reduced if this is too
% big)
% fHandle - function handle containing powellsMethodFcn

% OUTPUTS:
% sLeft - left bound on variable
% sRight - right bound on variable

sign = 1;

for tryCount = 1:1000
    fcurrentStep = fHandle(s0,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec);
    fbeforeStep = fHandle(s0-stepSize,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec);
    fafterStep = fHandle(s0+stepSize,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec);
    if fbeforeStep >= fcurrentStep && fcurrentStep >= fafterStep
        sign = +1;
        break
    elseif fbeforeStep <= fcurrentStep && fcurrentStep <= fafterStep
        sign = -1;
        break
    end
    stepSize = stepSize/2^tryCount;
end

sCurrent = s0;
for ii = 0:999
    sRight = sCurrent + sign*stepSize*2^ii;
    sLeft = sCurrent;
    fRight = fHandle(sRight,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec);
    rCurrent = fHandle(sCurrent,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec);
    if fRight > rCurrent
        break
    end
    sLeft = sCurrent;
    sCurrent = sRight;
end

if sign == -1
   sTemp  = sort([sLeft sRight]) ;
   sLeft  = sTemp(1);
   sRight = sTemp(2);
end

end