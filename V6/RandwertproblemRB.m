function deltaRB = RandwertproblemRB( xa, xb )
%RANDWERTPROBLEMRB Summary of this function goes here
%   Detailed explanation goes here

[x0,xT] = RandwertproblemStates();

deltaRB = [xa(1:4)-x0;xb(1:4)-xT];

end

