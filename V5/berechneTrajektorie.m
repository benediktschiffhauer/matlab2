function stTraj = berechneTrajektorie( stPendel, Q, R, T )
%BERECHNETRAJEKTORIE 

[x0,xT] = RandwertproblemStates();

%samples
n = 1000;

%initalize output
stTraj.T = [];
stTraj.vT = [];
stTraj.vU = [];
stTraj.mX = [];

%initalizie solinit
solinit.x = linspace(0,T,n);
solinit.y = zeros(8,n);
for i = 1:4
    solinit.y(i,:) = linspace(x0(i),xT(i),n);
end

vT = linspace(0,T,n);

fun = @(t, x) RandwertproblemDGL(t, x, stPendel, Q, R);
bc = @(xa, xb) RandwertproblemRB(xa, xb);
options = bvpset('RelTol',1e-10,'Stats','off');

disp('--- Started bvp4c');
for i = 1:15
%     warning('off', 'MATLAB:bvp4c:RelTolNotMet')
    sol = bvp4c(fun,@RandwertproblemRB,solinit,options);
    solinit = sol;
%     solinit.y = sol.y;
%     disp(num2str(i));
end
disp('. . . Finished bvp4c');
if ~isempty(sol)
    stTraj.T = sol.x(end);
    stTraj.vT = sol.x;
    stTraj.vU = -inv(R)*sum(dfdu(sol.y(1:4,:)).*sol.y(5:8,:),1);
%     [f,~] = nonlinear_model(stPendel); syms M;
%     dfdu_1 = jacobian(f,M);
%     dfdu_t = double(subs(dfdu_1,{'phi1','dphi1','phi2','dphi2'},...
%         {sol.y(1,:), sol.y(2,:), sol.y(3,:), sol.y(4,:)}));
%     stTraj.vU = -inv(R) * sum(dfdu_t .* sol.y(5:8,:));
    stTraj.mX = sol.y(1:4,:);
end
end