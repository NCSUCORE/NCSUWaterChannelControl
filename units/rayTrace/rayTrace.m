function [rogG,rigG,uiG] = ...
    rayTrace(camPosVec,grnd2CamRotMat,dist2Glass,gammaH,gammaV,indOfRef,...
    glassPlane,glassThickness,Periscope)
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
%   glassPlane - string 'xy' or 'xz' describing the plane that the glass
%   lies in
%   Important points in this geometry (lower case):
%   o: point where the ray in question hits the outside of the glass
%   i: point where the ray emerges on the inside of the glass
%   m: point where midline of camera (z axis) intersects the glass
%   g: origin of ground fixed coordinate system
%   c: origin of camera fixed coordinate system
%   Coordinate systems (upper case):
%   G: Tunnel-fixed coordinate system (aka ground-fixed coordinate system)
%   C: video camera coordinate system
%   Naming convention:
%   leading r denotes position vector, leading u denotes unit vector
%   next three letters are in the order
%   [point at tip of vector][point at base of vector][coordinate system]
%   ex: ucgG is the camera position vector in the ground frame

%   OUTPUTS:
%   rogG - vector from the ground origin to the point where the ray enters
%   the glass, from the air, in the ground frame
%   rigG - vector from the ground origin to the point where the ray exits 
%   the glass and enters the water, in the ground frame 
%   uiG - unit vector pointing into the water parallel to the direction of
%   travel of the ray.

%% Step 1: Get position of point where ray enters glass

% unit vector normal to glass pointing out, in ground frame
switch glassPlane
    case 1 % xy plane
        nG = [0 0 -1]';
    case 2 % xz plane
        nG = [0 1 0]';
    case 3 % yz plane
        nG = [1 0 0]';
    otherwise
        nG = [0 0 -1]';
end
% rotate into cam frame
nC    = grnd2CamRotMat*nG; % unit vector normal to glass pointing out, in camera frame
umcC  = [0 0 -1]';         % unit vector pointing at m from c in C frame
rmcC  = dist2Glass*umcC;   % vector pointing at m from c, in C frame

% unit vector pointing from c to o in C frame
uocC = [-tan(gammaV) tan(gammaH) -1]';

uocCMag = sqrt(sum(uocC.^2));
uocC = uocC./uocCMag;

if Periscope ==1 
R_correction = [cos(-0.5*pi) 0  sin(-0.5*pi);
                   0      1     0 ;
                  cos(-0.5*pi) 0  sin(-0.5*pi)];

uocC = R_correction*uocC;
end 
% vector from c to o in C
[rocC,~] = linePlaneIntersect(uocC,[0 0 0]',rmcC,[0 0 0]',nC);

% rocC = (dot(nC,rmcC)/dot(nC,uocC))*uocC;

%% Step 2: Bend with Snells law into glass
uioC = snellsLaw3D(uocC,nC,indOfRef(1),indOfRef(2)); % Direction
rioC = -glassThickness*uioC/dot(uioC,nC); % Scale to get correct magnitude

%% Step 3: Exit glass, get direction from Snells law
uiC = snellsLaw3D(uioC,nC,indOfRef(2),indOfRef(3));

%% Step 4: Output in absolute ground coordinates
% Note that (:) ensures it comes out as a column vector
rogG = camPosVec(:) + grnd2CamRotMat'*rocC(:);
rigG = rogG(:)      + grnd2CamRotMat'*rioC(:);
uiG  = grnd2CamRotMat'*uiC(:);
end

