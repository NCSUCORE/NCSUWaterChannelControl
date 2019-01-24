function [rx,ry,rz,error] = findUnitVectors(xxCam1,xxCam3a,yxCam3a,zxCam1,...
    xyCam3b,yyCam2,yyCam3b,zyCam2,sideSep,bottomASep,bottomBSep,cameraAngle)
%#codegen

% This function has 2 purposes:
% 1) Resolve components of the body fixed unit vectors in the
% ground fixed coordinate system
% 2) Calculate a signal which characterizes how successful the orientation
% resolution is. It does this by computing the dot product of the 
% normalized body fixed x unit vector and the normalized body fixed y unit 
% vector.  The result is output as the "error".  In a perfect system, this
% value would always be zero.


% The z component of the y unit vector (zyCam2) be effected by the angle of
% the camera, as well as the yaw.
% Note that cam 2 and cam 3b are tracking the same dots so no need to
% normalize before this calculation.
zyCam2 = (zyCam2-xyCam3b*sind(cameraAngle))/cosd(cameraAngle);
yyCam2 = (yyCam2-xyCam3b*cosd(cameraAngle))/sind(cameraAngle);
% note that the x component of the x unit vector and the y component of the
% y unit vector are both over-determined (calculated twice).  We're gonna
% use this to our advantage by constructing the x and y unit vectors twice
% and then taking their average.  Hopefully this will smooth out some
% noise and reduce error somewhat.

% Calculate the body fixed x unit vectors
rx1 = [xxCam1  yxCam3a*sideSep/bottomASep zxCam1];
rx2 = [xxCam3a yxCam3a                    zxCam1*bottomASep/sideSep];

% normalize both vectors
rx1 = rx1./sqrt((rx1(1))^2+(rx1(2))^2+(rx1(3))^2);
rx2 = rx2./sqrt((rx2(1))^2+(rx2(2))^2+(rx2(3))^2);

% average the two vectors
rx = (rx1+rx2)./2;

% normalize the result
rx = rx./sqrt((rx(1))^2+(rx(2))^2+(rx(3))^2);

% Calculate the body fixed y unit vectors
ry1 = [xyCam3b yyCam2 zyCam2];  % This line seems
% problematic, probably need to do an adjustment to yyCam2 before
% implementing this.  Similiar to adjustment done to zyCam2 above.
% ry = [xyCam3b                       yyCam3b zyCam2*bottomASep/bottomBSep];
ry2 = [xyCam3b yyCam3b zyCam2]; % cam3b and cam2 track the same dots, so there should be no need for scaling/normalization in this line


% normalize both vectors
ry1 = ry1./sqrt((ry1(1))^2+(ry1(2))^2+(ry1(3))^2);
ry2 = ry2./sqrt((ry2(1))^2+(ry2(2))^2+(ry2(3))^2);

% average the two vectors
ry = (ry1+ry2)./2;

% normalize the result
ry = ry./sqrt((ry(1))^2+(ry(2))^2+(ry(3))^2);

% z = x cross y
rz = cross(rx, ry);

% error is the dot product of the two
error = dot(rx,ry);
end