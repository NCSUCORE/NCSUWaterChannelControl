function dotSeparationVec_cm = ...
    findUnitVectorComponents(distance,Dot1PositionVec_px,Dot2PositionVec_px,...
    cameraViewAngleVec_deg, cam2GroundRotationMatrix, imageDimensions)
%#codegen
% 
% % INPUTS:
% % d - distance from camera to dot centroid
% % xLeft - horizontal pixel coordinate location of left dot in the frame
% % xRight - horizontal pixel coordinate location of the right dot in the
% % frame
% % yLeft - vertical pixel coordinate location of the left dot in the frame
% % yRight -  vertical pixel coordinate location of the right dot in the
% % frame
% % viewAngle - two element vector, first characterizes the width of the
% % field of view (camera horizontal), the second characterizes the height of
% % the field of veiw (camera vertical).
% xLeft = Dot1PositionVec_px(2);
% yLeft = Dot1PositionVec_px(1);
% 
% xRight = Dot2PositionVec_px(2);
% yRight = Dot2PositionVec_px(1);
% 
% % Calculate dot separations in pixels
% % Camera-X separation will contribute to y component of body fixed y unit
% % vector, if left dot is to the left of right dot (xLeft<xRight), then the 
% % component will have a positive value.  Camera-Y separation
% % will contribute to x component of body fixed y unit vector if left dot is
% % below right dot (yLeft>yRight),
% % then this should have a positive value.
% yy = -(xLeft - xRight); 
% xy = (yLeft - yRight);
% 
% % Convert pixels to length
% % The (2*d*tand(viewAngle(1))) term calculates the total horizontal (or
% % vertical)
% % distance spanned by the camera field of view, the /2048 and /1088 terms
% % normalize the separations by the total number of pixels.
% xy = (2*d*tand(cameraViewAngleVec_deg(1)))*(xy/2048); % y component of body fixed y
% yy = (2*d*tand(cameraViewAngleVec_deg(2)))*(yy/1088); % z component of body fixed y
% 
% 
% yc=(xLeft+xRight)/2;
% xc=(yLeft+yRight)/2;
% 
% % Need to determine use
% % yy = yy/cosd(20*((544-yc)/544));
% % xy = xy/cosd(20*((1024-xc)/1024));

% %% New code starts here
% Right minus left for horizontal, bottom minus top for vertical
dotSeparation_px  = (Dot2PositionVec_px - Dot1PositionVec_px)'; % [Row Separation Column Separation]

dotSeparation_px =  reshape(dotSeparation_px,[],1)';

imageDimensions = reshape(imageDimensions,[],1)';
dotSeparationVec_cm  = (2*distance*tand(flip(cameraViewAngleVec_deg))).*(dotSeparation_px./imageDimensions);












