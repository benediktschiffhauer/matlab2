function [ ddphi1, ddphi2 ] = getNLode( J1, J2, l1, l2, g, m1, m2, RP1, RP2 )
%GETNLODE Summary of this function goes here
%   Detailed explanation goes here
ddphi1 = [];ddphi2 = [];

load('mPendubot.mat');

Var_sym = {'J1', 'J2', 'l1', 'l2', 'g', 'm1', 'm2', 'RP1', 'RP2'};
Var_val = {J1, J2, l1, l2, g, m1, m2, RP1, RP2};

ddphi1 = simplify(subs(ddphi1,Var_sym,Var_val));
ddphi2 = simplify(subs(ddphi2,Var_sym,Var_val));

end

