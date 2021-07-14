%% data processing
% data filtering window used before differentiating position to get
% velocity
rgpParams.filterWindow = 20;

%% RGP regression
% turbine rated speed [ms/s]
rgpParams.turbineRatedSpeed_cmps = 30;

% RGP basis vector space [rollAmpDeg; rollPeriodSec; FlowSpeed [cmps]]
rgpParams.basisVector = ones(3);

% RGP constant mean function value
rgpParams.meanFcnValue = 0;

% RGP mean function vector
rgpParams.meanFcnVector = meanFunction(rgpParams.basisVector,...
    rgpParams.meanFcnValue);

% RGP covariance kernel hyperparameters
rgpParams.hyperParameters = ones(3,1);

% RGP basis vector space covariance matrix
rgpParams.basisCovMat = zeros(size(rgpParams.basisVector,2));
% loop throught each point and make lower triu matrix
for ii = 1:size(rgpParams.basisVector,2)
    for jj = 1:ii
        rgpParams.basisCovMat(ii,jj) = ...
            calcSpatialCovariance(rgpParams.basisVector(:,ii),...
            rgpParams.basisVector(:,jj),rgpParams.hyperParameters);
    end
end
% make the full matrix
rgpParams.basisCovMat = rgpParams.basisCovMat + tril(rgpParams.basisCovMat,-1)';

% RGP noise variance
rgpParams.noiseVariance = 0.01;

%% RGP control
% RGPprediction mean control gain
rgpParams.predMeanCtrlGain = -1;

% RGP posterior variance control gain
rgpParams.postVarCtrlGain = 2^1;

% RGP control initial roll amplitude [deg]
rgpParams.initRollAmpDeg = 0;

% RGP control initial roll period [sec]
rgpParams.initRollPeriodSec = 20;

% RGP control initialization offset [-]
rgpParams.initControlOffsetPeriods = 3;

