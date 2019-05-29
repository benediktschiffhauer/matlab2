sim.info = 'Steuerung nicht erfolgreich mit Motormodell ohne Folgeregler';

sim.vInput = vInput;
sim.T_M = T_M;
sim.mZustand = mZustand;
sim_index = sim_index+1;

save(strcat('simout_',num2str(sim_index),'.mat'),'sim');
clear sim;