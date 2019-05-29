function vPdot = RiccatiDGL(t, vP, stTraj, Q, R)

persistent Q_int R_int stTraj_int;

if nargin == 2
    n = size(stTraj_int.mX,1);
    vT = stTraj_int.vT;
    P = reshape(vP,n,n);
    
    u = interp1(stTraj_int.vT',stTraj_int.vU', t);
    x = interp1(stTraj_int.vT',stTraj_int.mX', t);
    [A,B,~,~] = linearisierung_XU(x,u);
    
    Pdot = P * B * (R_int \ (B')) * P - P*A - (A'*P) - Q_int;
    vPdot = reshape(Pdot,n*n,1);
elseif nargin == 5
    Pdot = [];
    stTraj_int = stTraj;
    Q_int = Q;
    R_int = R;
end

end

