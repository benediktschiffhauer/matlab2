function [ controlable ] = checkCtrbKalman( A, B )
%CHECKCTRBKALMAN Summary of this function goes here
%   Detailed explanation goes here

controlable = 0;
n = size(A);
n = n(1);
m = size(B);
m = m(2);

SS = zeros(n,n*m);

for i = 0:(n-1)
    SS(1:n,(i*m+1): ((i+1)*m)) = A^i * B;
end

if(rank(SS) == n)
    controlable = 1;
end

end

