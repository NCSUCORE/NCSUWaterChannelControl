close all
clear
clc

theta = -45;

uVecIn     = [cosd(theta) sind(theta)  0]'
normalUVec = [-1 0 0]'
n1 = 0.9;
n2 = 1;

[uVecOut] = snellsLaw3D(uVecIn,normalUVec,n1,n2)