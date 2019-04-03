
cd('output/data');
load('data_02_Apr_2019_19_19_35.mat');
cd('../..');

roll_rad = tsc.roll_rad.Data;
pitch_rad = tsc.pitch_rad.Data;
yaw_rad = tsc.yaw_rad.Data;
sideDot = tsc.sideDotCoords.Data;
botDot = tsc.botDotCoords.Data;
slntDot = tsc.slantDotCoords.Data;

sampleSize = length(roll_rad)/2;
rollDegMean = (180/pi)*mean(roll_rad(sampleSize:end));
pitchDegMean = (180/pi)*mean(pitch_rad(sampleSize:end));
yawDegMean = (180/pi)*mean(yaw_rad(sampleSize:end));
sideDotMean = mean(sideDot(:,:,sampleSize:end),3);
botDotMean = mean(botDot(:,:,sampleSize:end),3);
slntDotMean = mean(slntDot(:,:,sampleSize:end),3);

% botBMean = botDotMean(1:4);
% botAMean = botDotMean(5:8);

end_time = 10;
pert = zeros(16,1,end_time+1);
range = linspace(-5,5,end_time+1);
resp = zeros(1,end_time+1);
response = timeseries(resp);
total = cell(16,3);

for i = 1:16
    pert(i,:,:) = range;
    pertubation = timeseries(pert);
    sim('sensitivity_th');
    pert(i,:,:) = zeros(1,length(range));
    response = roll_deg;
    total{i,1} = response;
    response = pitch_deg;
    total{i,2} = response;
    response = yaw_deg;
    total{i,3} = response;
end
