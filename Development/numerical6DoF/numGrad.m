function [g,u] = numGrad(x0,dx,R,D,U,w)
% NUMGRAD(x,dx) function to numerically approximate a gradient using small
% perturbations of size dx.
% x is the point where the gradient is evaluated
% dx is a vector of perturbation sizes
J = zeros(numel(dx),3);
J(:,2) = perfIndx(x0,R,D,U,w);

for ii = 1:numel(dx)
    % left point
    xl = x0;
    xl(ii) = xl(ii) - dx(ii);
    J(ii,1) = perfIndx(xl,R,D,U,w);
    % right point
    xr  = x0;
    xr(ii) = xr(ii) + dx(ii);
    J(ii,3) = perfIndx(xr,R,D,U,w);
end
% Average of left and right derivatives
g = sum(diff(J,[],2)./[dx(:) dx(:)],2)./2;
g(abs(g)<1e-10) = 0;
% Normalize to get unit vector, with /0 protection
u = zeros(size(g));
if any(g~=0)
    u = g./sqrt(sum(g,'all'));
end
end