function [x,HInv,errInt] = BFGS(x,HInv,R,D,U,w,...
    dx,stepSize,... 
    maxIBFGS,maxIGS,maxIBP,...
    posTolBFGS,posTolGS,...
    angTolBFGS,angTolGS)
errBool = false([8 1]);

errBool(2) = true;
for ii = 1:maxIBFGS
    % Search direction
    g0     = numGrad(x,dx,R,D,U,w);
    dirVec = HInv*g0(:);
    
    % Line search
    [sL,sR,~,~,errBool] = bound(x(:),dirVec(:),stepSize,R,D,U,w,maxIBP,errBool);
    [xF,errBool] = goldenSection(x(:)-sL*dirVec(:), x(:)-sR*dirVec(:),...
        R,D,U,w,maxIGS,posTolGS,angTolGS,errBool);

    % Calcuate step vector that we're taking
    s = xF(:)-x(:);
    
    % Update y = change in gradient over this step
    gF = numGrad(xF,dx,R,D,U,w);
    y = gF(:)-g0(:);
    
    % Update Hinv (inverse of estimated Hessian)
    HInv = HInv + ...
        ((s'*y+y'*HInv*y)*(s*s'))/(s'*y)^2 - ...
        ((HInv*y*s')+(s*y'*HInv))/(s'*y);
    
    % Set the current point to the result of the line search
    x = xF;
    
    % Wrap Euler angles to +/- pi
    x(4:6) = rem(x(4:6),pi);

    % If the position is precise enough and the euler angles are too,
    if sum(s(1:3).^2) < posTolBFGS^2 && ...
            sum(s(4:6).^2)< angTolBFGS^2
        errBool(2) = false;
        break
    end
end

% Bit-pack the error vector
errInt = int8([2^0 2^1 2^2 2^3 2^4 2^5 2^6 2^7]*double(errBool(:)));
end