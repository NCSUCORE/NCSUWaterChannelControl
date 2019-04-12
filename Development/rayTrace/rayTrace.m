function [rOut,uOut] = ...
    rayTrace(camPosVec,grnd2CamRotMat,dist2Glass,gammaH,gammaV,indOfRef,...
    glassPlane,glassThickness)
%RAYTRACE Function to trace a ray out from a camera, into the water channel
%   INPUTS:
%   camPosVec - 3 element column vector describing the position of the
%   center of the front of the lens, relative to the ground fixed
%   coordinate system.
%   grnd2CamRotMat - 3x3 rotation matrix that takes a vector from the
%   ground fixed coordinate system and produces a vector in the camera
%   fixed coordinate system
%   dist2Glass - distance in cm along the camera z axis, from the front of
%   the lens to the glass
%   gammaH - rotation about camera x that describes the orientation of the
%   desired sight line (rotation order is x then y)
%   gammaV - rotation about camera Y that describes the orientation of the
%   desired sight line (rotation order is x then y)
%   indOfRef - 3 element vector containing the indices of refraction [air,
%   glass, water]
%   glassPlane - string 'xy' or 'xz' describing the plane that the glas
%   liew in
%   OUTPUTS:
%   point - 3 element column vector describing the point where the sight
%   line emerges from the glass and enters the water, in ground fixed
%   coordinates
%   direction - 3 element unit vector describing the direction of travel of
%   the sight line within the water channel

%% Step 1: Get position of point where ray enters glass
% unit vector normal to glass pointing out, in ground frame
switch lower(glassPlane)
    case 'xy'
        ngG = [0 0 -1]';
    case 'xz'
        ngG = [0 1 0]';
end

ngC = grnd2CamRotMat*ngG;   % unit vector normal to glass pointing out, in camera frame

uCGCC = [0 0 -1]';          % unit vector pointing at CG from C, in C frame
rCGCC = dist2Glass*uCGCC;   % vector pointing at CG from C, in C frame

Rygammav = calculateRotationMatrix(0        ,gammaV     ,0);
Rxgammah = calculateRotationMatrix(gammaH   ,0          ,0);

uACC = Rygammav*Rxgammah*uCGCC;

rACC = ((rCGCC'*ngC)/(uACC'*ngC))*Rygammav*Rxgammah*uCGCC;

%% Step 2: Bend with Snells law
uBAC = snellsLaw3D(uACC,ngC,indOfRef(1),indOfRef(2)); % Direction
rBAC = -glassThickness*uBAC/dot(uBAC,ngC); % Scale to get correct magnitude

%% Step 3: Exit glass, get direction from Snells law
uOut = snellsLaw3D(uBAC,ngC,indOfRef(2),indOfRef(3));

%% Step 4: Output in absolute ground coordinates

uOut = grnd2CamRotMat'*uOut;
rBCC = rBAC + rACC; % Exit point relative to cam origin
rOut = camPosVec + grnd2CamRotMat'*rBCC; % rotate back to ground coordinates

end

