clear;close all;clc
% Test 1: performance should be zero
x0   = [0 0 51 0 30*pi/180 0];
w   = [1 1 1 1];
dx = [0.0001 0.0001 0.0001 0.01*pi/180 0.01*pi/180 0.01*pi/180];

% Periscope camera
r1 = [ 51 0 50];
u1 = [-1  0 0 ];
d1 = [ 1  0 0 ];
% Bottom camera
r2 = [0 0 -1];
u2 = [0 0  1];
d2 = [0 0 -1];
% Side Camera
r3 = [0  51 50];
u3 = [0 -1  0 ];
d3 = [0  1  0 ];
% Another side camera
r4 = [0 -49 50];
u4 = [0  1  0 ];
d4 = [0 -1  0 ];

R = [r1(:) r2(:) r3(:) r4(:)];
U = [u1(:) u2(:) u3(:) u4(:)];
D = [d1(:) d2(:) d3(:) d4(:)];

tic
xF = BFGS(x0,eye(numel(x0)),dx,1e-4,R,D,U,w);
toc

h.fig = figure;
h.ax  = axes;
hold on
grid on

for ii = 1:size(R,2)
    h.pt(ii) = scatter3(....
        R(1,ii),R(2,ii),R(3,ii),...
        'Marker','o','CData',[0 0 0]);
    h.unit(ii) = plot3(...
        [R(1,ii) R(1,ii)+50*U(1,ii)],...
        [R(2,ii) R(2,ii)+50*U(2,ii)],...
        [R(3,ii) R(3,ii)+50*U(3,ii)],...
        'LineStyle','--','Color','k');
    h.dot(ii) = scatter3(...
        x0(1)+D(1,ii),...
        x0(2)+D(2,ii),...
        x0(3)+D(3,ii),...
        'Marker','o','CData',[1 0 0]);
    daspect([1 1 1])
end