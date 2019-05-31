function xOut = BFGS(x0,varargin)
parseInput
H = eye(numel(p.Results.x0));
c = grad(p,p.Results.x0);
L = norm(c);
xOut = p.Results.x0';
xOutPrev = xOut;
F = p.Results.FunctionHandle(xOut);
logOutput
while L>p.Results.GradientConvergence
    s = -H\c';
    alphaLims = goldenSection(0,...
        p.Results.StepSize,'FunctionHandle',...
        @(alpha) p.Results.FunctionHandle(xOut+alpha*s),...
        'StepTimeout',p.Results.StepTimeout,...
        'StepSizeMultiplier',p.Results.StepSizeMultiplier,...
        'BoundingTimeout',p.Results.BoundingTimeout,...
        'StepSize',p.Results.StepSize);
    alphaStar = mean(alphaLims);
    xOut = xOut+alphaStar*s;
    F(end+1) = p.Results.FunctionHandle(xOut);
    logOutput
    y = grad(p,xOut) - c;
    P = xOut - xOutPrev;
    D = y'*y/(y*P);
    E = c'*c/(c*s);
    H = D+E+H;
    c = grad(p,xOut);
    L = norm(c);
end

end