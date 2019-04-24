function [relativeVec,absoluteVec] = linePlaneIntersect(...
    unitVec,unitVecBase,knownVec,knownVecBase,normalVec)
%LINEPLANEINTERSECT See linePlaneIntersect.jpg for details
relativeVec = (dot(knownVec+knownVecBase-unitVecBase,normalVec)/dot(unitVec,normalVec))*unitVec;
absoluteVec = relativeVec + unitVecBase;
end

