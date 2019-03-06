function limit = findLimits(parameterName)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

varName = sprintf('params.(''%s'')', parameterName);
var = evalin('base',varName);
max = var.Max;
min = var.Min;

limit = [min max];

end

