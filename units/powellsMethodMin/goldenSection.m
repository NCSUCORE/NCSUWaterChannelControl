function sLims = goldenSection(s0,x0,S,CoMPos,rCentroid,uCentroid,...
    bodyFixedVec,stepSize,fHandle)

% Function to implement golden section to minimize a scalar function
%
% INPUTS:
% s0 - initial guess
% x0 - current Euler angle guess
% S - matrix of search directions
% CoMPos - center of mass position in ground frame 
% rCentroid - inside of glass vectors from ray trace algorithm in ground frame
% uCentroid - unit vectors from ray trace algorithm in ground grame
% bodyFixedVec - vectors from center of mass to dot set centroids
% stepSize - initial step size (step size may be reduced if this is too
% big)
% fHandle - function handle containing powellsMethodFcn

% OUTPUTS:
% sLims - two element vector containing min and max of optimal scalar

% Convergence criteria 
inputConv = 0.001; % radians

% Obtain left and right bounds on current scalar
[sl,sr] = bound(s0,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec,stepSize,fHandle);

% Begin golden section
tau = 1 - 0.38197;
initialRange = abs(sr-sl);
fl = fHandle(sl,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec);
fr = fHandle(sr,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec);

% Print column headers to command window for output
% if p.Results.DisplayOutput
%     headings = {'sl','Fl','s1','F1','s2','F2','sr','Fr','sOpt','FOpt'};
%     headingString = [' '];
%     for ii = 1:length(headings)
%         headingString = [headingString pad(headings{ii},11)];
%     end
%     fprintf(['\n' headingString '\n'])
% end

for ii = 1:1000
    sTwo = (1-tau)*sl+tau*sr;
    sOne = tau*sl+(1-tau)*sr;
    fOne = fHandle(sOne,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec);
    fTwo = fHandle(sTwo,x0,S,CoMPos,rCentroid,uCentroid,bodyFixedVec);
    fMin = min([fl fr fOne fTwo]);
    fMax = max([fl fr fOne fTwo]);
    sMin = min([sl sr sOne sTwo]);
    sMax = max([sl sr sOne sTwo]);
    
%     if p.Results.DisplayOutput
%         fprintf('%10f %10f %10f %10f %10f %10f %10f %10f %10f %10f \n',...
%             sl,fl,sOne,fOne,sTwo,fTwo,sr,fr,mean([sr sl]),fHandle(mean([sr sl]),x0,S,CoMPos,...
%             rCentroidSide,rCentroidBotA,rCentroidBotB,rCentroidSlant,...
%             uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
%             sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm))
%     end
    
    if  abs(sMax-sMin) <= inputConv || ...
            abs((sMax-sMin)/initialRange) <= inputConv
        break
    end
    if fOne > fTwo
        sl = sOne;
        fl = fOne;
    else
        sr = sTwo;
        fr = fTwo;
    end
    
end
sLims = [sl sr];

% if p.Results.DisplayOutput
%     fprintf('\n%d\t%d\n',sLims)
%     fprintf('\n%d\n',mean(sLims))
% end

end