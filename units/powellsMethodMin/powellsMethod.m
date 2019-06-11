function desVars = powellsMethod(x0,CoMPos,rCentroidSide,rCentroidBotA,...
    rCentroidBotB,rCentroidSlant,uCentroidSide,...
    uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm)

%% Inupt Parsing
% p = inputParser;
% addRequired(p,'x0',...
%     @(x) isnumeric(x) && isvector(x))
% addOptional(p,'DisplayOutput',false,...
%     @(x) islogical(x))
% addOptional(p,'MaxIterations',1000,...
%     @(x) isnumeric(x) && isscalar(x) && x>0)
% addOptional(p,'FunctionConvergence',1e-5,...
%     @(x) isnumeric(x) && isscalar(x) && x>=0)
% addOptional(p,'InputConvergence',0.0001,@(x) isnumeric(x) && isscalar(x) && x>=0)
% addOptional(p,'StepTimeout',1000,...
%     @(x) isnumeric(x) && isscalar(x))
% addOptional(p,'StepSizeMultiplier',2,...
%     @(x) isnumeric(x) && isscalar(x)  && x>=1)
% addOptional(p,'BoundingTimeout',1000,...
%     @(x) isnumeric(x) && isscalar(x))
% addOptional(p,'FunctionHandle',...
%     @objJ,@(x) isa(x,'function_handle'))
% addOptional(p,'LineSearchMethod','GoldenSection',...
%     @(x) any(strcmpi(x,{'ThreePoint','GoldenSection'})))
% addOptional(p,'StepSize',0.001,...
%     @(x) isnumeric(x) && isscalar(x) && x>0)
% parse(p,x0,varargin{:})

%% The actual optimization
inputConv = 0.001;

% Matrix to store search directions for the current cycle
S = eye(numel(x0));

% Matrix to store points for the cycle
X0 = reshape(x0,[1 numel(x0)]);

X = zeros(4,3);
X(1,:) = X0;

% if p.Results.DisplayOutput
%     fprintf(['\nResults are reported at the end of each cycle\n',...
%         'not each linear search'])
%     fprintf('\n Iteration %s\n',num2str(0))
%     assignin('base',sprintf('x%s',num2str(0)),X)
%     evalin('base',sprintf('x%s',num2str(0)))
% end

for ii = 1:1000
    for jj = 1:size(S,1) % Loop through all the search directions
%         switch p.Results.LineSearchMethod
%             case 'ThreePoint'
%                 alphaStar = threePointQuadratic(0.1,X(jj,:),S(jj,:),CoMPos,rCentroidSide,rCentroidBotA,...
%                     rCentroidBotB,rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,...
%                     uCentroidSlant,sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm,...
%                     p.Results.StepSize,'FunctionHandle',@powellsMethodFcn,...
%                     'StepTimeout',p.Results.StepTimeout,...
%                     'StepSizeMultiplier',p.Results.StepSizeMultiplier,...
%                     'BoundingTimeout',p.Results.BoundingTimeout,...
%                     'StepSize',p.Results.StepSize);
%             case 'GoldenSection'
        alphaLims = goldenSection(0.1,X(jj,:),S(jj,:),CoMPos,rCentroidSide,rCentroidBotA,...
            rCentroidBotB,rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,...
            uCentroidSlant,sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm,...
            0.001,@powellsMethodFcn);
        alphaStar = mean(alphaLims);
%         end
%         alphaStar*S(jj,:)*180/pi
        X(jj+1,:) = X(jj,:) + alphaStar*S(jj,:);
    end
    
%     if p.Results.DisplayOutput
%         fprintf('\nIteration %s\n',num2str(ii))
%         
%         fprintf('-Current design point \n')
%         assignin('base',sprintf('xCurrent%s',num2str(ii)),X(end-1,:))
%         evalin('base',sprintf('xCurrent%s',num2str(ii)))
%         
%         fprintf('-Search direction \n')
%         assignin('base',sprintf('S%s',num2str(ii)),S(end,:))
%         evalin('base',sprintf('S%s',num2str(ii)))
%         
%         fprintf('-Alpha star \n')
%         assignin('base',sprintf('alphaStar%s',num2str(ii)),alphaStar)
%         evalin('base',sprintf('alphaStar%s',num2str(ii)))
%         
%         fprintf('-Next design point \n')
%         assignin('base',sprintf('xNext%s',num2str(ii)),X(end,:))
%         evalin('base',sprintf('xNext%s',num2str(ii)))
%     end

    % Update the matrix holding the search directions
    S = [S(2:end,:);X(end,:) - X(1,:)];
    % Update/reset the matrix of points
    %     if ii>2 && max(abs(X(end,(1:3)) - X(1,(1:3)))) <= p.Results.InputConvergence
    %
    %         break
    %     end
    
    X(1,:) = X(end,:);
    for kk = 2:4
        X(kk,:) = [0 0 0];
    end
    
    if all(abs(S(end,:))*180/pi < inputConv)
        break
    end
    
    % Log the function value
    %     F(ii) = p.Results.FunctionHandle(X',CoMPos,rCentroidSide,...
    %         rCentroidBotA,rCentroidBotB,rCentroidSlant,uCentroidSide,...
    %         uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    %         sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
    % Check for convergence
    %     if ii>2 && abs((F(ii-1)-min(F))/min(F))<= p.Results.FunctionConvergence
    %         break
    %     end
end

desVars = X(1,:)';

end