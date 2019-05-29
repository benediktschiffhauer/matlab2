function stObs = ladeObs( f, h, AP, x0obs, poles )
%LADEOBS stellt einen Struct für die Simulation bereit, der alle Daten
%enthält, um den implementierten vollständigen Luenberger-Beobachter zu
%parametrieren (sofern diese Daten nicht bereits vom übergeordneten Modell 
%verfügbar sind).

[ A, B, C, ~, ~ ] = linearisierung( f, h, AP );

stObs.A = A;
stObs.B = B;
stObs.C = C;
stObs.L = berechneBeobachter(A,C,poles);
stObs.x0obs = x0obs;

end

