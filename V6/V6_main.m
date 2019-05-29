clear all
clc

overwrite_file = 1;

Q = diag([1 1 1 1]);
R = 1;

%% Load params
disp('-- Load Params');
load('traj.mat');
if ~isfield(stTraj,'A')
    [A,B,C,D] = linearisierung_XU(stTraj.mX,stTraj.vU);
    stTraj.A = A;
    stTraj.B = B;
    stTraj.C = C;
    stTraj.D = D;
    if overwrite_file
        save('traj.mat','stTraj');
    end
end
stPendel = ladePendel();
disp('  done!');

%% Folgeregler berechnen
disp('-- Calculate compensation');
[vTK, mK] = berechneK(stTraj,Q,R);
stTraj.vTK = vTK;
stTraj.mK = mK;
disp('  done!');