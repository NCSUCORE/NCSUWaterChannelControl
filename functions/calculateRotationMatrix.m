function R = calculateRotationMatrix(roll,pitch,yaw)

% This funciton calculates the rotation matrix called RGB in the Mathematica
% notebook rotationMatrix.nb located in the documentation folder.

% This rotation matrix rotates vectors from ground coordinate system to
% body/camera coordinate system

% Yaw part of rotation matrix
Ryaw = [...
    cos(yaw) sin(yaw) 0;...
    -sin(yaw) cos(yaw) 0;...
    0 0 1];

% Pitch part of rotation matrix
Rpitch = [...
    cos(pitch) 0 -sin(pitch);...
    0 1 0;...
    sin(pitch) 0 cos(pitch)];

% Roll part of rotation matrix
Rroll = [...
    1 0 0;...
    0 cos(roll) sin(roll);...
    0 -sin(roll) cos(roll)];

% Combine each component to form full RGB (ground to body) rotation matrix
R = Rroll*Rpitch*Ryaw;


