%% Script to initialize Dot Finder block

% Calculate the ROI half width and half height
ROIHalfDimVec_px = [floor(ROIDimVec_px(1)/2)...
    floor(ROIDimVec_px(2)/2)];

% Set ROIHalfDimVec_px parameter in DotFinder block mask as determined by 
% above equation
set_param(gcb,'ROIHalfDimVec_px',[ '[' num2str(ROIHalfDimVec_px(1)) ' ' num2str(ROIHalfDimVec_px(2)) ']' ])


%% Obsolete Section 

% % Set up the matrix that determines how to split the ROI
% % before we calculate the dot centroid
% 
% % Matrix has form
% % [startPoint, widthORHeight]
% if strcmpi(get_param(gcb,'DotOrientation'),'Horizontal')
%     
%     % If the ROI is horizontal, then split down the middle
%     % Set the limits on the rows
%     ROISplitDims_px(1,:) = [1 ROIDimVec_px(1)];
%     ROISplitDims_px(3,:) = [1 ROIDimVec_px(1)];
%     
%     % Set the limits on the columns
%     ROISplitDims_px(2,:) = [1 ROIHalfDimVec_px(2)];
%     ROISplitDims_px(4,:) = [ROIHalfDimVec_px(2)+1 ROIHalfDimVec_px(2)-1];
% else
%     
%     % If the ROI is vertical, then split across the middle
%     % Set the limits on the rows
%     ROISplitDims_px(1,:) = [1 ROIHalfDimVec_px(1)];
%     ROISplitDims_px(3,:) = [ROIHalfDimVec_px(1)+1 ROIHalfDimVec_px(1)-1];
%     
%     % Set the limits on the columns
%     ROISplitDims_px(2,:) = [1 ROIDimVec_px(2)];
%     ROISplitDims_px(4,:) = [1 ROIDimVec_px(2)];
% end
% 
% % Set ROISplitDims_px parameter in DotFinder block mask as determined by
% % dot orientation
% set_param(gcb,'ROISplitDims_px',[ '['...
%     num2str(ROISplitDims_px(1,1)) ' ' num2str(ROISplitDims_px(1,2)) ' ; '...
%     num2str(ROISplitDims_px(2,1)) ' ' num2str(ROISplitDims_px(2,2)) ' ; '...
%     num2str(ROISplitDims_px(3,1)) ' ' num2str(ROISplitDims_px(3,2)) ' ; '...
%     num2str(ROISplitDims_px(4,1)) ' ' num2str(ROISplitDims_px(4,2)) ']' ]);
