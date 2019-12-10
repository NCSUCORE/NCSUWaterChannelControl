clear;close all;clc
% Test 2: Set the model to some orientation and see if it converges
posVecTrue = [20*rand  30*rand-15 50*rand+25];
eulAngTrue = (20*rand(3,1)-10)*pi/180;
rotMatTrue = eul2Rot(eulAngTrue);

numDots = 8;

w = ones([1 numDots]);

for ii = 1:numDots
    r = 200*rand(3,1)-100;
    R(:,ii) = r(:);
    
    d = 2*rand(3,1)-1;
    d = 10 * d./sqrt(sum(d.^2));
    DBdyTrue(:,ii) = d(:);
    DGndTrue(:,ii) = rotMatTrue'*DBdyTrue(:,ii);
    
    u = (posVecTrue(:) + DGndTrue(:,ii)) - r(:);
    L(ii) = sqrt(sum(u.^2));
    u = u./L(ii);
    
    % Noise
%         n = (2*rand(3,1)-1)/100;
%         U(:,ii) = u(:)+n(:);

    U(:,ii) = u(:);
end

D = DBdyTrue;

sim('fit6DoF_th')

fprintf('\nPosition error (mm)\n')
posVecErr = (posVecTrue(:)'- posVec.Data(:)')/10
fprintf('\nEuler angle error (deg)\n')
eulAngErr = (eulAngTrue(:)'-eulAngVec.Data(:)')*180/pi

if err.Data>0
    fprintf('\nError occured\n')
end




