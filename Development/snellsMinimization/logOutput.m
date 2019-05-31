if p.Results.LogOutput
    assignin('base','F',F(end));
    evalin('base','convergence(end+1,:) = [numEvals F];')
end