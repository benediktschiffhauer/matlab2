function [ observable ] = checkObsvKalman( A, C )
%CHECKCTRBKALMAN Summary of this function goes here
%   Detailed explanation goes here

observable = 0;
n = size(A);
n = n(1);
r = size(C);
r = r(1);

SB = zeros(n*r,n);

for i = 0:(n-1)
    SB((i*r+1): ((i+1)*r),1:n) = C * A^i;
end

if(rank(SB) == n)
    observable = 1;
end

end

