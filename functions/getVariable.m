function [variable,entry] = getVariable(parameterName)

% This function returns variable name and entry in Data dictionary
% From input of parameter name in dictionary, function returns variable
% (Simulink parameter) and dictionary entry

% Open dictionary and migrate to section
dict = Simulink.data.dictionary.open('paramsDataDictionary.sldd');
sect = getSection(dict,'Design Data');

% Get entry of parameter in dictionary
entry = getEntry(sect,parameterName);

% Get variable of entry (Simulink parameter object) 
variable = getValue(entry);

end

