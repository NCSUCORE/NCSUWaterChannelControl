function [predMean,postVarMat] = ...
    calcPredMeanAndPostVar(muGt_1,cGt_1,xt,yt,...%signals
    xBasis,meanFnProps,hyperParams,...
    meanFnVector,spatialCovMat,noiseVariance) % parameters
% extract values from basic vector
xB = xBasis;
% number of design/training points
noTP = size(xB,2);
% calculate mean and covariance at candidate point
mXt = meanFunction(xt,meanFnProps);
kXtXt = calcSpatialCovariance(xt,xt,hyperParams);
% calculate covariance of candidate wrt design points
kXtX = NaN(1,noTP);
for ii = 1:noTP
    kXtX(1,ii) = calcSpatialCovariance(xt,xB(:,ii),hyperParams);
end
% calculate Jt as per Huber Eqn. (8)
Jt = kXtX/spatialCovMat;
% calculate B as per Huber Eqn. (7)
B = kXtXt - Jt*kXtX';
% calculate muP as per Huber Eqn. (6)
muP = mXt + Jt*(muGt_1 - meanFnVector)';
% calculate cP as per Huber Eqn. (9)
cP = B + Jt*cGt_1*Jt';
% calculate Gt (kalman gain matrix) as per Huber Eqn. (12)
Gt = cGt_1*Jt'*(cP + noiseVariance)^-1;
% calculate mean at step t as per Huber Eqn. (10)
predMean = muGt_1' + Gt*(yt - muP);
% calculate covariance at step t as per Huber Eqn. (11)
postVarMat = cGt_1 - Gt*Jt*cGt_1;
end