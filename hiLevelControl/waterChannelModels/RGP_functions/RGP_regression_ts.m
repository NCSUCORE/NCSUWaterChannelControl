clear
clc

%% load dummy RGP classdef
load('dummyRGP.mat');

%% load results from matlab test run
load('testCtrl.mat');

%% test parameters
% hyperparameters
hyperParameters = [rgp.spatialCovAmp(:); rgp.spatialLengthScale(:)];

% basis vector
basisVector = rgp.xBasis;

% mean function properties
meanFcnProperties = rgp.meanFnProps;

% mean function vector
meanFcnVector = meanFunction(basisVector,0);

% basis vector covariance matrix
% preallocate
basisCovMat = zeros(size(basisVector,2));
% loop throught each point and make lower triu matrix
for ii = 1:size(basisVector,2)
    for jj = 1:ii
        basisCovMat(ii,jj) = ...
            calcSpatialCovariance(basisVector(:,ii),basisVector(:,jj),hyperParameters);
    end
end
% make the total matrix
basisCovMat = basisCovMat + tril(basisCovMat,-1)';

% noise variance
noiseVariance = rgp.noiseVariance;

% sim time vec
timeVec = rgpCtrl.time(:);

%% make timeseries objects for test harness
% desgin variables timeseries
xtVals = timeseries([rgpCtrl.rollAmplitude;rgpCtrl.rollPeriod;...
    rgpCtrl.windSpeed],timeVec,'Name','DesignVars');
% measured values
ytVals = timeseries(rgpCtrl.costFunction,timeVec,'Name','Measurements');
% flow speeds
vfVals = timeseries(rgpCtrl.windSpeed,timeVec,'Name','FlowSpeed');

%% test function used by simulink
predMeanTest = zeros(length(meanFcnVector),length(rgpCtrl.time));
postVarTest = predMeanTest;

predMeanCtrlGain = -1;
postVarCtrlGain  = 1;

for ii = 1:length(rgpCtrl.time)
    
    if ii>1 && mod(rgpCtrl.time(ii),xtVals.Data(2,ii))==0
        if ~exist('predMean','var')
            % RGP: initial state estimate
            muGt_1 = meanFcnVector;
            cGt_1  = basisCovMat;
        else
            % RGP: initial state estimate
            muGt_1   = predMean';
            cGt_1    = postVarMat;
        end
        
        [predMean,postVarMat] = ...
            calcPredMeanAndPostVar(muGt_1,cGt_1,...%signals
            xtVals.Data(:,ii),ytVals.Data(ii),...
            basisVector,meanFcnProperties,hyperParameters,... % parameters
            meanFcnVector,basisCovMat,noiseVariance);
        
        predMeanTest(:,ii) = predMean;
        postVarTest(:,ii) = diag(postVarMat);
        
        ucbVal = upperConfidenceBound(predMeanTest(:,ii),postVarTest(:,ii),...
            postVarCtrlGain,predMeanCtrlGain);
        
        [rollAmp(ii),rollPeriod(ii),maxUCB(ii)] = ...
            selectRollAmpAndPeriod(ucbVal,rgpCtrl.windSpeed(ii),basisVector);
    elseif ii>1
        predMeanTest(:,ii) = predMeanTest(:,ii-1);
        postVarTest(:,ii) = postVarTest(:,ii-1);
        
    end
    
    
end

%% run sim and get output
simOut = sim('RGP_regression_th');

simPredMean = simOut.logsout.getElement('predMean').Values;
simPostVar = simOut.logsout.getElement('postVar').Values;
simRollAmp = simOut.logsout.getElement('rollAmpSP').Values;
simRollPer = simOut.logsout.getElement('rollPeriodSP').Values;
simMaxUCB  = simOut.logsout.getElement('maxUCB').Values;
%% compare with matlab results
simPredMeanTest = squeeze(simPredMean.Data);
simPostVarTest = squeeze(simPostVar.Data);



