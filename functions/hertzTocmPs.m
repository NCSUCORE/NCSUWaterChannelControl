function [speed] = hertzTocmPs(hertz)

% Function returns motor speed in hertz to flow speed in cm/s
%   Inputs: hertz - motor rate in hertz
%   Outputs: speed - flow speed in cm/s

speed = (0.0159*hertz) - 0.0027;
speed = speed*100;

end

