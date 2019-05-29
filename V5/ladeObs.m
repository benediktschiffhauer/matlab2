function stObs = ladeObs( f, h, AP, x0obs, poles )
%LADEOBS stellt einen Struct f�r die Simulation bereit, der alle Daten
%enth�lt, um den implementierten vollst�ndigen Luenberger-Beobachter zu
%parametrieren (sofern diese Daten nicht bereits vom �bergeordneten Modell 
%verf�gbar sind).

[ A, B, C, ~, ~ ] = linearisierung( f, h, AP );

stObs.A = A;
stObs.B = B;
stObs.C = C;
stObs.L = berechneBeobachter(A,C,poles);
stObs.x0obs = x0obs;

end

