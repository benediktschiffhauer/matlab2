function [ dfdux ] = dfdu( x )

phi1  = x(1,:)';
dphi1 = x(2,:)';
phi2  = x(3,:)';
dphi2 = x(4,:)';

% dfdux = [ 0;
%     -300/((27*cos(phi1 - phi2)^2)/10 - 24/5);
% 	0;
% 	(450*cos(phi1 - phi2))/((27*cos(phi1 - phi2)^2)/10 - 24/5)
%     ];
dfdux = [zeros(size(phi1)),...
    -2000./(9*cos(2*phi1(:) - 2*phi2(:)) - 23),...
    zeros(size(phi1)),...
    (3000*cos(phi1(:) - phi2(:)))./(9*cos(2*phi1(:) - 2*phi2(:)) - 23)]';
end

