function [ux,uy,uz,error,rxRaw,ryRaw] = findUnitVectors(unitVecCam1,unitVecCam2a,...
    unitVecCam2b,unitVecCam3,sideSep,bottomASep,bottomBSep,topSep,DSB,DBL)
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
    -unitVecCam2a(1)/bottomASep;-unitVecCam2a(2)/bottomASep];

% Flip sign of unit vectors from bottom cam B (unitVecCam2b) and slant cam
% (unitVecCam3) because of reverse orientation with ground fixed frame
dBL = [unitVecCam2b(1)/bottomBSep;unitVecCam2b(2)/bottomBSep;...
    unitVecCam3(1)/topSep;unitVecCam3(2)/topSep];

% Calculate rx and ry vectors
rx = DSB * dSB;
ry = DBL * dBL;

% Raw values pre-normalization used for testing
rxRaw = rx;
ryRaw = ry;

% Normalize vectors to get unit vectors
ux = rx./max(norm(rx),eps);
uy = ry./max(norm(ry),eps);

% z = x cross y
uz = cross(ux, uy);

% Error is the absolute value of the dot product of the two vectors
error = abs(dot(ux,uy));

end