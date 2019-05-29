clear
close all

%% Setup q-points
AP1 = [0, 0, 0, 0];
AP2 = [pi, 0, pi, 0];
AP3 = [pi/2, 0, pi, 0];

%% Linearize
[f, h] = nonlinear_model();
[A_AP1, B_AP1, C_AP1, D_AP1] = linearisierung(f,h, AP1);
[A_AP2, B_AP2, C_AP2, D_AP2] = linearisierung(f,h, AP2);
[A_AP3, B_AP3, C_AP3, D_AP3] = linearisierung(f,h, AP3);

%% Compute eigenwerte
[ev1, ew1] = eig(A_AP1);
[ev2, ew2] = eig(A_AP2);
[ev3, ew3] = eig(A_AP3);
lambda1 = diag(ew1);
lambda2 = diag(ew2);
lambda3 = diag(ew3);

%% Setup state space models
sys_AP1 = ss(A_AP1,B_AP1,C_AP1,D_AP1);
sys_AP2 = ss(A_AP2,B_AP2,C_AP2,D_AP2);
sys_AP3 = ss(A_AP3,B_AP3,C_AP3,D_AP3);

%% Plot poles
figure(1);
scatter(real(lambda1),imag(lambda1),'x');
hold on;
scatter(real(lambda2),imag(lambda2),'x');
scatter(real(lambda3),imag(lambda3),'x');
legend('AP1','AP2','AP3');
grid on;
hold off;

%% diagonalize manually
[AD, BD, CD, DD] = diagonalForm(A_AP2,B_AP2,C_AP2,D_AP2);

%% diagonalize with 'canon'
csys = canon(sys_AP2,'modal');
AD_AP2_canon = csys.A;
BD_AP2_canon = csys.B;
CD_AP2_canon = csys.C;
DD_AP2_canon = csys.D;

%% diagonalize AP1 with 'canon'
csys = canon(sys_AP1,'modal');
AD_AP1_canon = csys.A;
BD_AP1_canon = csys.B;
CD_AP1_canon = csys.C;
DD_AP1_canon = csys.D;

%% controlability
controlableKalman = [0 0 0];
controlableKalman(1) = checkCtrbKalman(A_AP1,B_AP1);
controlableKalman(2) = checkCtrbKalman(A_AP2,B_AP2);
controlableKalman(3) = checkCtrbKalman(A_AP3,B_AP3);
controlableGilbert = [0 0 0];
controlableGilbert(1) = checkCtrbGilbert(A_AP1,B_AP1);
controlableGilbert(2) = checkCtrbGilbert(A_AP2,B_AP2);
controlableGilbert(3) = checkCtrbGilbert(A_AP3,B_AP3);
controlableHautus = [0 0 0];
controlableHautus(1) = checkCtrbHautus(A_AP1,B_AP1);
controlableHautus(2) = checkCtrbHautus(A_AP2,B_AP2);
controlableHautus(3) = checkCtrbHautus(A_AP3,B_AP3);

controlable = [0 0 0];
controlable(1) = (rank(ctrb(sys_AP1)) == 4);
controlable(2) = (rank(ctrb(sys_AP2)) == 4);
controlable(3) = (rank(ctrb(sys_AP3)) == 4);

%% observability
observableKalman = [0 0 0];
observableKalman(1) = checkObsvKalman(A_AP1,C_AP1);
observableKalman(2) = checkObsvKalman(A_AP2,C_AP2);
observableKalman(3) = checkObsvKalman(A_AP3,C_AP3);
observableGilbert = [0 0 0];
observableGilbert(1) = checkObsvGilbert(A_AP1,C_AP1);
observableGilbert(2) = checkObsvGilbert(A_AP2,C_AP2);
observableGilbert(3) = checkObsvGilbert(A_AP3,C_AP3);
observableHautus = [0 0 0];
observableHautus(1) = checkObsvHautus(A_AP1,C_AP1);
observableHautus(2) = checkObsvHautus(A_AP2,C_AP2);
observableHautus(3) = checkObsvHautus(A_AP3,C_AP3);

observable = [0 0 0];
observable(1) = (rank(obsv(sys_AP1)) == 4);
observable(2) = (rank(obsv(sys_AP2)) == 4);
observable(3) = (rank(obsv(sys_AP3)) == 4);