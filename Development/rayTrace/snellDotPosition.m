function [snellPos_cm] = ...
    snellDotPosition(...
    centroidPos_px,lastPosVec_cm,...
    rM,uM,camPosVec_cm,grnd2CamRotMat,cameraFOV_rad,...
    imageDims_px,dist2Glass,indOfRef,glassPlane,glassThickness)

centroidPos_px = centroidPos_px-imageDims_px/2;

thetaV = atan((-2*centroidPos_px(1)/imageDims_px(1))*tan(cameraFOV_rad(2)));
thetaH = atan(( 2*centroidPos_px(2)/imageDims_px(2))*tan(cameraFOV_rad(1)));

[~,rCentroid,uCentroid] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
    thetaH,thetaV,indOfRef,glassPlane,glassThickness);

[rMInPlaneRel,rMInPlaneAbs] = linePlaneIntersect(uM,rM,lastPosVec_cm,[0 0 0]',uM);

[~,snellPos_cm] = linePlaneIntersect(uCentroid,rCentroid,rMInPlaneRel,rM,uM);

%% PLOTTING FUNCTIONALITY FOR DEBUG PURPOSES
% [~,rTL,uTL] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
%     -cameraFOV_rad(1),cameraFOV_rad(2),...
%     indOfRef,glassPlane,glassThickness);
% 
% [~,rTR,uTR] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
%     cameraFOV_rad(1),cameraFOV_rad(2),...
%     indOfRef,glassPlane,glassThickness);
% 
% [~,rBL,uBL] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
%     -cameraFOV_rad(1),-cameraFOV_rad(2),...
%     indOfRef,glassPlane,glassThickness);
% 
% [~,rBR,uBR] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
%     cameraFOV_rad(1),-cameraFOV_rad(2),...
%     indOfRef,glassPlane,glassThickness);
% 
% 
% [~,rTLInPlaneAbs] = linePlaneIntersect(uTL,rTL,rMInPlaneRel,rM,uM);
% [~,rTRInPlaneAbs] = linePlaneIntersect(uTR,rTR,rMInPlaneRel,rM,uM);
% [~,rBLInPlaneAbs] = linePlaneIntersect(uBL,rBL,rMInPlaneRel,rM,uM);
% [~,rBRInPlaneAbs] = linePlaneIntersect(uBR,rBR,rMInPlaneRel,rM,uM);
% 
% figure
% set(gca,'NextPlot','add');
% quiver3(rM(1),rM(2),rM(3),uM(1),uM(2),uM(3))
% hold on
% quiver3(rTL(1),rTL(2),rTL(3),uTL(1),uTL(2),uTL(3))
% quiver3(rTR(1),rTR(2),rTR(3),uTR(1),uTR(2),uTR(3))
% quiver3(rBL(1),rBL(2),rBL(3),uBL(1),uBL(2),uBL(3))
% quiver3(rBR(1),rBR(2),rBR(3),uBR(1),uBR(2),uBR(3))
% scatter3(lastPosVec_cm(1),lastPosVec_cm(2),lastPosVec_cm(3),...
%     'Marker','o','MarkerFaceColor','r')
% scatter3(snellPos_cm(1),snellPos_cm(2),snellPos_cm(3),...
%     'Marker','x','MarkerFaceColor','b')
% 
% 
% axis square
% axis equal
% grid on
% 
% plot3([rM(1)  rMInPlaneAbs(1)] ,[rM(2)  rMInPlaneAbs(2)] ,[rM(3)  rMInPlaneAbs(3)] )
% plot3([rTL(1) rTLInPlaneAbs(1)],[rTL(2) rTLInPlaneAbs(2)],[rTL(3) rTLInPlaneAbs(3)])
% plot3([rTR(1) rTRInPlaneAbs(1)],[rTR(2) rTRInPlaneAbs(2)],[rTR(3) rTRInPlaneAbs(3)])
% plot3([rBL(1) rBLInPlaneAbs(1)],[rBL(2) rBLInPlaneAbs(2)],[rBL(3) rBLInPlaneAbs(3)])
% plot3([rBR(1) rBRInPlaneAbs(1)],[rBR(2) rBRInPlaneAbs(2)],[rBR(3) rBRInPlaneAbs(3)])
% 
% scatter3(rMInPlaneAbs(1) ,rMInPlaneAbs(2) ,rMInPlaneAbs(3) ,'Marker','o','MarkerFaceColor','g')
% scatter3(rTLInPlaneAbs(1),rTLInPlaneAbs(2),rTLInPlaneAbs(3),'Marker','o','MarkerFaceColor','g')
% scatter3(rTRInPlaneAbs(1),rTRInPlaneAbs(2),rTRInPlaneAbs(3),'Marker','o','MarkerFaceColor','g')
% scatter3(rBLInPlaneAbs(1),rBLInPlaneAbs(2),rBLInPlaneAbs(3),'Marker','o','MarkerFaceColor','g')
% scatter3(rBRInPlaneAbs(1),rBRInPlaneAbs(2),rBRInPlaneAbs(3),'Marker','o','MarkerFaceColor','g')
% 
% plot3(...
%     [rTLInPlaneAbs(1) rTRInPlaneAbs(1) rBRInPlaneAbs(1) rBLInPlaneAbs(1) rTLInPlaneAbs(1)],...
%     [rTLInPlaneAbs(2) rTRInPlaneAbs(2) rBRInPlaneAbs(2) rBLInPlaneAbs(2) rTLInPlaneAbs(2)],...
%     [rTLInPlaneAbs(3) rTRInPlaneAbs(3) rBRInPlaneAbs(3) rBLInPlaneAbs(3) rTLInPlaneAbs(3)],...
%     'Color','r')
% 
% view([71 37])
% 
% 
% 

end