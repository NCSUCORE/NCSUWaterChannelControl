function [roll,pitch,yaw,R] = findEulerAngles(rx,ry,rz)

%#codegen

% The purpose of this function is to calculate the euler angles from the
% body fixed unit vectors rx, ry and rz.

% Build rotation matrix from unit vectors, spell it out explicitly for
% safety since I don't know if rx, ry and rz are being passed as row or
% column vectors
% R is rotation matrix from body fixed coordinates to ground fixed
% coordinates
R = [rx(1) ry(1) rz(1);...
     rx(2) ry(2) rz(2);...
     rx(3) ry(3) rz(3)];

% Calculate pitch angle based on -R(3,1) (property of rotation matrix)
pitch = asin(-R(3,1));

% Saturate the pitch to +/- pi/4 to  avoid divide by zero errors in the
% next step.

if pitch > pi/4
    pitch = pi/4;
end
if pitch < -pi/4
    pitch = -pi/4;
end

% Calculate yaw argument based on R(2,1)/cos(pitch) (property of rotation matrix)
yawArg = R(2,1)/cos(pitch);

% Calculate roll argument based on R(3,2)/cos(pitch) (property of rotation matrix)
rollArg = R(3,2)/cos(pitch);

% Note: arcsin gives a real answer on the range -1 to 1 so we should
% saturate the argument to the arcsin function.

if yawArg > 1
    yawArg = 1;
end
if yawArg < -1 
    yawArg = -1;
end

if rollArg > 1
    rollArg = 1;
end
if rollArg < -1 
    rollArg = -1;
end

% Calculate yaw and roll angles by using arcsin of respective arguments
yaw   = asin(yawArg);
roll  = asin(rollArg);

end