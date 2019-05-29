x_AP = [pi/3, 0, pi, 0];
% x_AP = [pi/3, 0, 0, 0];
M_AP = [];
Q = diag([1 1 1 1]);
R = 10;
T_stop = 5;

stPendel = ladePendel();
x0 = [-pi/3 0 pi 0];
% x0 = [-pi/3 0 0 0];

%% Berechne Linearisierung
syms phi1 phi2 dphi1 dphi2 ddphi1 ddphi2 M
[ddphi1, ddphi2] = getNLode(stPendel);
f = [dphi1;ddphi1;dphi2;ddphi2];
h = [phi1;phi2];
[A, B, C, D, M_AP] = linearisierung(f,h,x_AP);

%% Berechne LQ-Regler
[K, poleRK] = berechneLQR(A,B,Q,R);
