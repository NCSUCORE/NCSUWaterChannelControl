function [xF,err] = goldenSection(xL,xR,R,D,U,w,maxIGS,posTol,angTol,err)
% Function to implement golden section to minimize a scalar function


% Begin golden section
tau = 1 - 0.38197;
for ii = 1:maxIGS
    xTwo = (1-tau)*xL + tau*xR;
    xOne = tau*xL+(1-tau)*xR;
    fOne = perfIndx(xOne,R,D,U,w);
    fTwo = perfIndx(xTwo,R,D,U,w);
    
    if sum((xL(1:3)-xR(1:3)).^2) < posTol^2 &&... % Positional tolerance
            sum((xL(4:6)-xR(4:6)).^2) < angTol^2 % Angular tolerance
        break
    end
    if fOne>fTwo
        xL = xOne;
    else
        xR = xTwo;
    end
end

if ii == maxIGS
    err(3) = true;
end
xF = (xL(:)+xR(:))/2;
end