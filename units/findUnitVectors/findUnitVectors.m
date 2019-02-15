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

% The z component of the y unit vector (zyCam2) be effected by the angle of
% the camera, as well as the yaw.
% Note that cam 2 and cam 3b are tracking the same dots so no need to
% normalize before this calculation.

% Compensating for the fact that the slant camera sees an apparent
% displacement when is model is flying level but yawed.

% Need to verify further. 
% zyCam3 = (zyCam3-xyCam2b*sind(cameraAngle))/cosd(cameraAngle);
% yyCam2b = (yyCam2b-xyCam2b*cosd(cameraAngle))/sind(cameraAngle);
% % note that the x component of the x unit vector and the y component of the
% % y unit vector are both over-determined (calculated twice).  We're gonna
% % use this to our advantage by constructing the x and y unit vectors twice
% % and then taking their average.  Hopefully this will smooth out some
% % noise and reduce error somewhat.
% 
% % Calculate the body fixed x unit vectors
% rx1 = [xxCam1  yxCam2a*sideSep/bottomASep zxCam1];
% rx2 = [xxCam2a yxCam2a                    zxCam1*bottomASep/sideSep];
% 
% % Calculate magnitudes of vectors
% rx1Mag = sqrt((rx1(1))^2+(rx1(2))^2+(rx1(3))^2);
% rx2Mag = sqrt((rx2(1))^2+(rx2(2))^2+(rx2(3))^2);
% 
% % If both magnitudes not equal to zero, perform normal calculation
% if (rx1Mag ~= 0 && rx2Mag ~= 0)
%    % normalize both vectors
%    rx1 = rx1./rx1Mag;
%    rx2 = rx2./rx2Mag;
% 
%    % average the two vectors
%    rx = (rx1+rx2)./2;
% 
%    % normalize the result
%    rx = rx./sqrt((rx(1))^2+(rx(2))^2+(rx(3))^2);
%    
% % If rx1 magnitude not equal to zero, use rx1;
% elseif (rx1Mag ~= 0)
%     rx1 = rx1./rx1Mag;
%     rx = rx1;
%     
% % If rx2 magnitude not equal to zero, use rx2;
% elseif (rx2Mag ~= 0)
%     rx2 = rx2./rx2Mag;
%     rx = rx2;
%     
% % Else, set rx to default value
% else
%     rx = [1 0 0];
% end
% 
% % Calculate the body fixed y unit vectors
% ry1 = [xyCam2b yyCam2b zyCam3];  % This line seems
% % problematic, probably need to do an adjustment to yyCam2 before
% % implementing this.  Similiar to adjustment done to zyCam2 above.
% % ry = [xyCam3b                       yyCam3b zyCam2*bottomASep/bottomBSep];
% ry2 = [xyCam2b yyCam3 zyCam3]; % cam3b and cam2 track the same dots, so there should be no need for scaling/normalization in this line
% 
% % Calculate magnitudes of vectors
% ry1Mag = sqrt((ry1(1))^2+(ry1(2))^2+(ry1(3))^2);
% ry2Mag = sqrt((ry2(1))^2+(ry2(2))^2+(ry2(3))^2);
% 
% % If both magnitudes not equal to zero, perform normal calculation
% if (ry1Mag ~= 0 && ry2Mag ~= 0)
%    % normalize both vectors
%    ry1 = ry1./sqrt((ry1(1))^2+(ry1(2))^2+(ry1(3))^2);
%    ry2 = ry2./sqrt((ry2(1))^2+(ry2(2))^2+(ry2(3))^2);
% 
%    % average the two vectors
%    ry = (ry1+ry2)./2;
% 
%    % normalize the result
%    ry = ry./sqrt((ry(1))^2+(ry(2))^2+(ry(3))^2);
%    
%    % If ry1 magnitude not equal to zero, use ry1;
% elseif (ry1Mag ~= 0)
%     ry1 = ry1./ry1Mag;
%     ry = ry1;
%     
% % If rx2 magnitude not equal to zero, use rx2;
% elseif (ry2Mag ~= 0)
%     ry2 = ry2./ry2Mag;
%     ry = ry2;
%     
% % Else, set rx to default value
% else
%     ry = [0 1 0];
% end
% 
% % z = x cross y
% rz = cross(rx, ry);
% 
% % error is the dot product of the two
% error = dot(rx,ry);
%%

dSB = [unitVecCam1(1)/sideSep;unitVecCam1(2)/sideSep;...
    unitVecCam2a(1)/bottomASep;unitVecCam2a(2)/bottomASep];
dBL = -[unitVecCam2b(1)/bottomBSep;unitVecCam2b(2)/bottomBSep;...
    unitVecCam3(1)/bottomBSep;unitVecCam3(2)/bottomBSep];

rx = DSB * dSB;
ry = DBL * dBL;

% Calculate magnitudes of vectors
rxMag = sqrt((rx(1))^2+(rx(2))^2+(rx(3))^2);

% If both magnitudes not equal to zero, perform normal calculation
if (rxMag ~= 0)
    % normalize vector
    rx = rx./rxMag;
else
    rx = [1;0;0];
end

% Calculate magnitudes of vectors
ryMag = sqrt((ry(1))^2+(ry(2))^2+(ry(3))^2);

% If both magnitudes not equal to zero, perform normal calculation
if (ryMag ~= 0)
    % normalize vector
    ry = ry./ryMag;
else
    ry = [0;1;0];
end

% z = x cross y
rz = cross(rx, ry);

% error is the dot product of the two
error = dot(rx,ry);
end