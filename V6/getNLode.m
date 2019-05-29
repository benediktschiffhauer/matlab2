function [ ddphi1, ddphi2 ] = getNLode(stPendel)
%GETNLODE Summary of this function goes here
%   Detailed explanation goes here
ddphi1 = [];ddphi2 = [];

load('mPendubot.mat');
g = stPendel.g;
l1 = stPendel.l1;
l2 = stPendel.l2;
m1 = stPendel.m1;
m2 = stPendel.m2;
RP1 = stPendel.Rp1;
RP2 = stPendel.Rp2;

Var_sym = {'l1', 'l2', 'g', 'm1', 'm2', 'RP1', 'RP2'};
Var_val = {l1, l2, g, m1, m2, RP1, RP2};

ddphi1 = simplify(subs(ddphi1,Var_sym,Var_val));
ddphi2 = simplify(subs(ddphi2,Var_sym,Var_val));

end

