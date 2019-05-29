close;
% clear;
clc;

V3_initSim;
% sim('V3_sim');
% V3_afterSim;


[ vT3, vM3, mX3 ] = runPendel( stPendel, x_AP, K, x0 );
disp('Simulation done!');

%%
frames = 200;
[vT,mX] = interpolateSim(vT,mX,frames);
disp('Simulation done! Press enter for animation');

%%
% pause();
animDest = axes();
animierePendel(vT,mX,stPendel,animDest);