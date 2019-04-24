function vecReturn = linePlaneIntersect(unitVec,normalVec,vecKnown)
%LINEPLANEINTERSECT function calculates intersection of known vector and
% known unit vector with component normal to plane
%   Inputs:
%       unitVec = unit vector describing vector direction of new calculated vector
%     normalVec = normal vector describing vector normal to intersected plane
%      vecKnown = known vector from origin to point on intersecting plane
%   Outputs:
%     vecReturn = returned vector pointing from origin to intersecting plane

vecReturn = (dot(unitVec,normalVec)/dot(vecKnown,normalVec))*unitVec;

end

