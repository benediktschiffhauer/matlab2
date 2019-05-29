function [ vTout, mXout ] = interpolateSim( vT, mX, samples )
%INTERPOLATESIM Summary of this function goes here
%   Detailed explanation goes here

vTout = linspace(min(vT),max(vT),samples);

mXout = zeros(samples,4);
method = 'cubic';

mXout(:,1) = interp1(vT,mX(:,1),vTout,method);
mXout(:,2) = interp1(vT,mX(:,2),vTout,method);
mXout(:,3) = interp1(vT,mX(:,3),vTout,method);
mXout(:,4) = interp1(vT,mX(:,4),vTout,method);

end

