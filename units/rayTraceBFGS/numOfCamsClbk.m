function numOfCamsClbk
maskObj = Simulink.Mask.get(gcb);
% get the desired number of cameras
numCamDes = round(eval(get_param(gcb,'numOfCams')));
% prevent it from being outside 1-5 range
numCamDes = max([numCamDes,1]);
numCamDes = min([numCamDes,5]);
set_param(gcb,'numOfCams',sprintf('%d',numCamDes));

% Make extra tabs invisible
for ii = numCamDes+1:5
    tabObj = maskObj.getDialogControl(sprintf('cam%dTab',ii));
    tabObj.Visible = 'off';
end

% Make neccessary tabs visible
for ii = 1:numCamDes
    tabName = sprintf('cam%dTab',ii);
    tabObj = maskObj.getDialogControl(tabName);
    tabObj.Visible = 'on';
end
end