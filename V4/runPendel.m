function [ vT, vU, mX, mXobs] = runPendel( stPendel, AP, K, x0, M_AP, stObs )
%RUNPENDEL führt die Simulation des Pendels aus.

useObserver = 0;

if nargin < 5
    M_AP = 0;
elseif nargin == 6
    useObserver = 1;
end

if useObserver
    A = stObs.A;
    B = stObs.B;
    C = stObs.C;
    L = stObs.L;
    x0obs  = stObs.x0obs;
else
    A = zeros(4);
    B = zeros(4,1);
    C = zeros(2,4);
    L = zeros(4,2);
    x0obs = zeros(4,1);
end

assignin('base','stPendel',stPendel);
assignin('base','x_AP',AP);
assignin('base','M_AP',M_AP);
assignin('base','K',K);
assignin('base','x0',x0);

assignin('base','useObs',useObserver);
assignin('base','A',A);
assignin('base','B',B);
assignin('base','C',C);
assignin('base','L',L);
assignin('base','x0obs',x0obs);

assignin('base','Te',5);

assignin('base','noise',[.00001 0 .00001 0]);

sim('V3_sim');
vT = mZustand.time;
vU = vInput.signals.values;
mX = mZustand.signals.values;
mXobs = mBeobachter.signals.values;

end

