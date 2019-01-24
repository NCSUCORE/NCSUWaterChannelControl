function [x1,x2,y1,y2,z] = ...
    findPosition(rSideGF,rBottomAGF,rBottomBGF,R,rSideBF,rBottomABF,rBottomBBF)
%#codegen

% Find x from side camera
% Find y from bottom A dots
x1 = rBottomAGF(1);
y1 = rBottomAGF(2);

x1 = x1 - (R(1,1)*rSideBF(1)    + R(1,2)*rSideBF(2)    + R(1,3)*rSideBF(3));
y1 = y1 - (R(2,1)*rBottomABF(1) + R(2,2)*rBottomABF(2) + R(2,3)*rBottomABF(3));

% Find x from bottom A dots
% Find y from bottom B dots
% Note: these values are not used in the model, just logged.
x2 = rSideGF(1);
y2 = rBottomBGF(2);

x2 = x2 - (R(1,1)*rBottomABF(1) + R(1,2)*rBottomABF(2) + R(1,3)*rBottomABF(3));
y2 = y2 - (R(2,1)*rBottomBBF(1) + R(2,2)*rBottomBBF(2) + R(2,3)*rBottomBBF(3));

% Find z from side camera (only way possible).
z = rSideGF(3);
z = z - (R(3,1)*rSideBF(1)    + R(3,2)*rSideBF(2)    + R(3,3)*rSideBF(3));


