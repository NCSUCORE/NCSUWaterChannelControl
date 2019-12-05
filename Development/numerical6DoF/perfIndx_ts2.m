clear;close all;clc
% Test 2: Set the model to some orientation and see if it converges
posVecTrue = [20*rand  30*rand-15 50*rand+25];
eulAngTrue = (20*rand(3,1)-10)*pi/180;
rotMatTrue = eul2Rot(eulAngTrue);

x0   = [0 0 50 0 0 0];
dx = [0.0001 0.0001 0.0001 0.01*pi/180 0.01*pi/180 0.01*pi/180];


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


tic
xF = BFGS(x0,eye(numel(x0)),dx,1e-4,R,DBdyTrue,U,w);
toc

posVecCalc = xF(1:3);
eulAngCalc = xF(4:6);
rotMatCalc = eul2Rot(eulAngCalc)';


h.fig = figure('Units','Normalized',...
    'Position',[1.0000    0.0370    1.0000    0.8917]);
h.ax  = axes;
hold on
grid on
xlabel('x')
ylabel('y')
zlabel('z')
view([35 35])


for ii = 1:size(R,2)
    h.ptTrue(ii) = scatter3(....
        R(1,ii),R(2,ii),R(3,ii),...
        'Marker','o','CData',[0 0 0]);
    h.unitTrue(ii) = plot3(...
        [R(1,ii) R(1,ii)+L(ii)*U(1,ii)],...
        [R(2,ii) R(2,ii)+L(ii)*U(2,ii)],...
        [R(3,ii) R(3,ii)+L(ii)*U(3,ii)],...
        'LineStyle','-','Color','k');
    h.dotTrue(ii) = scatter3(...
        posVecTrue(1)+DGndTrue(1,ii),...
        posVecTrue(2)+DGndTrue(2,ii),...
        posVecTrue(3)+DGndTrue(3,ii),...
        'Marker','o','CData',[1 0 0]);
    
    ptCalc = posVecCalc(:) + rotMatCalc*DBdyTrue(:,ii);
    h.ptTrue(ii) = scatter3(....
        ptCalc(1),ptCalc(2),ptCalc(3),...
        'Marker','x','CData',[0 0 1]);
    
    daspect([1 1 1])
end

h.posTrue = plot3(...
    [0 posVecTrue(1)],...
    [0 posVecTrue(2)],...
    [0 posVecTrue(3)],...
    'Color','b','LineStyle','-');

h.posCalc = plot3(...
    [0 posVecTrue(1)],...
    [0 posVecTrue(2)],...
    [0 posVecTrue(3)],...
    'Color','r','LineStyle','--');

fprintf('\nPosition error (mm)\n')
posVecErr = (posVecTrue(:)'- posVecCalc(:)')/10
fprintf('\nEuler angle error (deg)\n')
eulAngErr = (eulAngTrue(:)'-eulAngCalc(:)')*180/pi

save('ts2WrkSpc.mat')
