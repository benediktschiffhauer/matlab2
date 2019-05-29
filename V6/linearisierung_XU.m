function [ A, B, C, D ] = linearisierung_XU( x, u )

persistent dfdx dfdu dhdx dhdu phi1 phi2 dphi1 dphi2 M x_sym u_sym;

if isempty(dfdx)

    [f, h] = nonlinear_model();
    
    syms phi1 phi2 dphi1 dphi2 M real;
    x_sym = [phi1, dphi1, phi2, dphi2];
    u_sym = M;

    dfdx = jacobian(f, x_sym);
    dfdu = jacobian(f, u_sym);
    dhdx = jacobian(h, x_sym);
    dhdu = jacobian(h, u_sym);
end

n = length(u);

A = zeros(4,4,n);
B = zeros(4,n);
C = zeros(2,4,n);
D = zeros(2,n);
x = reshape(x,4,n);

for i = 1 : n
%     if size(x,2) == 1
%         x_i = x;
%     else
        x_i = x(:,i);
%     end
    phi1 = x_i(1);
    dphi1 = x_i(2);
    phi2 = x_i(3);
    dphi2 = x_i(4);
    M = u(i);
    A(1:4,1:4,i) = eval(dfdx);
    B(1:4,i) = eval(dfdu);
    C(1:2,1:4,i) = eval(dhdx);
    D(1:2,i) = eval(dhdu);
end


end

