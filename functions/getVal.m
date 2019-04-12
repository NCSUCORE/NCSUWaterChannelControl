function value = getVal(parameterName)

% This function returns variable value from Data Dictionary
% From input of parameter name in dictionary, this function returns the
% value of the parameter stored

% Open dictionary and migrate to section
dict = Simulink.data.dictionary.open('paramsDataDictionary.sldd');
sect = getSection(dict,'Design Data');

% Get entry of parameter in dictionary
entry = getEntry(sect,parameterName);

% Get variable of entry (Simulink parameter object) 
variable = getValue(entry);

% Set value as value of Simulink parameter object
value = variable.Value;

end

