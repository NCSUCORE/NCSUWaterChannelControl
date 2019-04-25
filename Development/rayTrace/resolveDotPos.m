function [rDotCamVec_cm] = resolveDotPos(rigG,uiG,COMPos_cm,sideDotPosVec_cm,...
    body2GroundRotationMatrix,dotCoords_px)
%RESOLVEDOTPOS Summary of this function goes here
%   Detailed explanation goes here

dotCoords1_px = dotCoords_px(1:2);
dotCoords2_px = dotCoords_px(3:4);

dotCentroid = 0.5*(dotCoords1_px + dotCoords2_px);

dotSep_px = (dotCoords2_px - dotCoords1_px)';

lastDotPos = COMPos_cm + body2GroundRotationMatrix*sideDotPosVec_cm;

% vecPlane = lastDotPos - rigG;
% 
% vecToPlane = linePlaneIntersect(uiG,uiG,vecPlane);

% [~,rM,uM] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
%     0,0,...
%     indOfRef,glassPlane,glassThickness);
% 
% [~,rTL,uTL] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
%     -gammaH,gammaV,...
%     indOfRef,glassPlane,glassThickness);
% 
% [~,rTR,uTR] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
%     gammaH,gammaV,...
%     indOfRef,glassPlane,glassThickness);
% 
% [~,rBL,uBL] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
%     -gammaH,-gammaV,...
%     indOfRef,glassPlane,glassThickness);
% 
% [~,rBR,uBR] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
%     gammaH,-gammaV,...
%     indOfRef,glassPlane,glassThickness);

[rMInPlaneRel,rMInPlaneAbs] = linePlaneIntersect(uM,rM,lastPosVec_cm,[0 0 0]',uM);
[~,rTLInPlaneAbs] = linePlaneIntersect(uTL,rTL,rMInPlaneRel,rM,uM);
[~,rTRInPlaneAbs] = linePlaneIntersect(uTR,rTR,rMInPlaneRel,rM,uM);
[~,rBLInPlaneAbs] = linePlaneIntersect(uBL,rBL,rMInPlaneRel,rM,uM);
[~,rBRInPlaneAbs] = linePlaneIntersect(uBR,rBR,rMInPlaneRel,rM,uM);

% Calculate side lengthsmid
lLeft   = norm(rTLInPlaneAbs - rBLInPlaneAbs);
lRight  = norm(rTRInPlaneAbs - rBRInPlaneAbs);
lBottom = norm(rBLInPlaneAbs - rBRInPlaneAbs);
lTop    = norm(rTLInPlaneAbs - rTRInPlaneAbs);

dotLengthx_cm = (dotCentroid(2)/imageDimensions(2)*lLeft + ...
                (1 - dotCentroid(2)/imageDimensions(2))*lRight)*dotSep_px(2)/imageDimensions(2);

xUnitVec = ((rTRInPlaneAbs + dotSep_px(1)/imageDimensions(1)*lRight*(rBR - rTR)) - ...
           (rTLInPlaneAbs + dotSep_px(1)/imageDimensions(1)*lLeft*(rBL - rTL)));

xUnitVecMag = sqrt((xUnitVec(1))^2+(xUnitVec(2))^2+(xUnitVec(3))^2);

xUnitVec = xUnitVec./xUnitVecMag;
            
dotLengthy_cm = (dotCentroid(1)/imageDimensions(1)*lBottom + ...
                (1 - dotCentroid(1)/imageDimensions(1))*lTop)*dotSep_px(1)/imageDimensions(1);

yUnitVec = ((rBRInPlaneAbs + dotSep_px(2)/imageDimensions(2)*lBottom*(rBR - rBL)) - ...
           (rBLInPlaneAbs + dotSep_px(2)/imageDimensions(2)*lTop*(rTR - rTL)));

yUnitVecMag = sqrt((yUnitVec(1))^2+(yUnitVec(2))^2+(yUnitVec(3))^2);

yUnitVec = yUnitVec./yUnitVecMag;

end

