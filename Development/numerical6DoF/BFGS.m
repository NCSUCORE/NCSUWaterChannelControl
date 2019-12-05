function [x,J,HInv] = BFGS(x,Hinv,dx,stepSize,R,D,U,w)

posTol = 0.001;
angTol = 0.0001*pi/180;

for ii = 1:100
    % Search direction
    g0 = numGrad(x,dx,R,D,U,w);
    dirVec = Hinv*g0(:);
    % Line search
    [sL,sR,~,~,~] = bound(x(:),dirVec(:),stepSize,R,D,U,w);
    xF = goldenSection(x(:)-sL*dirVec(:), x(:)-sR*dirVec(:),R,D,U,w);
    J = perfIndx(xF,R,D,U,w)
    % Calcuate step vector that we're taking
    s = xF(:)-x(:);
    
    % Update y, change in gradient
    gF = numGrad(xF,dx,R,D,U,w);
    y = gF(:)-g0(:);
    
    % Update Hinv
    Hinv = Hinv + ...
        ((s'*y+y'*Hinv*y)*(s*s'))/(s'*y)^2 - ...
        ((Hinv*y*s')+(s*y'*Hinv))/(s'*y);
    
    x = xF;
    x(4:6) = rem(x(4:6),pi);
    
    % If the position is precise enough and the euler angles are too,
    if sqrt(sum(s(1:3).^2)) < posTol && ...
            sqrt(sum(s(4:6).^2))< angTol
        break
    end
end


end