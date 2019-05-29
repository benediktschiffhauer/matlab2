function systemPendel_V3(block)

	setup(block);

end


% *************************************************************************
% Initialisierung
% *************************************************************************
function setup(block)

	% Anzahl der Ein-/Ausgänge
	block.NumInputPorts  = 1;
	block.NumOutputPorts = 1;

	% Eigenschaften des Eingangs
	block.InputPort(1).Dimensions	= 1;
	block.InputPort(1).DatatypeID	= 0;  % double
	block.InputPort(1).Complexity	= 'Real';
	block.InputPort(1).DirectFeedthrough = false;
	block.InputPort(1).SamplingMode = 'Sample';

	% Eigenschaften des 1. Ausgangs
	block.OutputPort(1).Dimensions	= 4;
	block.OutputPort(1).DatatypeID	= 0; % double
	block.OutputPort(1).Complexity	= 'Real';
	block.OutputPort(1).SamplingMode = 'Sample';

    
	% Anzahl der Zustände
	block.NumContStates = 4;

	% Anzahl der Parameter
	block.NumDialogPrms = 2;


	% Abtastzeit definieren -> zeitkontinuierlich
	block.SampleTimes = [0 0];


	
	% weitere Methoden registrieren
	block.RegBlockMethod('InitializeConditions', @InitializeConditions);
	block.RegBlockMethod('Outputs', @Outputs);
	block.RegBlockMethod('Derivatives', @Derivatives);
	block.RegBlockMethod('Terminate', @Terminate);

end


% *************************************************************************
% Anfangsbedingungen setzen
% *************************************************************************
function InitializeConditions(block)
    x0 = block.DialogPrm(2).Data;
	block.ContStates.Data = x0;
	
end


% *************************************************************************
% Ausgänge berechnen
% *************************************************************************
function Outputs(block)

	% Zustände auslesen
	x		= block.ContStates.Data;
	block.OutputPort(1).Data = x;
end


% *************************************************************************
% Ableitungen berechnen
% *************************************************************************
function Derivatives(block)

	% Parameter auslesen
    stPendel = block.DialogPrm(1).Data;
	g = stPendel.g;
	m1 = stPendel.m1;
	m2 = stPendel.m2;
	l1 = stPendel.l1;
	l2 = stPendel.l2;

	% Zustände auslesen
	x		= block.ContStates.Data;
	phi1	= x(1);
	dphi1   = x(2);
	phi2    = x(3);
	dphi2	= x(4);

	% Eingang auslesen
	M = block.InputPort(1).Data(1);

	
	
	% Ableitungen berechnen
	ddphi1 = -(3*(0 - 4*M*l2 + 0 ...
        - 0 + 2*dphi2^2*l1*l2^2*m2*sin(phi1 - phi2) ...
        + 2*g*l1*l2*m1*sin(phi1) + 4*g*l1*l2*m2*sin(phi1) + ...
        3*dphi1^2*l1^2*l2*m2*cos(phi1 - phi2)*sin(phi1 - phi2) - ...
        3*g*l1*l2*m2*cos(phi1 - phi2)*sin(phi2)))/(l1^2*l2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2));
	ddphi2 = (3*(0 - 6*M*l2*m2*cos(phi1 - phi2) + ...
        0 - 0 - 0 + ...
        6*dphi1^2*l1^2*l2*m2^2*sin(phi1 - phi2) - 6*g*l1*l2*m2^2*sin(phi2) + ...
       0 + 3*dphi2^2*l1*l2^2*m2^2*cos(phi1 - phi2)*sin(phi1 - phi2) ...
        + 2*dphi1^2*l1^2*l2*m1*m2*sin(phi1 - phi2) + 6*g*l1*l2*m2^2*cos(phi1 - phi2)*sin(phi1) ...
        - 2*g*l1*l2*m1*m2*sin(phi2) + 3*g*l1*l2*m1*m2*cos(phi1 - phi2)*sin(phi1)))/(l1*l2^2*m2*(4*m1 + ...
        12*m2 - 9*m2*cos(phi1 - phi2)^2));
	
	

	% Ableitungen zuweisen
	block.Derivatives.Data = [dphi1; ddphi1; dphi2; ddphi2 ];
	
end


% *************************************************************************
% Aufräumen (wenn nötig)
% *************************************************************************
function Terminate(block)
end
