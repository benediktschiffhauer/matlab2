close all
clc

max_index = 10;

%% import data
disp('Import data');
not_done = 1;
i = 1;
while(not_done)
    try
        if i == 1
            data = open(strcat('simout_',num2str(i),'.mat'));
        else
            data(end+1) = open(strcat('simout_',num2str(i),'.mat'));
        end
    catch
        not_done = 0;
    end
    i = i+1;
end

for i = 1:length(data)
    if i == 1
        names = {data(i).sim.info};
    else
        names{end+1} = {data(i).sim.info};
    end
end
names = names';

select = [10 11];
styles = {'-b','--r','','','','','','','','',''};
legends = {'1','2','','','','','','','','T_M = 1ms','T_M = 10ms'};
use_grid = 'on';
lims = {[],[],[],[],[]};
ylab = {'$u$ in Nm','$\varphi_1$ in rad','$\dot{\varphi}_1$ in rad/s','$\varphi_2$ in rad','$\dot{\varphi}_2$ in rad/s',};

hFig = figure(1);
for i = select
    figure(hFig);
    j = 1;
    subplot(5,1,j);
    hold on;
    plot(data(i).sim.vInput.time,data(i).sim.vInput.signals.values(:,1),styles{i});
    grid(use_grid);
    axis(lims{j});
    xlabel('$t$ in s','Interpreter','latex');
    ylabel(ylab{j},'Interpreter','latex');
    for j = 2:5
        subplot(5,1,j);
        hold on;
        plot(data(i).sim.mZustand.time,data(i).sim.mZustand.signals.values(:,j-1),styles{i});
        grid(use_grid);
        axis(lims{j});
        xlabel('$t$ in s','Interpreter','latex');
        ylabel(ylab{j},'Interpreter','latex');
    end
end
figure(hFig);
subplot(5,1,1);
legend(legends{select},'Interpreter','latex');