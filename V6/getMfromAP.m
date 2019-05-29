function M_AP = getMfromAP( x_AP )
phi1 = x_AP(1);
phi2 = x_AP(2);
M_AP = (9*sin(2*phi1 - 2*phi2)*dphi1^2)/2000 + (3*sin(phi1 - phi2)*dphi2^2)/500 + (8829*sin(phi1 - 2*phi2))/40000 + (26487*sin(phi1))/40000;
end

