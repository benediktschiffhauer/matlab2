function [ K, poleRK ] = berechneLQR( A, B, Q, R )
%BERECHNELQR berechnet einen linear-quadratischen Zustandsregler für das
%angegebene System.
% A...Systemmatrix
% B...Eingangsmatrix
% Q...Gütemaß Zustände
% R...Gütemaß Eingang

% Fehlerabfragen
K = 'Error';
poleRK = [];

% Prüfe Steuerbarkeit
steuerbar = checkCtrbKalman(A,B);

% Prüfe Symmetrie
symmetrisch_Q = issymmetric(Q);
symmetrisch_R = issymmetric(R);

% Prüfe positive Definitheit
EW = eig(Q);
posdefinit_Q = (sum(EW>0) == length(EW));
EW = eig(R);
posdefinit_R = (sum(EW>0) == length(EW));

if(steuerbar && symmetrisch_Q && symmetrisch_R && posdefinit_Q && posdefinit_R)
    [K, ~, poleRK] = lqr(A,B,Q,R);
end

end

