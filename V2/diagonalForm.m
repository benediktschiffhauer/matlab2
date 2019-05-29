function [ AD, BD, CD, DD ] = diagonalForm( A, B, C, D )
%DIAGONALFORM bringt das System [A, B, C, D] in Diagonalform.

AD = [];
BD = [];
CD = [];
DD = [];

roundIt = 0;

[T, EW] = eig(A);

if(rank(T) == length(A))
    AD = T\A*T;
    BD = T\B;
    CD = C*T;
    DD = D;
    if(roundIt)
        AD = round(AD,12);
        BD = round(BD,12);
        CD = round(CD,12);
        DD = round(DD,12);
    end

else
    warning('Matrix nicht diagonalisierbar!');
end


end

