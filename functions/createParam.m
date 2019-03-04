function createParam(name,value,min,max,description,units)

% pre-pend the units to the description
description = ['[' units '] ' description];

if (isscalar(value) || ischar(value))
    evalin('base',sprintf('params.%s = Simulink.Parameter(%s);',name,num2str(value)));
    evalin('base',sprintf('params.%s.Max = %s;',name,num2str(max)));
    evalin('base',sprintf('params.%s.Min = %s;',name,num2str(min)));
    evalin('base',sprintf('params.%s.Dimensions = [1 1];',name));
    evalin('base',sprintf('params.%s.Description = ''%s'';',name,description));
% elseif ischar(value)
%     evalin('base',sprintf('params.%s = Simulink.Parameter(%s);',name,value)));
%     evalin('base',sprintf('params.%s.Max = %s;',name,num2str(max)));
%     evalin('base',sprintf('params.%s.Min = %s;',name,num2str(min)));
%     evalin('base',sprintf('params.%s.Dimensions = [1 1];',name));
%     evalin('base',sprintf('params.%s.Description = ''%s'';',name,description));
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