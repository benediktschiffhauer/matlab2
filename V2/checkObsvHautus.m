function [ observable ] = checkObsvHautus( A, C )
%CHECKCTRBKALMAN Summary of this function goes here
%   Detailed explanation goes here

EW = eig(A);
observable = 1;
n = size(A,1);

for i = 1:length(EW)
    rang = rank([EW(i)*eye(n) - A; C]);
    if(rang ~= n)
        observable = 0;
    end
end

end

