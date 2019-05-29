function [ ddphi1 ] = fcn_ddphi1(  )
%FCN_DDPHI1 Summary of this function goes here
%   Detailed explanation goes here
-(24*RP1*dphi1*l2 - 24*M*l2 + 36*RP2*dphi1*l1*cos(phi1 - phi2) - 36*RP2*dphi2*l1*cos(phi1 - phi2) + 9*g*l1*l2*m2*sin(phi1 - 2*phi2) + 9*dphi1^2*l1^2*l2*m2*sin(2*phi1 - 2*phi2) + 12*dphi2^2*l1*l2^2*m2*sin(phi1 - phi2) + 12*g*l1*l2*m1*sin(phi1) + 15*g*l1*l2*m2*sin(phi1))/(l1^2*l2*(8*m1 + 15*m2 - 9*m2*cos(2*phi1 - 2*phi2)))

end

