clear;
clc;
disp(' -> Model for Pendubot <- ');
disp('==========================');
disp(' ');

%% Params
disp('Setup params...');
syms t g;
syms phi1 dphi1 ddphi1 phi2 dphi2 ddphi2 M;
syms x1 dx1 ddx1 y1 dy1 ddy1 l1 m1 J1 MR1 RP1;
syms x2 dx2 ddx1 y2 dy2 ddy2 l2 m2 J2 MR2 RP2;

%% Model
disp('Setup model...');
MR1 = RP1*dphi1;
MR2 = RP2*(dphi2 - dphi1);

J1 = m1/12 * l1.^2;
J2 = m2/12 * l2.^2;

x1 = l1/2 * sin(phi1);
y1 = -l1/2 * cos(phi1);
x2 = l2/2 * sin(phi2) + 2*x1;
y2 = -l2/2 * cos(phi2) + 2*y1;

dx1 = dphi1 * l1/2 * cos(phi1);
dy1 = dphi1 * l1/2 * sin(phi1);
dx2 = dphi2 * l2/2 * cos(phi2) + 2*dx1;
dy2 = dphi2 * l2/2 * sin(phi2) + 2*dy1;

ddx1 = ddphi1 * l1/2 * cos(phi1) - dphi1.^2 * l1/2 * sin(phi1);
ddy1 = ddphi1 * l1/2 * sin(phi1) + dphi1.^2 * l1/2 * cos(phi1);
ddx2 = ddphi2 * l2/2 * cos(phi2) - dphi2.^2 * l2/2 * sin(phi2) + 2*ddx1;
ddy2 = ddphi2 * l2/2 * sin(phi2) + dphi2.^2 * l2/2 * sin(phi2) + 2*ddy1;

%% Lagrange
disp('Setup Lagrange...');
T = m1/2*(dx1.^2+dy1.^2) + J1/2*dphi1.^2 ...
    + m2/2*(dx2.^2+dy2.^2) + J2/2*dphi2^2;

U = m1 * g * y1 + m2 * g * y2;

L = T - U;

Q1 = M - MR1;
Q2 =   - MR2;

%% Jacobians
disp('Compute Jacobians...');
L_phi1  = jacobian(L,phi1);
L_dphi1 = jacobian(L,dphi1);
L_phi2  = jacobian(L,phi2);
L_dphi2 = jacobian(L,dphi2);

L_dphi1_t = subs(L_dphi1,{phi1 dphi1 phi2 dphi2},{'phi1(t)' 'dphi1(t)' 'phi2(t)' 'dphi2(t)'});
L_dphi2_t = subs(L_dphi2,{phi1 dphi1 phi2 dphi2},{'phi1(t)' 'dphi1(t)' 'phi2(t)' 'dphi2(t)'});

dL_dphi1_t = diff(L_dphi1_t,t);
dL_dphi2_t = diff(L_dphi2_t,t);

Var_t  = {'phi1(t)' 'dphi1(t)' 'phi2(t)' 'dphi2(t)' 'diff(phi1(t),t)' 'diff(dphi1(t),t)' 'diff(phi2(t),t)' 'diff(dphi2(t),t)'};
Var_ot = {phi1 dphi1 phi2 dphi2 dphi1 ddphi1 dphi2 ddphi2};

dL_dphi1 = subs(dL_dphi1_t,Var_t,Var_ot);
dL_dphi2 = subs(dL_dphi2_t,Var_t,Var_ot);

%% Solve Lagrange
disp('Solve Lagrangian...');
Sol = solve([dL_dphi1 - L_phi1 == Q1, dL_dphi2 - L_phi2 == Q2],[ddphi1 ddphi2]);
Sol.ddphi1 = simplify(Sol.ddphi1, 'IgnoreAnalyticConstraints', true, 'Steps', 20);
Sol.ddphi2 = simplify(Sol.ddphi2, 'IgnoreAnalyticConstraints', true, 'Steps', 20);

%% Store results
disp('Export results to mPendubot.mat and formulae.tex ...');
save('mPendubot.mat','-struct','Sol');
tex1 = latex(Sol.ddphi1);
tex2 = latex(Sol.ddphi2);
file = fopen('formulae.tex','w');
fprintf(file,'ddphi1 &= %s \nddphi2 &= %s',tex1,tex2);
fclose(file);
clear tex1 tex2 file
