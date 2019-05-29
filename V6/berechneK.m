function [ vTK, mK ] = berechneK( stTraj, Q, R )

clear persistent;
m = length(stTraj.vT);
n = size(stTraj.mX,1);

P = zeros(n,n,m);

%% boundary
[A, B, ~, ~] = linearisierung_XU(stTraj.mX(1:4,:), stTraj.vU(:));
P_T = care(A(:,:,end),B(:,end), Q, R, zeros(size(B(:,end))), eye(n));

%% solve riccati
RiccatiDGL([],[],stTraj,Q,R);
[vTK, vP] = ode45(@RiccatiDGL, fliplr(stTraj.vT)', P_T );


%% get K
vP = flipud(vP);
vTK = flipud(vTK);
mK = zeros(n,m);
for i = 1 : m
    P = reshape(vP(i,:), 4, 4);
    mK(:,i) = R \ (B(:,i)') * P;
end

end