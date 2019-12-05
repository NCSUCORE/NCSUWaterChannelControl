function [J,E] = perfIndx(posVec,eulAngs,R,D,U,w)
%PERFINDX Performance index characterizing how well the proposed
%orientation and position fit the observed data.
%   
%   INPUTS:
%   posVec: 3 element position vector characterizing the vector from G to B
%   in the G frame.
%   eulAngs: 3 element vector of Tait-Bryan angles [roll pitch yaw] in deg
%   For a detailed explanation of the following, see numericalDoFSolution.jpg
%   Here, N is the number of dots being tracked with the ray tracing
%   algoritm, 
%   R: Matrix of ray tracing points in G frame, 3 by N
%   D: Matrix of dot position vecotrs in B frame, 3 by N
%   U: Matrix of ray tracing unit vectors in G frame, 3 by N
%   w: N element vector of weights on each error in the performance index
%
%   OUTPUTS:
%   J = sum of distance errors (not equared)
%   E = vector of individual errors

N = size(R,2);
rotMat = eul2Rot(eulAngs);

% Calculate B
B = repmat(posVec(:),[1 N]);

% Calculate L
% First rotate D into ground frame
D = rotMat * D;

% Calculate vector of individual lengths
% whiteboard is wrong, should be - not /
L = sum(((B+D).*U),1)-sum(R.*U,1);

% Create matrix via replication
% Whiteboard is wrong again, repmat over rows, not columns
L = repmat(L(:)',[3 1]);

% Calculate errors
E = sqrt(w(:)'.*sum((R+L.*U-B-D).^2,1));

% Sum errors to get perf index
J = sum(E);

end