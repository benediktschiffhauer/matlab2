function [ controlable ] = checkCtrbKalman( A, B )
%CHECKCTRBKALMAN Summary of this function goes here
%   Detailed explanation goes here

controlable = 0;
nonzero = 0;
n = size(A);
n = n(1);
m = size(B);
m = m(2);
C = zeros(1,n);
D = zeros(1,m);

[AD, BD, CD, DD] = diagonalForm(A,B,C,D);
if(isempty(AD))
    controlable = 0;
    warning('A nicht diagonalisierbar');
elseif(all(BD))
    controlable = 1;
end

% if(all(diag(AD)))
%     nonzero = 1;
%     EW = eig(A);
%     uniques = unique(EW);
%     p = n - length(unique(EW)) + 1;
%     amount = zeros(size(uniques));
%     for i = 1:size(uniques)
%         amount(i) = length(find(EW == uniques(i)));
%     end
%     
% end

end

