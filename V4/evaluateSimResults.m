clear
clc

files = {'simout_1.mat', 'simout_2.mat', 'simout_3.mat', 'simout_4.mat',...
    'simout_5.mat', 'simout_0.mat'};


poles = {-4:-1, -9:-6, -13:-10, -24:-21, -64:-61, 0};


select = [1 2 3 4 5 6];
strLegend = {};
styles = {'k', 'g--', 'r:', 'b-.', 'y', 'g:'};

for i = select
    sim = load(files{i});
    t = sim.vT;
    u = sim.vU;
    x = sim.mX;
    x_obs = sim.mXobs;
    e_obs = x - x_obs;
    strLegend(end+1) = {num2str(poles{i})};
    
    
    
    figure(1);
    subplot(3,1,1);
    plot(t,u,styles{i});
    xlabel('$t$ in s','Interpreter','latex');
    ylabel('$M$ in Nm','Interpreter','latex');
    hold on;
    grid on;
    
    subplot(3,1,2);
    plot(t,x(:,1),styles{i});
    xlabel('$t$ in s','Interpreter','latex');
    ylabel('$\varphi_1$ in rad','Interpreter','latex');
    hold on;
    grid on;
    
    last1 = subplot(3,1,3);
    plot(t,x(:,3),styles{i});
    xlabel('$t$ in s','Interpreter','latex');
    ylabel('$\varphi_2$ in rad','Interpreter','latex');
    hold on;
    grid on;
    
    
    figure(2);
    subplot(4,1,1);
    plot(t,e_obs(:,1),styles{i});
    xlabel('$t$ in s','Interpreter','latex');
    ylabel('$\varphi_1$ in rad','Interpreter','latex');
    hold on;
    grid on;
    
    subplot(4,1,2);
    plot(t,e_obs(:,2),styles{i});
    xlabel('$t$ in s','Interpreter','latex');
    ylabel('$\dot{\varphi}_1$ in rad/s','Interpreter','latex');
    hold on;
    grid on;
    
    subplot(4,1,3);
    plot(t,e_obs(:,3),styles{i});
    xlabel('$t$ in s','Interpreter','latex');
    ylabel('$\varphi_2$ in rad','Interpreter','latex');
    hold on;
    grid on;
    
    last2 = subplot(4,1,4);
    plot(t,e_obs(:,4),styles{i});
    xlabel('$t$ in s','Interpreter','latex');
    ylabel('$\dot{\varphi}_2$ in rad/s','Interpreter','latex');
    hold on;
    grid on;
end

axes(last1);
legend(strLegend);
axes(last2);
legend(strLegend);