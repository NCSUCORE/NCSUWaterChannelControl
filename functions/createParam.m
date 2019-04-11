function createParam(name,value,min,max,description,units)

% pre-pend the units to the description
description = ['[' units '] ' description];

% if isscalar(value)
%     evalin('base',sprintf('params.%s = Simulink.Parameter(%s);',name,num2str(value)));
%     evalin('base',sprintf('params.%s.Max = %s;',name,num2str(max)));
%     evalin('base',sprintf('params.%s.Min = %s;',name,num2str(min)));
%     evalin('base',sprintf('params.%s.Dimensions = [1 1];',name));
%     evalin('base',sprintf('params.%s.Description = ''%s'';',name,description));
% elseif ischar(value)
%     str = strrep(value,'.',' ');
%     evalin('base',sprintf('params.%s = Simulink.Parameter([%s]);',name,str));
%     evalin('base',sprintf('params.%s.Max = %s;',name,num2str(max)));
%     evalin('base',sprintf('params.%s.Min = %s;',name,num2str(min)));
%     % Do not use str2double, does not work in this context.
%     evalin('base',sprintf('params.%s.Dimensions = [%s];',name,num2str(size(str2num(str)))));
%     evalin('base',sprintf('params.%s.Description = ''%s'';',name,description));
% else
%     evalin('base',sprintf('params.%s = Simulink.Parameter([%s]);',name,num2str(value)));
%     % For vector quantities, specify min/max values scalars, min and max
%     % are then applied element-wise.
%     evalin('base',sprintf('params.%s.Max = [%s];',name,num2str(max)));
%     evalin('base',sprintf('params.%s.Min = [%s];',name,num2str(min)));
%     evalin('base',sprintf('params.%s.Dimensions = [%s];',name,num2str(size(value))));
%     evalin('base',sprintf('params.%s.Description = ''%s'';',name,description));
% end

if isscalar(value)
    evalin('caller',sprintf('params.%s = Simulink.Parameter(%s);',name,num2str(value)));
    evalin('caller',sprintf('params.%s.Max = %s;',name,num2str(max)));
    evalin('caller',sprintf('params.%s.Min = %s;',name,num2str(min)));
    evalin('caller',sprintf('params.%s.Dimensions = [1 1];',name));
    evalin('caller',sprintf('params.%s.Description = ''%s'';',name,description));
elseif ischar(value)
    str = strrep(value,'.',' ');
    evalin('caller',sprintf('params.%s = Simulink.Parameter([%s]);',name,str));
    evalin('caller',sprintf('params.%s.Max = %s;',name,num2str(max)));
    evalin('caller',sprintf('params.%s.Min = %s;',name,num2str(min)));
    % Do not use str2double, does not work in this context
    evalin('caller',sprintf('params.%s.Dimensions = [%s];',name,num2str(size(str2num(str)))));
    evalin('caller',sprintf('params.%s.Description = ''%s'';',name,description));
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