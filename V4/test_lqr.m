clear

sys = ss(tf([1 -1],[1 2 3]));
Q = diag([1 1]);
R = diag([1]);

pole_ungeregelt = pole(sys);

[K, poleRK] = berechneLQR(sys.A,sys.B,Q,R);

A_RK = sys.A - sys.B*K;
sys_geregelt = sys;
sys_geregelt.A = A_RK;
pole_geregelt = eig(A_RK);