function variable = setEntry(parameterName,value,varargin)

% This function sets value of specified parameter name to specific value
% Inputs of parameter name, value used to specify name to be modified and
% value to set

% Variable argument used to specify dimension (if needed) as well as path
% to mask argument in models and mask variable name for set_param use

% Get variable and dictionary entry from getVariable function
[variable,entry] = getVariable(parameterName);

% If dimension greater than 1 (non-scalar), use first varargin value to
% specify dimension to set
if (variable.Dimensions(2) > 1)
    variable.Value(varargin{1}) = value;
    
    % Verify correct number of parameters passed to function
    if (length(varargin) > 2)
        
        % If variable has two components, set string appropriately
        if (variable.Dimensions(2) == 2)
            str = sprintf('[%d %d]',variable.Value);
            
        % If variable has three components, set string appropriately
        elseif (variable.Dimensions(2) == 3)
            str = sprintf('[%d %d %d]',variable.Value);
        end
        
        % Issue set_param to propogate changes to model
        set_param(varargin{2},varargin{3},str);
    end

% Else if value is scalar, set variable value as value passed into function
else
    variable.Value = value;
    
    % Verify correct number of parameters passed to function
    if (length(varargin) == 2)
        
        % Correctly set string to be passed to set_param
        str = sprintf('%d',variable.Value);
        
        % Issue set_param to propogate changes to model
        set_param(varargin{1},varargin{2},str);
    end
end

% Set changed value in data dictionary
setValue(entry,variable);

end

