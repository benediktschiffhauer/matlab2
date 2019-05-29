function [ A, B, C, D, M_AP ] = linearisierung( f, h, AP )
%LINEARISIERUNG Summary of this function goes here
%   Detailed explanation goes here

syms phi1 phi2 dphi1 dphi2 M real;
x = [phi1, dphi1, phi2, dphi2];
u = M;

old = {phi1, dphi1, phi2, dphi2};

f_AP = eval(subs(f,old,AP));
M_AP_sym = solve([f_AP(2)==0],M);

dfdx = jacobian(f, x);
dfdu = jacobian(f, u);
dhdx = jacobian(h, x);
dhdu = jacobian(h, u);

M_AP = eval(subs(M_AP_sym,old,AP));
% assignin('base','M_AP',M_AP);

old = [phi1, dphi1, phi2, dphi2, M];
AP_new = [AP, M_AP];

A = eval(subs(dfdx,old,AP_new));
B = eval(subs(dfdu,old,AP_new));
C = eval(subs(dhdx,old,AP_new));
D = eval(subs(dhdu,old,AP_new));

end

