function [ vT, vM, mX ] = runPendel( stPendel, AP, K, x0 )

assignin('base','stPendel',stPendel);
assignin('base','x_AP',AP);
assignin('base','K',K);
assignin('base','x0',x0);
sim('V3_sim');
vT = mZustand.time;
vM = vInput.signals.values;
mX = mZustand.signals.values;

end

