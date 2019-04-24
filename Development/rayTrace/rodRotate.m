function vrot = rodRotate(v,theta,k)
% https://en.wikipedia.org/wiki/Rodrigues%27_rotation_formula
vrot = v*cos(theta) + cross(k,v)*sin(theta) + k*dot(k,v)*(1-cos(theta));
end