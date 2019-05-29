function [ vTout, mXout ] = interpolateSim( vT, mX, samples )
%INTERPOLATESIM interpoliert die Simulationsdaten mit äquidistanten
%Stützstellen.

if nargin == 3
    vTout = linspace(min(vT),max(vT),samples);
else
    vTout = min(vT):1/25:max(vT);
end

mXout = zeros(length(vTout),4);
method = 'PCHIP';

mXout(:,1) = interp1(vT,mX(:,1),vTout,method);
mXout(:,2) = interp1(vT,mX(:,2),vTout,method);
mXout(:,3) = interp1(vT,mX(:,3),vTout,method);
mXout(:,4) = interp1(vT,mX(:,4),vTout,method);

end

