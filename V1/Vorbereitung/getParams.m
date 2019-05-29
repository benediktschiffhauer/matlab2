function [ J1, J2, l1, l2, g, m1, m2, RP1, RP2 ] = getParams()
%GETPARAMS returns a vector containing the parameters of the pendubot.
% [J1, J2, l1, l2, g, m1, m2, RP1, RP2]

l1  = 0.2;
l2  = 0.2;
g   = 9.81;
m1  = 0.3;
m2  = 0.3;
RP1 = 1e-2;
RP2 = 1e-3;
J1  = m1/12*l1.^2;
J2  = m2/12*l2.^2;

end

