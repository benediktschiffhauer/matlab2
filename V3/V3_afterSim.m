hFig = figure(1);
t = [min(mZustand.time),max(mZustand.time)];

out = strcat('maximales Moment: ',num2str(max(abs(vInput.signals.values))),'Nm');
disp(out);
hAxes = [];

hAx1 = subplot(5,1,1);
plot(vInput.time,vInput.signals.values,t,M_AP*[1 1]);
xlabel('$t$ in s','Interpreter','latex');
ylabel('$M$ in Nm','Interpreter','latex');
grid on;
legend('Ist','Soll');

hAx2 = subplot(5,1,2);
plot(mZustand.time,mZustand.signals.values(:,1),t,x_AP(1)*[1 1]);
xlabel('$t$ in s','Interpreter','latex');
ylabel('$\varphi_1$ in rad','Interpreter','latex');
grid on;

hAx3 = subplot(5,1,3);
plot(mZustand.time,mZustand.signals.values(:,2),t,x_AP(2)*[1 1]);
xlabel('$t$ in s','Interpreter','latex');
ylabel('$\dot{\varphi}_1$ in rad/s','Interpreter','latex');
grid on;

hAx4 = subplot(5,1,4);
plot(mZustand.time,mZustand.signals.values(:,3),t,x_AP(3)*[1 1]);
xlabel('$t$ in s','Interpreter','latex');
ylabel('$\varphi_2$ in rad','Interpreter','latex');
grid on;

hAx5 = subplot(5,1,5);
plot(mZustand.time,mZustand.signals.values(:,4),t,x_AP(4)*[1 1]);
xlabel('$t$ in s','Interpreter','latex');
ylabel('$\dot{\varphi}_2$ in rad/s','Interpreter','latex');
grid on;

linkaxes([hAx1, hAx2, hAx3, hAx4, hAx5],'x');