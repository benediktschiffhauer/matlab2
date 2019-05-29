function [ K, poleRK ] = berechneLQR( A, B, Q, R )
%BERECHNELQR berechnet einen linear-quadratischen Zustandsregler f�r das
%angegebene System.
% A...Systemmatrix
% B...Eingangsmatrix
% Q...G�tema� Zust�nde
% R...G�tema� Eingang

% Fehlerabfragen
K = 'Error';
poleRK = [];

% Pr�fe Steuerbarkeit
steuerbar = checkCtrbKalman(A,B);

% Pr�fe Symmetrie
symmetrisch_Q = issymmetric(Q);
symmetrisch_R = issymmetric(R);

% Pr�fe positive Definitheit
EW = eig(Q);
posdefinit_Q = (sum(EW>0) == length(EW));
EW = eig(R);
posdefinit_R = (sum(EW>0) == length(EW));

if(steuerbar && symmetrisch_Q && symmetrisch_R && posdefinit_Q && posdefinit_R)
    [K, ~, poleRK] = lqr(A,B,Q,R);
end

end

