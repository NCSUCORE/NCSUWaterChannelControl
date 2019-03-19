function [val,var] = getEntry(parameterName)
%GETENTRY Summary of this function goes here
%   Detailed explanation goes here

dict = Simulink.data.dictionary.open('paramsDataDictionary.sldd');
sect = getSection(dict,'Design Data');
var = getEntry(sect,parameterName);
val = getValue(var);

end

