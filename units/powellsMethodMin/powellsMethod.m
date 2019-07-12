function desVars = powellsMethod(x0,CoMPos,rCentroid,uCentroid,bodyFixedVec)

% This function uses Powell's method to calculate the optimal Euler angles
%   given the center of mass position, the outputs from the ray trace
%   algorithm, and the body fixed dot set vectors.

% INPUTS:
% x0 - initial Euler angle guess
% CoMPos - center of mass position in ground frame 
% rCentroid - inside of glass vectors from ray trace algorithm in ground frame
% uCentroid - unit vectors from ray trace algorithm in ground grame
% bodyFixedVec - vectors from center of mass to dot set centroids

% OUTPUTS:
% desVars - Euler angle output in radians

% Convergence criteria for Euler angles
inputConv = 0.001; % radians

% Matrix to store search directions for the current cycle
S = eye(numel(x0));
% S = [0 0 1;...
%      0 1 0;...
%      1 0 0;];

% Matrix to store points for the cycle
X0 = reshape(x0,[1 numel(x0)]);

X = zeros(4,3);
X(1,:) = X0;

for ii = 1:1000
    for jj = 1:size(S,1) % Loop through all the search directions
        
        % Use golden section to determine the optimal distance alphaStar 
        alphaLims = goldenSection(0.1,X(jj,:),S(jj,:),CoMPos,rCentroid,...
            uCentroid,bodyFixedVec,0.001,@powellsMethodFcn);
        alphaStar = mean(alphaLims);
        
        % Find next point in cycle
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
    
    % Reset the last three design points
    X(1,:) = X(end,:);
    for kk = 2:4
        X(kk,:) = [0 0 0];
    end
    
    % Check for convergence
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