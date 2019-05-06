function [limit] = findLimits(parameterName)

% This function returns the limits of the parameter defined in dictionary
% Input of paraeterName used to navigate to location in data dictionary

% Call getVariable function to Simulink parameter in dictionary
variable = getVariable(parameterName);

% Set min and max based on variable min and max values
min = variable.Min;
max = variable.Max;

% Store min and max values as limit vector
limit = [min max];

end

