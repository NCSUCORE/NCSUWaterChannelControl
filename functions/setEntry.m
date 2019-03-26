function variable = setEntry(parameterName,value,varargin)
%SETENTRY Summary of this function goes here
%   Detailed explanation goes here

[variable,entry] = getVariable(parameterName);

if (variable.Dimensions(2) > 1)
    variable.Value(varargin{1}) = value;
    
    if (length(varargin) > 2)
        if (variable.Dimensions(2) == 2)
            str = sprintf('[%d %d]',variable.Value);
        elseif (variable.Dimensions(2) == 3)
            str = sprintf('[%d %d %d]',variable.Value);
        end   
        set_param(varargin{2},varargin{3},str);
    end
else
    variable.Value = value;
    
    if (length(varargin) == 2)
        str = sprintf('%d',variable.Value);
        set_param(varargin{1},varargin{2},str);
    end
end

setValue(entry,variable);

% if (length(varargin) > 1)
%     if (strcmp(varargin{1},'model2_cm') || strcmp(varargin{2},'model2_cm'))
%         set_param('model2_cm','SimulationCommand','Update');
%     end
%     if (length(varargin) > 2)
%         if (variable.Dimensions(2) == 1)
%             str = sprintf('%d',variable.Value);
%         elseif (variable.Dimensions(2) == 2)
%             str = sprintf('[%d %d]',variable.Value);
%         else
%             str = sprintf('[%d %d %d]',variable.Value);
%         end   
%         set_param(varargin{2},varargin{3},str);
%     end
% end

end

