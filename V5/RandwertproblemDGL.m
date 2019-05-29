function dxdt = RandwertproblemDGL(t, x, stPendel, Q, R)
	% t:			Zeit
	% x:			Zustände x(1) und x(2)
	% Pendeldaten:	Pendeldaten
    % Q:            Gewichtungsmatrix für Zustände
    % R:            Gewichtung für Stellgröße

    % l1,l2,m1,m2,g,Rp1,Rp2,q1,q2,q3,q4,sym_R
		l1 = stPendel.l1;
        l2 = stPendel.l2;
        m1 = stPendel.m1;
        m2 = stPendel.m2;
		g = stPendel.g;
        Rp1 = stPendel.Rp1;
        Rp2 = stPendel.Rp2;
        q1 = Q(1,1);
        q2 = Q(2,2);
        q3 = Q(3,3);
        q4 = Q(4,4);
        sym_R = R;
		dxdt = 0;

	% Differentialgleichung 8ter Ordnung, 
    % x1-x4: Originale Zustände,
    % x5-x8: Lagrange-Multiplikatoren


    phi1 = x(1);
    dphi1 = x(2);
    phi2 = x(3);
    dphi2 = x(4);
    lambda1 = x(5);
    lambda2 = x(6);
    lambda3 = x(7);
    lambda4 = x(8);

    
    dx1 = dphi1;
    dx2 = -(3*(4*l2*((12*lambda2)/(l1^2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (18*lambda4*cos(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2))) + 4*Rp1*dphi1*l2 + 6*Rp2*dphi1*l1*cos(phi1 - phi2) - 6*Rp2*dphi2*l1*cos(phi1 - phi2) + 2*dphi2^2*l1*l2^2*m2*sin(phi1 - phi2) + 2*g*l1*l2*m1*sin(phi1) + 4*g*l1*l2*m2*sin(phi1) + 3*dphi1^2*l1^2*l2*m2*cos(phi1 - phi2)*sin(phi1 - phi2) - 3*g*l1*l2*m2*cos(phi1 - phi2)*sin(phi2)))/(l1^2*l2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2));
    dx3 = dphi2;
    dx4 = (3*(6*l2*m2*cos(phi1 - phi2)*((12*lambda2)/(l1^2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (18*lambda4*cos(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2))) + 4*Rp2*dphi1*l1*m1 + 12*Rp2*dphi1*l1*m2 - 4*Rp2*dphi2*l1*m1 - 12*Rp2*dphi2*l1*m2 + 6*dphi1^2*l1^2*l2*m2^2*sin(phi1 - phi2) - 6*g*l1*l2*m2^2*sin(phi2) + 6*Rp1*dphi1*l2*m2*cos(phi1 - phi2) + 3*dphi2^2*l1*l2^2*m2^2*cos(phi1 - phi2)*sin(phi1 - phi2) + 2*dphi1^2*l1^2*l2*m1*m2*sin(phi1 - phi2) + 6*g*l1*l2*m2^2*cos(phi1 - phi2)*sin(phi1) - 2*g*l1*l2*m1*m2*sin(phi2) + 3*g*l1*l2*m1*m2*cos(phi1 - phi2)*sin(phi1)))/(l1*l2^2*m2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2));
    dx5 = lambda2*((3*(4*l2*((18*lambda4*sin(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (216*lambda2*m2*cos(phi1 - phi2)*sin(phi1 - phi2))/(l1^2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)^2) + (324*lambda4*m2*cos(phi1 - phi2)^2*sin(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)^2)) - 6*Rp2*dphi1*l1*sin(phi1 - phi2) + 6*Rp2*dphi2*l1*sin(phi1 - phi2) + 3*dphi1^2*l1^2*l2*m2*cos(phi1 - phi2)^2 - 3*dphi1^2*l1^2*l2*m2*sin(phi1 - phi2)^2 + 2*dphi2^2*l1*l2^2*m2*cos(phi1 - phi2) + 2*g*l1*l2*m1*cos(phi1) + 4*g*l1*l2*m2*cos(phi1) + 3*g*l1*l2*m2*sin(phi1 - phi2)*sin(phi2)))/(l1^2*l2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (54*m2*cos(phi1 - phi2)*sin(phi1 - phi2)*(4*l2*((12*lambda2)/(l1^2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (18*lambda4*cos(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2))) + 4*Rp1*dphi1*l2 + 6*Rp2*dphi1*l1*cos(phi1 - phi2) - 6*Rp2*dphi2*l1*cos(phi1 - phi2) + 2*dphi2^2*l1*l2^2*m2*sin(phi1 - phi2) + 2*g*l1*l2*m1*sin(phi1) + 4*g*l1*l2*m2*sin(phi1) + 3*dphi1^2*l1^2*l2*m2*cos(phi1 - phi2)*sin(phi1 - phi2) - 3*g*l1*l2*m2*cos(phi1 - phi2)*sin(phi2)))/(l1^2*l2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)^2)) - phi1*q1 - lambda4*((3*(6*l2*m2*cos(phi1 - phi2)*((18*lambda4*sin(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (216*lambda2*m2*cos(phi1 - phi2)*sin(phi1 - phi2))/(l1^2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)^2) + (324*lambda4*m2*cos(phi1 - phi2)^2*sin(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)^2)) - 6*l2*m2*sin(phi1 - phi2)*((12*lambda2)/(l1^2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (18*lambda4*cos(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2))) - 6*Rp1*dphi1*l2*m2*sin(phi1 - phi2) + 6*dphi1^2*l1^2*l2*m2^2*cos(phi1 - phi2) + 3*dphi2^2*l1*l2^2*m2^2*cos(phi1 - phi2)^2 - 3*dphi2^2*l1*l2^2*m2^2*sin(phi1 - phi2)^2 + 2*dphi1^2*l1^2*l2*m1*m2*cos(phi1 - phi2) + 6*g*l1*l2*m2^2*cos(phi1 - phi2)*cos(phi1) - 6*g*l1*l2*m2^2*sin(phi1 - phi2)*sin(phi1) + 3*g*l1*l2*m1*m2*cos(phi1 - phi2)*cos(phi1) - 3*g*l1*l2*m1*m2*sin(phi1 - phi2)*sin(phi1)))/(l1*l2^2*m2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (54*cos(phi1 - phi2)*sin(phi1 - phi2)*(6*l2*m2*cos(phi1 - phi2)*((12*lambda2)/(l1^2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (18*lambda4*cos(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2))) + 4*Rp2*dphi1*l1*m1 + 12*Rp2*dphi1*l1*m2 - 4*Rp2*dphi2*l1*m1 - 12*Rp2*dphi2*l1*m2 + 6*dphi1^2*l1^2*l2*m2^2*sin(phi1 - phi2) - 6*g*l1*l2*m2^2*sin(phi2) + 6*Rp1*dphi1*l2*m2*cos(phi1 - phi2) + 3*dphi2^2*l1*l2^2*m2^2*cos(phi1 - phi2)*sin(phi1 - phi2) + 2*dphi1^2*l1^2*l2*m1*m2*sin(phi1 - phi2) + 6*g*l1*l2*m2^2*cos(phi1 - phi2)*sin(phi1) - 2*g*l1*l2*m1*m2*sin(phi2) + 3*g*l1*l2*m1*m2*cos(phi1 - phi2)*sin(phi1)))/(l1*l2^2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)^2));
    dx6 = (3*lambda2*(6*dphi1*l2*m2*cos(phi1 - phi2)*sin(phi1 - phi2)*l1^2 + 6*Rp2*cos(phi1 - phi2)*l1 + 4*Rp1*l2))/(l1^2*l2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - dphi1*q2 - lambda1 - (3*lambda4*(12*dphi1*l2*sin(phi1 - phi2)*l1^2*m2^2 + 4*dphi1*l2*m1*sin(phi1 - phi2)*l1^2*m2 + 12*Rp2*l1*m2 + 4*Rp2*m1*l1 + 6*Rp1*l2*cos(phi1 - phi2)*m2))/(l1*l2^2*m2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2));
    dx7 = lambda4*((3*(6*l2*m2*cos(phi1 - phi2)*((18*lambda4*sin(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (216*lambda2*m2*cos(phi1 - phi2)*sin(phi1 - phi2))/(l1^2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)^2) + (324*lambda4*m2*cos(phi1 - phi2)^2*sin(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)^2)) - 6*l2*m2*sin(phi1 - phi2)*((12*lambda2)/(l1^2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (18*lambda4*cos(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2))) - 6*Rp1*dphi1*l2*m2*sin(phi1 - phi2) + 6*dphi1^2*l1^2*l2*m2^2*cos(phi1 - phi2) + 6*g*l1*l2*m2^2*cos(phi2) + 3*dphi2^2*l1*l2^2*m2^2*cos(phi1 - phi2)^2 - 3*dphi2^2*l1*l2^2*m2^2*sin(phi1 - phi2)^2 + 2*dphi1^2*l1^2*l2*m1*m2*cos(phi1 - phi2) + 2*g*l1*l2*m1*m2*cos(phi2) - 6*g*l1*l2*m2^2*sin(phi1 - phi2)*sin(phi1) - 3*g*l1*l2*m1*m2*sin(phi1 - phi2)*sin(phi1)))/(l1*l2^2*m2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (54*cos(phi1 - phi2)*sin(phi1 - phi2)*(6*l2*m2*cos(phi1 - phi2)*((12*lambda2)/(l1^2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (18*lambda4*cos(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2))) + 4*Rp2*dphi1*l1*m1 + 12*Rp2*dphi1*l1*m2 - 4*Rp2*dphi2*l1*m1 - 12*Rp2*dphi2*l1*m2 + 6*dphi1^2*l1^2*l2*m2^2*sin(phi1 - phi2) - 6*g*l1*l2*m2^2*sin(phi2) + 6*Rp1*dphi1*l2*m2*cos(phi1 - phi2) + 3*dphi2^2*l1*l2^2*m2^2*cos(phi1 - phi2)*sin(phi1 - phi2) + 2*dphi1^2*l1^2*l2*m1*m2*sin(phi1 - phi2) + 6*g*l1*l2*m2^2*cos(phi1 - phi2)*sin(phi1) - 2*g*l1*l2*m1*m2*sin(phi2) + 3*g*l1*l2*m1*m2*cos(phi1 - phi2)*sin(phi1)))/(l1*l2^2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)^2)) - phi2*q3 - lambda2*((3*(4*l2*((18*lambda4*sin(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (216*lambda2*m2*cos(phi1 - phi2)*sin(phi1 - phi2))/(l1^2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)^2) + (324*lambda4*m2*cos(phi1 - phi2)^2*sin(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)^2)) - 6*Rp2*dphi1*l1*sin(phi1 - phi2) + 6*Rp2*dphi2*l1*sin(phi1 - phi2) + 3*dphi1^2*l1^2*l2*m2*cos(phi1 - phi2)^2 - 3*dphi1^2*l1^2*l2*m2*sin(phi1 - phi2)^2 + 2*dphi2^2*l1*l2^2*m2*cos(phi1 - phi2) + 3*g*l1*l2*m2*sin(phi1 - phi2)*sin(phi2) + 3*g*l1*l2*m2*cos(phi1 - phi2)*cos(phi2)))/(l1^2*l2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (54*m2*cos(phi1 - phi2)*sin(phi1 - phi2)*(4*l2*((12*lambda2)/(l1^2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - (18*lambda4*cos(phi1 - phi2))/(l1*l2*sym_R*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2))) + 4*Rp1*dphi1*l2 + 6*Rp2*dphi1*l1*cos(phi1 - phi2) - 6*Rp2*dphi2*l1*cos(phi1 - phi2) + 2*dphi2^2*l1*l2^2*m2*sin(phi1 - phi2) + 2*g*l1*l2*m1*sin(phi1) + 4*g*l1*l2*m2*sin(phi1) + 3*dphi1^2*l1^2*l2*m2*cos(phi1 - phi2)*sin(phi1 - phi2) - 3*g*l1*l2*m2*cos(phi1 - phi2)*sin(phi2)))/(l1^2*l2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)^2));
    dx8 = (3*lambda4*(- 6*dphi2*l1*cos(phi1 - phi2)*sin(phi1 - phi2)*l2^2*m2^2 + 12*Rp2*l1*m2 + 4*Rp2*l1*m1))/(l1*l2^2*m2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - dphi2*q4 - (3*lambda2*(- 4*dphi2*l1*m2*sin(phi1 - phi2)*l2^2 + 6*Rp2*l1*cos(phi1 - phi2)))/(l1^2*l2*(4*m1 + 12*m2 - 9*m2*cos(phi1 - phi2)^2)) - lambda3;
    
    dxdt = [dx1;dx2;dx3;dx4;dx5;dx6;dx7;dx8]; 




end % function RandwertproblemDGL
