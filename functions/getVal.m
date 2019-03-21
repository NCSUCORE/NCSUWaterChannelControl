function value = getVal(parameterName)
%GETVAL Summary of this function goes here
%   Detailed explanation goes here

dict = Simulink.data.dictionary.open('paramsDataDictionary.sldd');
sect = getSection(dict,'Design Data');
entry = getEntry(sect,parameterName);
variable = getValue(entry);
value = variable.Value;

end

