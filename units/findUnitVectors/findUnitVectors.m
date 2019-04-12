function [rx,ry,rz,error] = findUnitVectors(unitVecCam1,unitVecCam2a,...
    unitVecCam2b,unitVecCam3,sideSep,bottomASep,bottomBSep,DSB,DBL)
%#codegen

% This function has 2 purposes:
% 1) Resolve components of the body fixed unit vectors in the
% ground fixed coordinate system
% 2) Calculate a signal which characterizes how successful the orientation
% resolution is. It does this by computing the dot product of the 
% normalized body fixed x unit vector and the normalized body fixed y unit 
% vector.  The result is output as the "error".  In a perfect system, this
% value would always be zero.

% Normalize the unit vector components in terms of the dot separation
% distance
% Flip sign of unit vectors from side cam (unitVecCam1) because of side
% cam location on +y axis
dSB = [-unitVecCam1(1)/sideSep;-unitVecCam1(2)/sideSep;...
    unitVecCam2a(1)/bottomASep;unitVecCam2a(2)/bottomASep];

% Flip sign of unit vectors from bottom cam A (unitVecCam2b) and slant cam
% (nitVecCam3) because of reverse orientation with ground fixed frame
dBL = -[unitVecCam2b(1)/bottomBSep;unitVecCam2b(2)/bottomBSep;...
    unitVecCam3(1)/bottomBSep;unitVecCam3(2)/bottomBSep];

% Calculate rx and ry vectors
rx = DSB * dSB;
ry = DBL * dBL;

% Calculate magnitudes of vectors
rxMag = sqrt((rx(1))^2+(rx(2))^2+(rx(3))^2);

% If both magnitudes not equal to zero, perform normal calculation
if (rxMag ~= 0)
    % Normalize vector
    rx = rx./rxMag;
else
    % If magnitude equal to zero, set default value to avoid divide by zero
    rx = [1;0;0];
end

% Calculate magnitudes of vectors
ryMag = sqrt((ry(1))^2+(ry(2))^2+(ry(3))^2);

% If both magnitudes not equal to zero, perform normal calculation
if (ryMag ~= 0)
    % Normalize vector
    ry = ry./ryMag;
else
    % If magnitude equal to zero, set default value to avoid divide by zero
    ry = [0;1;0];
end

% z = x cross y
rz = cross(rx, ry);

% Error is the absolute value of the dot product of the two vectors
error = abs(dot(rx,ry));

end