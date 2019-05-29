function [ controlable ] = checkCtrbHautus( A, B )
%CHECKCTRBKALMAN Summary of this function goes here
%   Detailed explanation goes here

EW = eig(A);
controlable = 1;
n = size(A,1);

for i = 1:length(EW)
    rang = rank([EW(i)*eye(n) - A, B]);
    if(rang ~= n)
        controlable = 0;
    end
end

end

