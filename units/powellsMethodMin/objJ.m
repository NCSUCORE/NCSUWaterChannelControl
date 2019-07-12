function J = objJ(EulAng,CoMPos,rCentroid,uCentroid,bodyFixedVec)

% Minimization function used as basis for powell's method optimization.
%
% INPUTS:
% EulAng - current Euler angles of the body
% CoMPos - center of mass position in ground frame 
% rCentroid - inside of glass vectors from ray trace algorithm in ground frame
% uCentroid - unit vectors from ray trace algorithm in ground grame
% bodyFixedVec - vectors from center of mass to dot set centroids

% OUTPUTS:
% J - cumulmative result from formulation

% x = [roll, pitch, yaw]
J = 0;

% Calculate body to ground rotation matrix given current Euler angles
RGB = calculateRotationMatrix(EulAng(1),EulAng(2),EulAng(3));
RBG = RGB';

% Loop through all rays given from ray trace algorithms
for ii = 1:length(rCentroid)
    % Calculate optimal distance along unit vector
    d = uCentroid(:,ii)'*(CoMPos + RBG*bodyFixedVec(:,ii) - rCentroid(:,ii));
    % Calculate error from current ray and dot location
    e = dot( ((CoMPos + RBG*bodyFixedVec(:,ii)) - (rCentroid(:,ii) + uCentroid(:,ii)*d)),...
             ((CoMPos + RBG*bodyFixedVec(:,ii)) - (rCentroid(:,ii) + uCentroid(:,ii)*d)) );

    J = J + e;
end

end
