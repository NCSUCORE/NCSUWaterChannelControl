clear;close all;clc
% Test 1: performance should be zero
posVec  = [0 0 50];
eulAngs = [0 0 45];
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

[J,E] = perfIndx(posVec,eulAngs*pi/180,R,D,U);

sim('perfIndx_th')
J
simout.Data
