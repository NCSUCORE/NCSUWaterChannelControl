function xStar = threePointQuadratic(s0,x0,S,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm,stepSize,varargin)

% Input parsing
p = inputParser;
addRequired(p,'s0',@(s) isnumeric(s) && isscalar(s))
% addRequired(p,'x0',@(s) isnumeric(s) && isvector(s))
% addRequired(p,'S',@(s) isnumeric(s) && isvector(s))
addRequired(p,'StepSize',@(s) isnumeric(s) && isscalar(s) && s>0)
addOptional(p,'DisplayOutput',false,@(s) islogical(s))
addOptional(p,'MaxIterations',1000,@(s) isnumeric(s) && isscalar(s) && s>0)
addOptional(p,'FunctionConvergence',0.0001,@(s) isnumeric(s) && isscalar(s) && s>=0)
addOptional(p,'InputConvergence',0.0001,@(s) isnumeric(s) && isscalar(s) && s>=0)
addOptional(p,'StepTimeout',100,@(s) isnumeric(s) && isscalar(s))
addOptional(p,'StepSizeMultiplier',2,@(s) isnumeric(s) && isscalar(s)  && s>=1)
addOptional(p,'BoundingTimeout',1000,@(s) isnumeric(s) && isscalar(s))
addOptional(p,'FunctionHandle',@objJ,@(s) isa(s,'function_handle'))
parse(p,s0,stepSize,varargin{:})

% Rename some variables to clean up code later on
fHandle  = p.Results.FunctionHandle;
stepSize = p.Results.StepSize;
s0       = p.Results.s0;
% x0       = p.Results.x0;

% Bounding Phase
[sl,sr] = bound(s0,x0,S,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm,stepSize,...
    'FunctionHandle',p.Results.FunctionHandle,...
    'StepTimeout',p.Results.StepTimeout,...
    'StepSizeMultiplier',p.Results.StepSizeMultiplier,...
    'BoundingTimeout',p.Results.BoundingTimeout,...
    'FunctionHandle',p.Results.FunctionHandle);

sm = (sl+sr)/2;
fl = fHandle(sl,x0,S,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
fr = fHandle(sr,x0,S,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
fm = fHandle(sm,x0,S,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);

for ii = 1:p.Results.MaxIterations
    a1 = (fm-fl)/(sm-sl);
    a2 = (1/(sr-sm))*(((fr-fl)/(sr-sl))-((fm-fl)/(sm-sl)));
    if a2 == 0
        a2 = eps;
    end
    xStar = ((sm+sl)/2)-(a1/(2*a2));
    if abs(sr-sl) < p.Results.InputConvergence
        break
    end
    if abs(fr-fl) < p.Results.FunctionConvergence
        break
    end
    if xStar < sm
        sr = sm;
        fr = fm;
    elseif xStar > sm
        sl = sm;
        fl = fm;
    end
    sm = xStar;
    fm = fHandle(sm,x0,S,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
        rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
        sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
end
end