%% Script to initialize the NCSU water channel control system
% Please do not move this file

% Set working directory to output
fprintf('\nSetting working directory to output\n')
baseDir = fileparts(which(mfilename)); % Get the path to the highest level of the project
% cd(fullfile(baseDir,'output')) % Set the working directory

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
    
    % Load parameters structure into base workspace
    fprintf('\nLoading params struct\n')
%     loadParams
    
    fprintf('\nOpening all models\n')
    % Window positions determined from using get_param(gcs,'location')
    windowPositions = [ -6     0   775   418;...
        762           0        1543         418;...
        -6   412   775   830;...
        762         412        1543         830];
    % Open all the individual models
    for ii = 2:5
        open_system(fullfile(baseDir,'models',sprintf('model%d',ii),sprintf('model%d_cm.slx',ii)))
        % Add code here to reposition/resize windows to tile them
        set_param(gcs,'location',windowPositions(ii-1,:));
        % Zoom to fit
        set_param(gcs, 'ZoomFactor','FitSystem')
        
    end
    % If this is the host laptop and we're logged in as the generic user
    if strcmpi(getenv('computername'),'vermillionlab4') && strcmpi(getenv('username'),'MAE-NCSUCORE')
        % Build and connect
        fprintf('\nBuilding all models\n')
        for ii = 2:5
            % Build models:
            try
                fprintf('\nBuilding model%d_cm.slx\n',ii)
%                 eval(sprintf('model%d_cm([], [], [], ''compile'')',ii));
                % Sometimes the above line results in a bug that locks the
                % models from editing etc.  To break out of this use: model2_cm([], [], [], 'term')
                % You may need to run that multiple times to get it to work.
            catch errMsg
                rethrow(errMsg)
            end
            % Connect to targets:
            try
                fprintf('\nConnecting to target machine %d\n',ii)
%                 set_param(sprintf('model%d_cm',ii),'SimulationCommand','connect');
            catch errMsg
                rethrow(errMsg)
            end
        end
    end
    % Check for appropriate target
    
    % Build and connect
    fprintf('\nBuilding all models\n')
    % Put code to build models and connect here.
    fprintf('\nConnecting to targets\n')
    % Check for target first probably ought to use some kind of try/catch
    % Add code to open GUI once we build it.
end

% Initialize controllers
controllers_init

fprintf('\nDone\n')

clearvars t ii baseDir answer ans windowPositions_px errMsg

function pressEnter(HObj, event)
% Code copied from: https://www.mathworks.com/matlabcentral/answers/119067-how-can-i-set-a-time-for-input-waiting
    commandwindow % move the cursor to the command window
    import java.awt.*;
    import java.awt.event.*;
    rob = Robot;
    rob.keyPress(KeyEvent.VK_ENTER)
    rob.keyRelease(KeyEvent.VK_ENTER)
end