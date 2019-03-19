function variable = setEntry(parameterName,value,varargin)
%SETENTRY Summary of this function goes here
%   Detailed explanation goes here

[variable,entry] = getEntry(parameterName);

if (variable.Dimensions(1) > 1 || variable.Dimensions(2) > 1)
    variable.Value(varargin{1}) = value;
else
    variable.Value = value;
end

setValue(entry,variable);

end

