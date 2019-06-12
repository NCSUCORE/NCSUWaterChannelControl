function [sLeft,sRight] = bound(s0,x0,S,CoMPos,rCentroid,uCentroid,...
    bodyFixedVec,stepSize,fHandle)

% p = inputParser;
% 
% % Number of iterations before stopping attempt to tune step size
% addOptional(p,'StepTimeout',1000,@(s) isnumeric(s) && isscalar(s))
% % How much to increase the step size at every iteration
% addOptional(p,'StepSizeMultiplier',2,@(s) isnumeric(s) && isscalar(s) && s>=1)
% % Number of iterations before quitting bounding phase
% addOptional(p,'BoundingTimeout',1000,@(s) isnumeric(s) && isscalar(s))
% % Handle of the function that you want to minimize
% addOptional(p,'FunctionHandle',@objJ,@(s) isa(s,'function_handle'))
% % Initial point/guess
% addRequired(p,'s0',@(s) isnumeric(s) && isvector(s))
% 
% addRequired(p,'x0',@(s) isnumeric(s) && isvector(s))
% % Step size
% addRequired(p,'StepSize',@(s) isnumeric(s) && isscalar(s) && s>0)
% 
% parse(p,s0,x0,stepSize,varargin{:})
% 
% fHandle  = p.Results.FunctionHandle;
% stepSize = p.Results.StepSize;
% s0       = p.Results.s0;
% x0       = p.Results.x0;

sign = 1;

for tryCount = 1:1000
    if fHandle(s0-stepSize,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec) >= ...
       fHandle(s0,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec) && ...
       fHandle(s0,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec) >= ...
       fHandle(s0+stepSize,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec)
        sign = +1;
        break
    elseif fHandle(s0-stepSize,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec) <= ...
           fHandle(s0,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec) && ...
           fHandle(s0,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec) <= ...
           fHandle(s0+stepSize,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec)
        sign = -1;
        break
    end
    stepSize = stepSize/2^tryCount;
end

sCurrent = s0;
for ii = 0:999
    sRight = sCurrent + sign*stepSize*2^ii;
    sLeft = sCurrent;
    if fHandle(sRight,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec) > ...
       fHandle(sCurrent,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec)
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