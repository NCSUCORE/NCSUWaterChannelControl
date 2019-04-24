function [rDotCamVec_cm] = resolveDotPos(rigG,uiG,COMPos_cm,sideDotPosVec_cm,...
    body2GroundRotationMatrix,dotCoords_px)
%RESOLVEDOTPOS Summary of this function goes here
%   Detailed explanation goes here

dotCoords1_px = dotCoords_px(1:2);
dotCoords2_px = dotCoords_px(3:4);

dotCentroid = 0.5*(dotCoords1_px + dotCoords2_px);

dotSep_px = (dotCoords2_px - dotCoords1_px)';

lastDotPos = COMPos_cm + body2GroundRotationMatrix*sideDotPosVec_cm;

vecPlane = lastDotPos - rigG;

vecToPlane = linePlaneIntersect(uiG,uiG,vecPlane);

end

