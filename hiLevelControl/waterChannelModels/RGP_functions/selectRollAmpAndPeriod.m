function [rollAmp,rollPeriod,maxUCB] = selectRollAmpAndPeriod(UCB,vFlow,xBasis)

% find basis flow speed closest to flow speed
[~,clIdx] = min((vFlow-xBasis(3,:)).^2);

% relevant basis vectors indices
relevantIdx = find(xBasis(3,:) == xBasis(3,clIdx));

% relevant basis vector and UCB values
relevantBasis = xBasis(:,relevantIdx);
relevantUCB   = UCB(relevantIdx);

% pick roll amp and period
[maxUCB,maxIdx] = max(relevantUCB);
rollAmp         = relevantBasis(1,maxIdx);
rollPeriod      = relevantBasis(2,maxIdx);

end