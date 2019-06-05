function sLims = goldenSection(s0,x0,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm,stepSize,varargin)
% Function to implement golden section to minimize a scalar function
%
% Required Inputs
% x0       - initial guess
% stepSize - initial step size (step size may be reduced if this is too
% big)
%
% Optional Inputs
% DisplayOutput -  true/false prints output to command window
% MaxIterations - Maximum number of iterations before quitting, default =
% 1000
% FunctionConvergence - convergence criteria for function value, set to
% zero to disable, default = 0.01
% InputConvergence - convergence criteria for function input, set to zero
% to disable, default = 0.01
% StepTimeout - Max number of iterations for bounding phase step size
% reduction, default = 1000
% BoundingTimeout - Max number of iterations for bounding phase, default =
% 1000
% 

% Input parsing
p = inputParser;
addRequired(p,'s0',@(s) isnumeric(s) && isscalar(s))
addRequired(p,'x0',@(s) isnumeric(s) && isvector(s))
addRequired(p,'StepSize',@(s) isnumeric(s) && isscalar(s) && s>0)
addOptional(p,'DisplayOutput',false,@(s) islogical(s))
addOptional(p,'MaxIterations',1000,@(s) isnumeric(s) && isscalar(s) && s>0)
addOptional(p,'FunctionConvergence',0.0001,@(s) isnumeric(s) && isscalar(s) && s>=0)
addOptional(p,'InputConvergence',0.0001,@(s) isnumeric(s) && isscalar(s) && s>=0)
addOptional(p,'StepTimeout',100,@(s) isnumeric(s) && isscalar(s))
addOptional(p,'StepSizeMultiplier',2,@(s) isnumeric(s) && isscalar(s)  && s>=1)
addOptional(p,'BoundingTimeout',1000,@(s) isnumeric(s) && isscalar(s))
addOptional(p,'FunctionHandle',@objJ,@(s) isa(s,'function_handle'))
parse(p,s0,x0,stepSize,varargin{:})

% Rename some variables to clean up code later on
fHandle  = p.Results.FunctionHandle;
stepSize = p.Results.StepSize;
s0       = p.Results.s0;
x0       = p.Results.x0;

% Bounding Phase
[sl,sr] = bound(s0,x0,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm,stepSize,...
    'FunctionHandle',p.Results.FunctionHandle,...
    'StepTimeout',p.Results.StepTimeout,...
    'StepSizeMultiplier',p.Results.StepSizeMultiplier,...
    'BoundingTimeout',p.Results.BoundingTimeout,...
    'FunctionHandle',p.Results.FunctionHandle);

% Begin golden section
tau = 1 - 0.38197;
initialRange = abs(sr-sl);
fl = fHandle(sl,x0,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
fr = fHandle(sr,x0,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
% Print column headers to command window for output
if p.Results.DisplayOutput
    headings = {'sl','Fl','s1','F1','s2','F2','sr','Fr','sOpt','FOpt'};
    headingString = [' '];
    for ii = 1:length(headings)
        headingString = [headingString pad(headings{ii},11)];
    end
    fprintf(['\n' headingString '\n'])
end

for ii = 1:p.Results.MaxIterations
    sTwo = (1-tau)*sl+tau*sr;
    sOne = tau*sl+(1-tau)*sr;
    fOne = fHandle(sOne,x0,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
        rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
        sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
    fTwo = fHandle(sTwo,x0,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
        rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
        sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
    fMin = min([fl fr fOne fTwo]);
    fMax = max([fl fr fOne fTwo]);
    sMin = min([sl sr sOne sTwo]);
    sMax = max([sl sr sOne sTwo]);
    if p.Results.DisplayOutput
        fprintf('%10f %10f %10f %10f %10f %10f %10f %10f %10f %10f \n',...
            sl,fl,sOne,fOne,sTwo,fTwo,sr,fr,(sr-sl)/2,fHandle((sr-sl)/2,x0,CoMPos,...
            rCentroidSide,rCentroidBotA,rCentroidBotB,rCentroidSlant,...
            uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
            sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm))
    end
    if abs((fMax-fMin)/fMin) <= p.Results.FunctionConvergence || ...
            abs((sMax-sMin)/initialRange) <= p.Results.InputConvergence
        if p.Results.DisplayOutput
            fprintf('\nSolution converged.  Stopping program.\n')
        end
        break
    end
    if fOne > fTwo
        sl = sOne;
        fl = fOne;
    else
        sr = sTwo;
        fr = fTwo;
    end
end
sLims = [sl sr];
end