function dotSeparationVec_cm = ...
    findUnitVectorComponents(distance,Dot1PositionVec_px,Dot2PositionVec_px,...
    cameraViewAngleVec_deg, cam2GroundRotationMatrix, imageDimensions)

% This function calcualtes the dot separation vector (in cm) between the 
% specified dot locations (in px) passed into function

%#codegen

% INPUTS:
% distance - distance from camera to dot centroid
% Dot1PositionVec_px - dot 1 pixel coordinate location of left (or top) dot
% in the frame
% Dot2PositionVec_px - horizontal pixel coordinate location of the right 
% (or bottom) dot in the frame
% cameraViewAngleVec_deg - two element vector, first characterizes the width
% of the field of view (camera horizontal), the second characterizes the
% height of the field of veiw (camera vertical)
% imageDimensions - dimension of image captured by camera [row col]

% Right minus left for horizontal, bottom minus top for vertical
% [Row Separation Column Separation]
dotSeparation_px  = (Dot2PositionVec_px(:) - Dot1PositionVec_px(:))';

% Reshape imageDimensions to be column vector
imageDimensions = imageDimensions(:)';

% Perform pixel to centimeter conversion
dotSeparationVec_cm  = (2*distance*tand(flip(cameraViewAngleVec_deg)))...
    .*(dotSeparation_px./imageDimensions);


end












