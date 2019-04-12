function createParam(name,value,min,max,description,units)

% This function creates Simulink parameter object given inputs to function
% Inputs of parameter name, value, min, max, description, and units used
% to fully define Simulink parameter

% Pre-pend the units to the description
description = ['[' units '] ' description];

% If value is a scalar, set parameter values accordingly
if isscalar(value)
    evalin('caller',sprintf('params.%s = Simulink.Parameter(%s);',name,num2str(value)));
    evalin('caller',sprintf('params.%s.Max = %s;',name,num2str(max)));
    evalin('caller',sprintf('params.%s.Min = %s;',name,num2str(min)));
    evalin('caller',sprintf('params.%s.Dimensions = [1 1];',name));
    evalin('caller',sprintf('params.%s.Description = ''%s'';',name,description));

% If value is a character (IP Address), set parameter values accordingly
elseif ischar(value)
    str = strrep(value,'.',' ');
    evalin('caller',sprintf('params.%s = Simulink.Parameter([%s]);',name,str));
    evalin('caller',sprintf('params.%s.Max = %s;',name,num2str(max)));
    evalin('caller',sprintf('params.%s.Min = %s;',name,num2str(min)));
    % Do not use str2double, does not work in this context
    evalin('caller',sprintf('params.%s.Dimensions = [%s];',name,num2str(size(str2num(str)))));
    evalin('caller',sprintf('params.%s.Description = ''%s'';',name,description));
    
% Else value is vector, set parameter values accordingly
else
    evalin('caller',sprintf('params.%s = Simulink.Parameter([%s]);',name,num2str(value)));
    % For vector quantities, specify min/max values scalars, min and max
    % are then applied element-wise.
    evalin('caller',sprintf('params.%s.Max = [%s];',name,num2str(max)));
    evalin('caller',sprintf('params.%s.Min = [%s];',name,num2str(min)));
    evalin('caller',sprintf('params.%s.Dimensions = [%s];',name,num2str(size(value))));
    evalin('caller',sprintf('params.%s.Description = ''%s'';',name,description));
end

end