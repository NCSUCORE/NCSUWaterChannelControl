function val = calcSpatialCovariance(p1,p2,hyperParams)
% Calculate covariance using squared exponential kernel
%   Inputs :
%       p1 - point 1
%       p2 - point 2
%       hyperParams - hyper parameters,
%       hyperParams(1:end) = length Scales

% val = hyperParams(1)*exp(-0.5*sum((p1(:)-p2(:)).^2./hyperParams(2:end).^2));
val = exp(-0.5*sum((p1(:)-p2(:)).^2./hyperParams(1:end).^2));
end