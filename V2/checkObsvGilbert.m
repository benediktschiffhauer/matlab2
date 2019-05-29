function [ observable ] = checkCtrbKalman( A, C )
%CHECKCTRBKALMAN Summary of this function goes here
%   Detailed explanation goes here

observable = 0;

n = size(A);
n = n(1);
r = size(C);
r = r(1);
B = zeros(n,1);
D = zeros(r,1);

[AD, BD, CD, DD] = diagonalForm(A,B,C,D);
if(isempty(AD))
    observable = 0;
    warning('A nicht diagonalisierbar');
elseif(all(CD))
    observable = 1;
end

end

