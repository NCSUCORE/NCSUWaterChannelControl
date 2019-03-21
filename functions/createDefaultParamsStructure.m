function createDefaultParamsStructure()
% This function creates the params structure in the base workspace and then
% saves it to paramsData/params.mat

% Syntax is createParam(name,value,min,max,description,units)

% Note that the params structure doesn't contain anything that maps to a
% check box on mask parameters because I don't know how to do that
% Create global variable in base workspace

% evalin('base','global params')

%% MODEL 2 PARAMETERS
% CONTROLLER PARAMETERS
% Roll controller
createParam('rollCtrlkp_Prad',1,0,100,...
    'Roll controller proportional gain.','PerRad')
createParam('rollCtrlkd_sPrad',0,0,100,...
    'Roll controller derivative gain.','secPerRad')
createParam('rollCtrltau_s',0.1,0.025,10,...
    'Roll controller time constant.','sec')
% Pitch controller
createParam('pitchCtrlkp_Prad',1,0,100,...
    'Pitch controller proportional gain.','PerRad')
createParam('pitchCtrlkd_sPrad',0,0,100,...
    'Pitch controller derivative gain.','secPerRad')
createParam('pitchCtrltau_s',0.1,0.025,10,...
    'Pitch controller time constant.','sec')
% Altitude controller
createParam('altCtrlkp_Prad',1,0,100,...
    'Altitude controller proportional gain.','PerRad')
createParam('altCtrlkd_sPrad',0,0,100,...
    'Altitude controller derivative gain.','secPerRad')
createParam('altCtrltau_s',0.1,0.025,10,...
    'Altitude controller time constant.','sec')

% MANUAL MOTOR SPEED OVERRIDE PARAMETERS
createParam('mtr1ManulaSpdCmd_na',0,-1,1,...
    'Manual motor 1 speed setting','na')
createParam('mtr2ManulaSpdCmd_na',0,-1,1,...
    'Manual motor 2 speed setting','na')
createParam('mtr3ManulaSpdCmd_na',0,-1,1,...
    'Manual motor 3 speed setting','na')
createParam('manualMotorSpeed_na',0.25,0,1,...
    'Manual motor speed command, only used in GUI','na')

% ANALOG OUTPUT PARAMETERS
createParam('maxOutVltg_vlt',3.3,0,5,...
    'Maximum analog output voltage.','V')

% 6DOF RESOLUTION PARAMETERS
createParam('initCoMPosVec_cm',[-28 0 35.6],-100,100,...
    'Initial center of mass position vector.','cm')

% CAMERA PROPERTIES
createParam('cameraFOV_deg',[30 30],0,60,...
    'Camera field of view angles from centerline [horiz vert]','deg')
% Side camera 6DOF
createParam('sideCamPosVec_cm',2.54 * [-11 -8 15],-100,100,...
    'Side camera position vector.','cm')
createParam('sideCamEulAng_deg',[0 90 -90],-360,360,...
    'Side camera Euler angles, [Roll Pitch Yaw], rotation order is Z, Y, X.','deg')
% Bottom camera 6DOF
createParam('botCamPosVec_cm',2.54 * [-11 2 3],-100,100,...
    'Bottom camera position vector.','cm')
createParam('botCamEulAng_deg',[0 180 180],-360,360,...
    'Bottom camera Euler angles, [Roll Pitch Yaw], rotation order is Z, Y, X.','deg')
% Slant camera 6DOF
createParam('slntCamPosVec_cm',2.54 * [-21 2 3],-100,100,...
    'Slant camera position vector.','cm')
createParam('slntCamEulAng_deg',[0 135 180],-360,360,...
    'Slant camera Euler angles, [Roll Pitch Yaw], rotation order is Z, Y, X.','deg')

% DOT PROPERTIES
% Side Dots
createParam('sideDotSepDist_cm',2.54,0,10,...
    'Side dots separation distance.','cm')
createParam('sideDotPosVec_cm',[0.091 -4.54 0.878],-20,20,...
    'Position of side dots centroid in body fixed coordinates','cm')
% Bottom A Dots
createParam('botADotSepDist_cm',2.54,0,10,...
    'Bottom A dots separation distance.','cm')
createParam('botADotPosVec_cm',[2.48 0 -4.53],-20,20,...
    'Bottom A dots centroid in body fixed coordinates','cm')
% Bottom B Dots
createParam('botBDotSepDist_cm',3.18,0,10,...
    'Bottom B dots separation distance.','cm')
createParam('botBDotPosVec_cm',[9.10 0 -4.64],-20,20,...
    'Bottom B dots centroid in body fixed coordinates','cm')

% ERROR DETECTION PARAMETERS
createParam('imagProcErrThrsh_na',0.5,0,10,...
    'Image processing error threshold.','NA')
createParam('imagProcErrDbncTm_s',0.1,0,10,...
    'Image processing error debounce time.','s')

% COMMUNICATION PARAMETERS
createParam('announceInterval_s',1,0,5,...
    'Announce interval for machine 2','s')

%% MODEL 3 PARAMETERS
% CAMERA PARAMETERS
createParam('roiSideHldPos_px',[730 1050],0,2048,...
    'Default image [row col] coordinates of ROI for side camera.','px')
createParam('roiSideSize_px',3*[30 90],0,500,...
    'Default ROI size [row col] for side camera.','px')
createParam('sideImageSize_px',[1088 2048],0,2048,...
    'Size of image from side camera [rows cols].','px')
createParam('sideCrsHrWdth_px',1,0,50,...
    'Width of crosshair overlay i   n side image.','px')
createParam('sideVidStrmDec_na',5,0,50,...
    'Side camera video stream frame decimation (display every N frames).','NA')
createParam('sideVidStrmImgWdth_px',1200,0,5000,...
    'Side video stream image width','px')

% COMMUNICATION PARAMETERS
createParam('syncInterval_s',0.2,0.08,1,...
    'Sync interval for all machines','s')
createParam('offsetThreshold_s',250e-6,1e-8,1e-2,...
    'Offset threshold for all machines','s')
createParam('sideIPAddress_na','30.30.30.1',0,255,...
    'Side local IP Address','NA')
createParam('sideToPort_na',8001,8000,9000,...
    'Side to port address on machine 2','NA');
createParam('sideMinDelay_s',2,0,5,...
    'Side minimum delay between request intervals','s');

%% MODEL 4 PARAMETERS
createParam('roiBotAHldPos_px',[615 1150],0,2048,...
    'Default image [row col] coordinates of ROI for bottom A camera.','px')
createParam('roiBotBHldPos_px',[465 1150],0,2048,...
    'Default image [row col] coordinates of ROI for bottom B camera.','px')
createParam('roiBotASize_px',2*[90 30],0,500,...
    'Default ROI size [row col] for bottom A camera.','px')
createParam('roiBotBSize_px',1.8*[30 90],0,500,...
    'Default ROI size [row col] for bottom B camera.','px')
createParam('botImageSize_px',[1088 2048],0,2048,...
    'Size of image from bottom [rows cols].','px')
createParam('botACrsHrWdth_px',1,0,50,...
    'Width of crosshair overlay in bottom A image.','px')
createParam('botBCrsHrWdth_px',1,0,50,...
    'Width of crosshair overlay in bottom A image.','px')
createParam('botVidStrmDec_na',5,0,50,...
    'Bottom camera video stream frame decimation (display every N frames).','NA')
createParam('botVidStrmImgWdth_px',1200,0,5000,...
    'Bottom video stream image width.','px')
createParam('botVidStrmsrcSwtch_na',1,1,2,...
    'Bottom video stream source switch.','NA')

% COMMUNICATION PARAMETERS
createParam('bottomIPAddress_na','30.30.30.2',0,1000,...
    'Bottom local IP Address','NA')
createParam('bottomToPort_na',8002,8000,9000,...
    'Bottom to port address on machine 2','NA');
createParam('bottomMinDelay_s',2.5,0,5,...
    'Bottom minimum delay between request intervals','s');

%% MODEL 5 PARAMETERS
createParam('roiSlntHldPos_px',[460 1170],0,2048,...
    'Default image [row col] coordinates of ROI for slant camera.','px')
createParam('roiSlntSize_px',2*[30 90],0,500,...
    'Default ROI size [row col] for slant camera.','px')
createParam('slntImageSize_px',[1088 2048],0,2048,...
    'Size of image from slnt camera [rows cols].','px')
createParam('slntCrsHrWdth_px',1,0,50,...
    'Width of crosshair overlay in slant image.','px')
createParam('slntVidStrmDec_na',5,0,50,...
    'Slant camera video stream frame decimation (display every N frames).','NA')
createParam('slntVidStrmImgWdth_px',1200,0,5000,...
    'Slant video stream image width.','px')

% COMMUNICATION PARAMETERS
createParam('slantIPAddress_na','30.30.30.3',0,1000,...
    'Slant local IP Address','NA')
createParam('slantToPort_na',8003,8000,9000,...
    'Slant to port address on machine 2','NA');
createParam('slantMinDelay_s',2.25,0,5,...
    'Slant minimum delay between request intervals','s');

%% SAVE TO BASE WORKSPACE
% Get the full path to the directory
paramsDir = what('paramsData');

% Save params to params.mat file
% evalin('base',['save(''' paramsDir.path filesep 'params.mat'',''params'');'])
save([ paramsDir.path filesep 'params.mat'],'-struct','params');

myDictionaryObj = Simulink.data.dictionary.open('paramsDataDictionary.sldd');
dDataSectObj = getSection(myDictionaryObj,'Design Data');
importFromFile(dDataSectObj,'params.mat','existingVarsAction','overwrite');

end