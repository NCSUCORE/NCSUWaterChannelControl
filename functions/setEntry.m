function val = setEntry(parameterName,value)
%SETENTRY Summary of this function goes here
%   Detailed explanation goes here

[val, var] = getEntry(parameterName);

val.Value = value;
setValue(var,val);

end

