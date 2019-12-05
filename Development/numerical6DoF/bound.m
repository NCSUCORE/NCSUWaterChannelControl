function [sL,sR,JL,JR,err] = bound(x0,g,s,R,D,U,w)

% inputs: x0 first point to test, u0: normalized gradient at that point,
% s: step size

x0 = x0(:);
g  = g(:);

sL = 0;
sR = s;
JL = perfIndx(x0(:)-g(:)*sL,R,D,U,w);
JR = perfIndx(x0(:)-g(:)*sR,R,D,U,w);

% If that way is up, then reverse direction
if JR > JL
    s  = -s;
    sR = -s;
end

err = false;

for ii = 2:50
    sNew = sR + s*2^(ii-1);
    JNew = perfIndx(x0-g*sNew,R,D,U,w);
    if JNew > JR
        JR = JNew;
        sR = sNew;
        break
    else
        JL = JR;
        sL = sR;
        JR = JNew;
        sR = sNew; 
    end
end

% If we ran for the maximum number of iterations, quit out.
if ii == 50
     err = true;
end

end