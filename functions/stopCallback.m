function stopCallback()
% Function to run after every simulation, it should get all the logged
% signals and save them to output\data.  Function assumes that
% multidimensional signals are column vectors.  This has not been tested on
% matrix-valued signals.
fprintf('\nRunning %s.m\n',mfilename)

workDir = fullfile(fileparts(which('WaterChannelControl.prj')),'output');

fprintf('\nSetting working directory to\n%s\n',workDir);
cd(workDir);

fprintf('\nCompiling tsc\n')
% Note that sdi = "simulation data inspector"
runIds = Simulink.sdi.getAllRunIDs(); % Get all run IDs from SDI
run = Simulink.sdi.getRun(runIds(end));
for signalIndex=1:run.SignalCount
    % Read all signals into a structure
    signalID = run.getSignalIDByIndex(signalIndex);
    signalObjs(signalIndex) = Simulink.sdi.getSignal(signalID);
end
% Create boolean list to track which ones have been processed or not
toDoList = true(size(signalObjs));
for jj = 1:10000 % Use a for loop with break condition instead of while loop
    % get the first element of the to-do list that has not been done
    idx = find(toDoList,1);
    if signalObjs(idx).Dimensions == 1 % If it's a scalar
        name = matlab.lang.makeValidName(signalObjs(idx).Name);
        tsc.(name) = signalObjs(idx).Values;
        tsc.(name).UserData.BlockPath = signalObjs(idx).BlockPath;
        tsc.(name).UserData.PortIndex = signalObjs(idx).PortIndex;
        % Update the todo list
        toDoList(idx) = false;
    else
        % Search for the (number) at the end of the signal name string
        startIndex = regexp(signalObjs(idx).Name,'(\d*)');
        % Signal name is everything before that
        name = matlab.lang.makeValidName(signalObjs(idx).Name(1:startIndex-2));
        % Find all signals with names that match that
        matchMask = contains({signalObjs(:).Name},name);
        matches = signalObjs(matchMask);
        % Preallocate timeseries with correct dimensions
        tsc.(name) = matches(1).Values;
        % Overwrite data with column vectors of nans
        tsc.(name).Data = nan([matches(1).Dimensions 1 numel(tsc.(name).Time)]);
        for ii = 1:numel(matches) % For each data set with a matching name
            % Get the index associated with it
            index = regexp(matches(ii).Name,'(\d*)','match');
            index = str2double(index{1});
            % Take the data and stuff it into the appropriate plate in tsc
            tsc.(name).Data(index,:,:) = matches(ii).Values.Data;
        end
        % Update the todo list
        tsc.(name).UserData.BlockPath = signalObjs(idx).BlockPath;
        tsc.(name).UserData.PortIndex = signalObjs(idx).PortIndex;
        toDoList(matchMask) = false;
    end
    if all(toDoList==0)
        break
    end
end
% Build filename for data set
fileName = ['data_' strrep(datestr(now),' ','_') ];
fileName = matlab.lang.makeValidName(fileName);
fileName = [fileName '.mat'];
filePath = fullfile(fileparts(which('WaterChannelControl.prj')),'output','data');
% Get params structure from base workspace so we can save it too
params = evalin('base','params');
% Notify the user of what we're doing
fprintf('\nSaving tsc and params to\n%s\n',fullfile(filePath,fileName))
% Save the data to the output\data folder
save(fullfile(filePath,fileName),'tsc','params')
% Send tsc to the base workspace
assignin('base','tsc',tsc)
end