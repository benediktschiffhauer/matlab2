function sFunModell(block)

	setup(block);

end


% *************************************************************************
% Initialisierung
% *************************************************************************
function setup(block)

	% Anzahl der Ein-/Ausgänge
	block.NumInputPorts  = 1;
	block.NumOutputPorts = 2;

	% Eigenschaften des Eingangs
	block.InputPort(1).Dimensions	= 1;
	block.InputPort(1).DatatypeID	= 0;  % double
	block.InputPort(1).Complexity	= 'Real';
	block.InputPort(1).DirectFeedthrough = false;
	block.InputPort(1).SamplingMode = 'Sample';

	% Eigenschaften des 1. Ausgangs
	block.OutputPort(1).Dimensions	= 1;
	block.OutputPort(1).DatatypeID	= 0; % double
	block.OutputPort(1).Complexity	= 'Real';
	block.OutputPort(1).SamplingMode = 'Sample';

	% Eigenschaften des 2. Ausgangs
	block.OutputPort(2).Dimensions	= 1;
	block.OutputPort(2).DatatypeID	= 0; % double
	block.OutputPort(2).Complexity	= 'Real';
	block.OutputPort(2).SamplingMode = 'Sample';
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	
	% Anzahl der Zustände
	block.NumContStates = 4;

	% Anzahl der Parameter
	block.NumDialogPrms = 7;


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

	block.ContStates.Data = [0 0 0 0];
	
end


% *************************************************************************
% Ausgänge berechnen
% *************************************************************************
function Outputs(block)

	% Zustände auslesen
	x		= block.ContStates.Data;
    
    
	block.OutputPort(1).Data = x(1);
	block.OutputPort(2).Data = x(3);

end


% *************************************************************************
% Ableitungen berechnen
% *************************************************************************
function Derivatives(block)

	% Parameter auslesen
	g = block.DialogPrm(1).Data;
	m1 = block.DialogPrm(2).Data;
	m2 = block.DialogPrm(3).Data;
	l1 = block.DialogPrm(4).Data;
	l2 = block.DialogPrm(5).Data;
	RP1 = block.DialogPrm(6).Data;
    RP2 = block.DialogPrm(7).Data;

	% Zustände auslesen
	x		= block.ContStates.Data;
	phi1	= x(1);
	dphi1   = x(2);
	phi2    = x(3);
	dphi2	= x(4);

	% Eingang auslesen
	M = block.InputPort(1).Data(1);

	
	
	% Ableitungen berechnen
	ddphi1 = -(24*RP1*dphi1*l2 - 24*M*l2 + 36*RP2*dphi1*l1*cos(phi1 - phi2) - 36*RP2*dphi2*l1*cos(phi1 - phi2) + 9*g*l1*l2*m2*sin(phi1 - 2*phi2) + 9*dphi1^2*l1^2*l2*m2*sin(2*phi1 - 2*phi2) + 12*dphi2^2*l1*l2^2*m2*sin(phi1 - phi2) + 12*g*l1*l2*m1*sin(phi1) + 15*g*l1*l2*m2*sin(phi1))/(l1^2*l2*(8*m1 + 15*m2 - 9*m2*cos(2*phi1 - 2*phi2)));
    ddphi2 = (24*RP2*dphi1*l1*m1 - 36*M*l2*m2*cos(phi1 - phi2) + 72*RP2*dphi1*l1*m2 - 24*RP2*dphi2*l1*m1 - 72*RP2*dphi2*l1*m2 + 36*dphi1^2*l1^2*l2*m2^2*sin(phi1 - phi2) - 18*g*l1*l2*m2^2*sin(phi2) + 9*dphi2^2*l1*l2^2*m2^2*sin(2*phi1 - 2*phi2) + 18*g*l1*l2*m2^2*sin(2*phi1 - phi2) + 36*RP1*dphi1*l2*m2*cos(phi1 - phi2) + 12*dphi1^2*l1^2*l2*m1*m2*sin(phi1 - phi2) - 3*g*l1*l2*m1*m2*sin(phi2) + 9*g*l1*l2*m1*m2*sin(2*phi1 - phi2))/(l1*l2^2*m2*(8*m1 + 15*m2 - 9*m2*cos(2*phi1 - 2*phi2)));
	
	

	% Ableitungen zuweisen
	block.Derivatives.Data = [dphi1; ddphi1; dphi2; ddphi2];
	
end


% *************************************************************************
% Aufräumen (wenn nötig)
% *************************************************************************
function Terminate(block)
end
