function xF = goldenSection(xL,xR,R,D,U,w)
% Function to implement golden section to minimize a scalar function


% Begin golden section
tau = 1 - 0.38197;
for ii = 1:100
    xTwo = (1-tau)*xL + tau*xR;
    xOne = tau*xL+(1-tau)*xR;
    fOne = perfIndx(xOne,R,D,U,w);
    fTwo = perfIndx(xTwo,R,D,U,w);
    
    if sqrt(sum((xL(1:3)-xR(1:3)).^2)) < 0.001 &&... % Positional tolerance
            sqrt(sum(xL(4:6)-xR(4:6)).^2) < 0.0001*pi/180
        break
    end
    if fOne>fTwo
        xL = xOne;
        fL = fOne;
    else
        xR = xTwo;
        fR = fTwo;
    end
end
xF = (xL(:)+xR(:))/2;

end