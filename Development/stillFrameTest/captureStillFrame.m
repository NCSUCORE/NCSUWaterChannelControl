%% Script to capture Still Frame images from target computers

% Get and save Machine 2 screenshot
screen = viewTargetScreen(tg2);
fileName = ['Machine2Screen_' strrep(datestr(now),' ','_') ];
fileName = matlab.lang.makeValidName(fileName);
fileName = [fileName '.png'];
path = fullfile(fileparts(which(mfilename)),fileName);
saveas(screen,path);

% Get and save Machine 3 screenshot
screen = viewTargetScreen(tg3);
fileName = ['Machine3Screen_' strrep(datestr(now),' ','_') ];
fileName = matlab.lang.makeValidName(fileName);
fileName = [fileName '.png'];
path = fullfile(fileparts(which(mfilename)),fileName);
saveas(screen,path);

% Get and save Machine 4 screenshot
screen = viewTargetScreen(tg4);
fileName = ['Machine4Screen_' strrep(datestr(now),' ','_') ];
fileName = matlab.lang.makeValidName(fileName);
fileName = [fileName '.png'];
path = fullfile(fileparts(which(mfilename)),fileName);
saveas(screen,path);

% Get and save Machine 5 screenshot
screen = viewTargetScreen(tg5);
fileName = ['Machine5Screen_' strrep(datestr(now),' ','_') ];
fileName = matlab.lang.makeValidName(fileName);
fileName = [fileName '.png'];
path = fullfile(fileparts(which(mfilename)),fileName);
saveas(screen,path);
