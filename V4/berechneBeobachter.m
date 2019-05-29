function L = berechneBeobachter( A, C, poleBeobachter )
%BERECHNEBEOBACHTER berechnet einen Luenberger-Beobachter mit den
%angegebenen Polen für das System <A,C>.
AT = A';
BT = C';

L = [];

beobachtbar = checkObsvKalman(A,C);
vernuenftigePole = (sum(poleBeobachter<0) == length(poleBeobachter));

if size(A,1) ~= length(poleBeobachter)
    vernuenftigePole = 0;
end

if beobachtbar && vernuenftigePole
    LT = place(AT,BT,poleBeobachter);
    L = LT';
end

end

