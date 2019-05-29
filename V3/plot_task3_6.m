clear
% close all

n = 100;

ap1 = open('simAP1.mat'); ap1 = ap1.simAP1;
ap2 = open('simAP2.mat'); ap2 = ap2.simAP2;
a = 'b-.';
b = 'r:';
c = 'g--';
useGrid = 'on';
linkAPs = 0;

% t1 = linspace(min(ap1.vT1),max(ap1.vT1),n);
% t2 = linspace(min(ap2.vT1),max(ap2.vT1),n);

figure(1);
hax11 = subplot(3,1,1);
plot(ap1.vT1,ap1.vM1,a,ap1.vT2,ap1.vM2,b,ap1.vT3,ap1.vM3,c);
title('Simulation um Arbeitspunkt 1: $\mathbf{x}_\mathrm{AP} = [\pi/3, 0, 0, 0]$','Interpreter','latex','FontSize',16);
xlabel('$t$ in $\mathrm{s}$','Interpreter','latex');
ylabel('$M$ in $\mathrm{rad}$','Interpreter','latex');
legend('a','b','c');
axis([min(ap1.vT1) max(ap1.vT1) -2 2]);
grid(useGrid);
hax12 = subplot(3,1,2);
plot(ap1.vT1,ap1.mX1(:,1),a,ap1.vT2,ap1.mX2(:,1),b,ap1.vT3,ap1.mX3(:,1),c);
xlabel('$t$ in $\mathrm{s}$','Interpreter','latex');
ylabel('$\varphi_1$ in $\mathrm{rad}$','Interpreter','latex');
legend('a','b','c');
grid(useGrid);
hax13 = subplot(3,1,3);
plot(ap1.vT1,ap1.mX1(:,3),a,ap1.vT2,ap1.mX2(:,3),b,ap1.vT3,ap1.mX3(:,3),c);
xlabel('$t$ in $\mathrm{s}$','Interpreter','latex');
ylabel('$\varphi_2$ in $\mathrm{rad}$','Interpreter','latex');
legend('a','b','c');
grid(useGrid);
linkaxes([hax11, hax12, hax13],'x');

figure(2);
hax21 = subplot(3,1,1);
plot(ap2.vT1,ap2.vM1,a,ap2.vT2,ap2.vM2,b,ap2.vT3,ap2.vM3,c);
title('Simulation um Arbeitspunkt 2: $\mathbf{x}_\mathrm{AP} = [\pi/3, 0, \pi, 0]$','Interpreter','latex','FontSize',16);
xlabel('$t$ in $\mathrm{s}$','Interpreter','latex');
ylabel('$M$ in $\mathrm{rad}$','Interpreter','latex');
legend('a','b','c');
axis([min(ap1.vT1) max(ap1.vT1) -2 2]);
grid(useGrid);
hax22 = subplot(3,1,2);
plot(ap2.vT1,ap2.mX1(:,1),a,ap2.vT2,ap2.mX2(:,1),b,ap2.vT3,ap2.mX3(:,1),c);
xlabel('$t$ in $\mathrm{s}$','Interpreter','latex');
ylabel('$\varphi_1$ in $\mathrm{rad}$','Interpreter','latex');
legend('a','b','c');
grid(useGrid);
hax23 = subplot(3,1,3);
plot(ap2.vT1,ap2.mX1(:,3),a,ap2.vT2,ap2.mX2(:,3),b,ap2.vT3,ap2.mX3(:,3),c);
xlabel('$t$ in $\mathrm{s}$','Interpreter','latex');
ylabel('$\varphi_2$ in $\mathrm{rad}$','Interpreter','latex');
legend('a','b','c');
grid(useGrid);
linkaxes([hax21, hax22, hax23],'x');

if linkAPs
    linkaxes([hax11, hax12, hax13, hax21, hax22, hax23],'x');
end