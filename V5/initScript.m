% clear;
% 
% load('traj.mat');

t = stTraj.vT;
u = stTraj.vU;

Te = round(max(t) + 1, 0);
% Te = max(t)+1;
M_AP = 0;
stPendel = ladePendel();
x0 = [0 0 0 0];

%% manipulate pendel params
% stPendel.m1 = stPendel.m1 * 0.95;