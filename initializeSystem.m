%% Script to initialize the NCSU water channel control system
% Please do not move this file

% Set working directory to output
fprintf('\nSetting working directory to output\n')
baseDir = fileparts(which(mfilename)); % Get the path to the highest level of the project
cd(fullfile(baseDir,'output')) % Set the working directory

% Open the simulink project file
fprintf('\nOpening simulink project WaterChannelControl.prj\n\n')
simulinkproject(fullfile(baseDir,'WaterChannelControl.prj'))

t = timer('ExecutionMode', 'singleShot', 'StartDelay', 10, 'TimerFcn', @pressEnter);
start(t);
fprintf('\n*******************************')
answer = input([...
    '\nWould you like to open models,',...
    '\nbuild models, and connect to target?'...
    '\nIf yes, make sure targets are on first.\n',...
    '\nPrompt will time out after 10s',...
    '\nand do nothing.\n',...
    '[y/n]:'],'s');
stop(t);
delete(t);

if strcmpi(answer,'y')
    fprintf('\nOpening all models\n')
    % Open all the individual models
    for ii = 2:5
        open_system(fullfile(baseDir,'models',sprintf('model%d',ii),sprintf('model%d_cm.slx',ii)))
        % Add code here to reposition/resize windows to tile them
    end
    
    % Build and connect
    fprintf('\nBuilding all models\n')
    % Put code to build models and connect here.
    fprintf('\nConnecting to targets\n')
    % Check for target first probably ought to use some kind of try/catch
    % Add code to open GUI once we build it.
end

fprintf('\nDone\n')

clearvars t ii baseDir answer ans

function pressEnter(HObj, event)
% Code copied from: https://www.mathworks.com/matlabcentral/answers/119067-how-can-i-set-a-time-for-input-waiting
    commandwindow % move the cursor to the command window
    import java.awt.*;
    import java.awt.event.*;
    rob = Robot;
    rob.keyPress(KeyEvent.VK_ENTER)
    rob.keyRelease(KeyEvent.VK_ENTER)
end