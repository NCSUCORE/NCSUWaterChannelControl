function createDefaultParamsStructure()

% This function creates the params structure in the base workspace and then
% saves it to paramsData/params.mat

% Syntax is createParam(name,value,min,max,description,units)

% Note that the params structure doesn't contain anything that maps to a
% check box on mask parameters because I don't know how to do that

% Create global variable in base workspace
evalin('base','global params')

%% MODEL 2 PARAMETERS
% CONTROLLER PARAMETERS
% Roll controller
createParam('rollCtrlkp_Prad',1,0,100,...
    'Roll controller proportional gain.','PerRad')
createParam('rollCtrlkd_sPrad',0,0,100,...
    'Roll controller derivative gain.','secPerRad')
createParam('rollCtrltau_s',0.5,0.025,10,...
    'Roll controller time constant.','sec')
% Pitch controller
createParam('pitchCtrlkp_Prad',1,0,100,...
    'Pitch controller proportional gain.','PerRad')
createParam('pitchCtrlkd_sPrad',0,0,100,...
    'Pitch controller derivative gain.','secPerRad')
createParam('pitchCtrltau_s',0.3,0.025,10,...
    'Pitch controller time constant.','sec')
% Altitude controller
createParam('altCtrlkp_Prad',1,0,100,...
    'Altitude controller proportional gain.','PerRad')
createParam('altCtrlkd_sPrad',0,0,100,...
    'Altitude controller derivative gain.','secPerRad')
createParam('altCtrltau_s',2,0.025,10,...
    'Altitude controller time constant.','sec')

% MANUAL MOTOR SPEED OVERRIDE PARAMETERS
createParam('mtr1ManulaSpdCmd_na',0,-1,1,...
    'Manual motor 1 speed setting.','na')
createParam('mtr2ManulaSpdCmd_na',0,-1,1,...
    'Manual motor 2 speed setting.','na')
createParam('mtr3ManulaSpdCmd_na',0,-1,1,...
    'Manual motor 3 speed setting.','na')
createParam('manualMotorSpeed_na',0.25,0,1,...
    'Manual motor speed command, only used in GUI.','na')
createParam('operationMode_na',1,0,1,...
    'Control mode: 0 for manual, 1 for automatic.','bool')

% ANALOG OUTPUT PARAMETERS
createParam('maxOutVltg_vlt',3.3,0,5,...
    'Maximum analog output voltage.','V')

% 6DOF RESOLUTION PARAMETERS
createParam('initCoMPosVec_cm',[10 0 40],-100,100,...
    'Initial center of mass position vector.','cm')
createParam('initEulerAng_deg',[0 0 0],-180,180,...
    'Initial Euler angles.','deg')

% CAMERA PROPERTIES
createParam('cameraFOV_deg',[42 26],0,60,...
    'Camera fielOFd of view angles from centerline [horiz vert]','deg')
% Side camera 6DOF
% Dummy (Bot Cam Origin) - [2 31 21]
% Water Channel - [-7.5 44.7 47.1]
createParam('sideCamPosVec_cm',[1 44.5 41],-100,100,...
    'Side camera position vector.','cm')
% Dummy - [0 89.2 89.5]
createParam('sideCamEulAng_deg',[0 90 90],-360,360,...   
    'Side camera Euler angles, [Roll Pitch Yaw], rotation order is Z, Y, X.','deg')
% Bottom camera 6DOF
% Dummy (Bot Cam Origin) - [0 5 7]
% Water Channel - [22 -6 -8]
createParam('botCamPosVec_cm',[0 0 0],-100,100,...
    'Bottom camera position vector.','cm')
% Dummy - [0.2 179 180]
createParam('botCamEulAng_deg',[0 180 180],-360,360,...
    'Bottom camera Euler angles, [Roll Pitch Yaw], rotation order is Z, Y, X.','deg')
% Slant camera 6DOF
% Dummy (Bot Cam Origin)- [-44 0 25.5]
% Water Channel - [-13.5 -6 -7.6]
createParam('slntCamPosVec_cm',[40 2 39],-100,100,...
    'Slant camera position vector.','cm')
% Dummy - [0 133.9 180.6]
createParam('slntCamEulAng_deg',[0 90 0],-360,360,...
    'Slant camera Euler angles, [Roll Pitch Yaw], rotation order is Z, Y, X.','deg')
% Periscope (Back) camera 6DOF
% Dummy (Back)(Bot Cam Origin)- [27 4.5 21]
% Dummy (Periscope)(Bot Cam Origin)- [44 4 20]
createParam('prscpeCamPosVec_cm',[40 2 39],-100,100,...
    'Periscope camera position vector.','cm')
createParam('prscpeCamEulAng_deg',[0 90 0],-360,360,...
    'Periscope camera Euler angles, [Roll Pitch Yaw], rotation order is Z, Y, X.','deg')

% DOT PROPERTIES
% Side Dots
% Dummy - 2.036
% Water Channel - 1.649
% Kite (boom) 2.036
createParam('sideDotSepDist_cm',2.12,0,10,...
    'Side dots separation distance.','cm')
% Old - [0.091 4.54 0.878]
% Dummy [-0.337 4.54 0.857]
% Kite (boom) [-3.9 0 0]
createParam('sideDotPosVec_cm',[2.84 0 0],-20,20,...
    'Position of side dots centroid in body fixed coordinates','cm')
% Bottom A Dots
% Dummy - 1.88
% Water Channel - 2.008
createParam('botADotSepDist_cm',1.7,0,10,...
    'Bottom A dots separation distance.','cm')
% Old - [2.48 0 -4.53]
%dummy = [2.049 0 -4.546]
% Kite1 (boom)[2.7 0 0.2]
createParam('botADotPosVec_cm',[-4.5 0 -0.2],-20,20,...
    'Bottom A dots centroid in body fixed coordinates','cm')
% Bottom B Dots
% Dummy - 2.206
% Water Channel - 2.194
createParam('botBDotSepDist_cm',2.4,0,10,...
    'Bottom B dots separation distance.','cm')
% Old - [-1 0 -4.64]
%dummy [-1.152 0 -4.751]
createParam('botBDotPosVec_cm',[0 0 0],-20,20,...
    'Bottom B dots centroid in body fixed coordinates','cm')
% Top/Back Dots
% top - 2.034
createParam('topDotSepDist_cm',3,0,10,...
    'Top dots separation distance.','cm')
% BAT = 1.865
% Kite_2 = 3.6  
% top_old - [2.818 0 3.802]
% Kite (boom) [6.7 0 0]
createParam('topDotPosVec_cm',[6.17 0 0.91],-20,20,...
    'Top dots centroid in body fixed coordinates','cm')
% BAT - [24.314 0 3.343]
% Kite_bad_1 [7.2 0 0]
% Kite_1 [6.7 0 0]
% ERROR DETECTION PARAMETERS
createParam('imagProcErrThrsh_na',0.25,0,10,...
    'Image processing error threshold.','NA')
createParam('imagProcErrDbncTm_s',0.1,0,10,...
    'Image processing error debounce time.','s')

% COMMUNICATION PARAMETERS
createParam('announceInterval_s',1,0,5,...
    'Announce interval for machine 2','s')

% GLASS PARAMETERS
createParam('glassThickness_cm',1.9,0,5,...
    'Thickness of glass','cm')
createParam('sideDistancetoGlass_cm',2,0,50,...
    'Side camera distance to glass','cm')
createParam('botDistancetoGlass_cm',2,0,50,...
    'Bottom camera distance to glass','cm')
createParam('slntDistancetoGlass_cm',0.5,0,50,...
    'Slant camera distance to glass','cm')
createParam('prscpeDistancetoGlass_cm',0.5,0,50,...
    'Periscope camera distance to glass','cm')

createParam('indexOfRefractionAGW',[1 1.52 1.33],0,3,...
    'Indices of refraction for air glass water','NA')
createParam('indexOfRefractionA',[1 1 1],0,1,...
    'Indices of refraction for air','NA')
createParam('indexOfRefractionAGA',[1 1.52 1],0,1,...
    'Indices of refraction for air glass air','NA')

% Extra  
createParam('Periscope',[0 1],0,1,...
    'Indicates whether or not the periscope setup is in use','NA')
%% MODEL 3 PARAMETERS
% CAMERA PARAMETERS
createParam('roiSideHldPos_px',[450 960],0,2048,...
    'Default image [row col] coordinates of ROI for side camera.','px')
createParam('roiSideSize_px',[60 160],0,500,...
    'Default ROI size [row col] for side camera.','px')
% old [60 150]
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
% CAMERA PARAMETERS
createParam('roiBotAHldPos_px',[580 1060],0,2048,...
    'Default image [row col] coordinates of ROI for bottom A camera.','px')
createParam('roiBotBHldPos_px',[450 1050],0,2048,...
    'Default image [row col] coordinates of ROI for bottom B camera.','px')
createParam('roiBotASize_px',[300 120],0,500,...
    'Default ROI size [row col] for bottom A camera.','px')
createParam('roiBotBSize_px',[120 400],0,500,...
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
% CAMERA PARAMETERS
createParam('roiSlntHldPos_px',[560 1050],0,2048,...
    'Default image [row col] coordinates of ROI for slant camera.','px')
createParam('roiSlntSize_px',[80 300],0,500,...
    'Default ROI size [row col] for slant camera.','px')
% old [60 120]
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
evalin('base',['save(''' paramsDir.path filesep 'params.mat'',''params'');'])

% % Open dictionary and migrate to section
% myDictionaryObj = Simulink.data.dictionary.open('paramsDataDictionary.sldd');
% dDataSectObj = getSection(myDictionaryObj,'Design Data');
% 
% % Overwrite current data dictionary values given params mat file
% importFromFile(dDataSectObj,'params.mat','existingVarsAction','overwrite');

end