function [uVecOut] = snellsLaw3D(uVecIn,normalUVec,n1,n2)
%SNELLSLAW3D 3D version of Snells law
%   INPUTS
%   uVecIn - unit vector of incoming ray
%   normalUVec - unit normal vector, pointing out from surface
%   n1 - index of refraction of first substance
%   n2 - index of refraction of second substance
%   OUTPUTS
%   uVecOut - unit vector describing outgoing direction of travel

% If the incoming vector is perpindicular to surface
% if abs(uVecIn'*normalUVec)<eps
%     uVecOut = uVecIn;
%     return
% end

% See here https://en.wikipedia.org/wiki/Snell%27s_law#Vector_form
n = normalUVec;
l = uVecIn;
r = n1/n2;
c = -dot(n,l);
uVecOut = r*l + (r*c - sqrt(1 - (r^2)*(1-c^2)))*n;
end

