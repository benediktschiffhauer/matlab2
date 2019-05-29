for i = 1 : m
    P = reshape(vP(i,:), 4, 4);
    [~, B, ~, ~] = linearisierung_XU(stTraj.mX(1:4,i), stTraj.vU(i));
    mK(:,i) = R \ (B') * P;
end