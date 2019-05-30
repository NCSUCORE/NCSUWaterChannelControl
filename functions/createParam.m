function createParam(name,value,min,max,description,units)

% This function creates Simulink parameter object given input
% specifications to function

% INPUTS:
% name - name of parameter
% value - value of object
% min - minimum value of object
% max - maximum value of object
% description - description of parameter
% units - units of object

% Pre-pend the units to the description
description = ['[' units '] ' description];

% If value is a scalar, set parameter values accordingly
if isscalar(value)
    evalin('base',sprintf('params.%s = Simulink.Parameter(%s);',name,num2str(value)));
    evalin('base',sprintf('params.%s.Max = %s;',name,num2str(max)));
    evalin('base',sprintf('params.%s.Min = %s;',name,num2str(min)));
    evalin('base',sprintf('params.%s.Dimensions = [1 1];',name));
    evalin('base',sprintf('params.%s.Description = ''%s'';',name,description));

% If value is a character (IP Address), set parameter values accordingly
elseif ischar(value)
    str = strrep(value,'.',' ');
    evalin('base',sprintf('params.%s = Simulink.Parameter([%s]);',name,str));
    evalin('base',sprintf('params.%s.Max = %s;',name,num2str(max)));
    evalin('base',sprintf('params.%s.Min = %s;',name,num2str(min)));
    % Do not use str2double, does not work in this context
    evalin('base',sprintf('params.%s.Dimensions = [%s];',name,num2str(size(str2num(str)))));
    evalin('base',sprintf('params.%s.Description = ''%s'';',name,description));
    
% Else value is vector, set parameter values accordingly
else
    evalin('base',sprintf('params.%s = Simulink.Parameter([%s]);',name,num2str(value)));
    % For vector quantities, specify min/max values scalars, min and max
    % are then applied element-wise.
    evalin('base',sprintf('params.%s.Max = [%s];',name,num2str(max)));
    evalin('base',sprintf('params.%s.Min = [%s];',name,num2str(min)));
    evalin('base',sprintf('params.%s.Dimensions = [%s];',name,num2str(size(value))));
    evalin('base',sprintf('params.%s.Description = ''%s'';',name,description));
end

end