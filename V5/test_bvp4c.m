clear all
% close all
% clc

%% init params
Q = diag([1 1 1 1]);
R = 10;
stPendel = ladePendel();
% T = linspace(1,1.8,9);
T = 1;
[x0, xT] = RandwertproblemStates();
M_max = 1.5;

%% solve
stTraj = berechneTrajektorie( stPendel, Q, R, T(1) );
for i = 2:length(T)
%     pause
    stTraj(end+1) = berechneTrajektorie( stPendel, Q, R, T(i) );
end
vU_max = max(abs(stTraj.vU));
if vU_max > M_max
    warning('Stellgröße verletzt');
    beep();
    disp(strcat('!!! Stellgröße verletzt !!! . . . Ist=',num2str(vU_max)));
else
    disp(strcat('Stellgröße O.K.! Ist=',num2str(vU_max)));
end

pause
%% simulate
disp('--- Started sim');
sim('V3_sim');
disp('. . . Finished sim');


%% plot
style_bvp = '--k';
style_sim = 'b';
show_bc = 0;
show_sat = 0;
xlabels = {'$t$ in $\mathrm{s}$'};
ylabels = {'$\varphi_1$ in $\mathrm{rad}$', '$\dot{\varphi}_1$ in $\mathrm{rad}$', '$\varphi_2$ in $\mathrm{rad}$', '$\dot{\varphi}_2$ in $\mathrm{rad}$', };

figure(1);
tmin = min([stTraj.vT,vInput.time']);
tmax = max([stTraj.vT,vInput.time']);
for i = 1 : 4
    subplot(5,1,i+1);
    if show_bc
        plot(mZustand.time,mZustand.signals.values(:,i),style_sim,stTraj.vT,stTraj.mX(i,:),style_bvp,[tmin tmax],[x0(i) x0(i)],':r',[tmin tmax],[xT(i) xT(i)],':r');
    else
        plot(mZustand.time,mZustand.signals.values(:,i),style_sim,stTraj.vT,stTraj.mX(i,:),style_bvp);
    end
    grid on;
    xlabel(xlabels{1},'Interpreter','latex');
    ylabel(ylabels{i},'Interpreter','latex');
end

% figure(2);
subplot(5,1,1);
if show_sat
    plot(vInput.time,vInput.signals.values,style_sim,stTraj.vT,stTraj.vU,style_bvp,[tmin tmax],-M_max*[1 1],'-.r',[tmin tmax],M_max*[1 1],'-.r');
else
    plot(vInput.time,vInput.signals.values,style_sim,stTraj.vT,stTraj.vU,style_bvp);
end
grid on;
xlabel(xlabels{1},'Interpreter','latex');
ylabel('$M$ in $\mathrm{Nm}$','Interpreter','latex');
legend('Simulation','BVP4C');