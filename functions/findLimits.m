function limit = findLimits(parameterName)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

dict = Simulink.data.dictionary.open('paramsDataDictionary.sldd');
sect = getSection(dict,'Design Data');
val = getValue(getEntry(sect,parameterName));

% varName = sprintf('params.(''%s'')', parameterName);
% var = evalin('base',varName);

max = val.Max;
min = val.Min;

limit = [min max];

end

