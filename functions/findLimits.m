function [limit] = findLimits(parameterName)

% This function returns the limits of the parameter defined in dictionary

% INPUTS:
% parameterName - name of parameter to get limits of

% OUTPUTS:
% limit - row vector containing min and max values of parameter

% Call getVariable function to Simulink parameter in dictionary
variable = getVariable(parameterName);

% Set min and max based on variable min and max values
min = variable.Min;
max = variable.Max;

% Store min and max values as limit vector
limit = [min max];

end

