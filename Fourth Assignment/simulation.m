% HW2 Q3 Ruigang Chen &  Ben Sarfati
clear all; close all; clc

%% globals and parameters

global sgn_slip
global mu
sgn_slip = 1;
mu = 0.05;

rez = 0.01;

R = 0.6;
mu = 0.05;

%ODE parameters
tspan = [0 10]; 
dt = 0.001; 
t_eval = tspan(1):dt:tspan(2);

%% Q5

%run
te = [];
wslip = 0;
while isempty(te)
    wslip = wslip+rez;
    X0 = [0; R; 0; 0; 0; 0; 0; wslip];  %  [x; y; theta; phi; dx; dy; dtheta; dphi];
    options = odeset('RelTol', 1e-8, 'AbsTol', 1e-8,'Events',@events_stick);         
    [t,X,te,ye,ie] = ode45(@sys_stick, t_eval, X0, options); 
end
w0 = 0.9*wslip;
X0 = [0; R; 0; 0; 0; 0; 0; w0];  %  [x; y; theta; phi; dx; dy; dtheta; dphi];
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-8,'Events',@events_stick);         
[t,X,te,ye,ie] = ode45(@sys_stick, t_eval, X0, options); 
Lambda = zeros(length(t),2);
for i = 1:length(t)
    [~,Lambda(i,1:2)] = dyn_sol_stick(X(i,1:4)',X(i,5:8)',t(i));
end

%label
th = X(:,3);
ph = X(:,4);
lambdan = Lambda(:,2);
lambdat = Lambda(:,1);

%plot (a)
figure;
h1 = plot(t,th*180/pi,'LineWidth',2); hold on
h2 = plot(t,ph*180/pi,'LineWidth',2);
% plot(te,the*180/pi,'.','Color',h1.Color,'MarkerSize',25)
% plot(te,phe*180/pi,'.','Color',h2.Color,'MarkerSize',25)
set(gcf,'color','w');
title('Angles vs. Time; $0.9\omega_{slip}$','fontsize',20,'Interpreter','latex')
xlabel('Time [s]', 'Interpreter', 'latex', 'fontsize', 20);
ylabel('[$^{\circ}$]', 'Interpreter', 'latex', 'fontsize', 30);
legend('$\theta $','$\phi $','Interpreter','latex','fontsize',30,'location','ne')
xlim(tspan)
grid on;
% saveas(gcf, 'q5astick.png');

%plot (c)
figure;
plot(t,lambdan,'LineWidth',2);
set(gcf,'color','w');
title('Normal Force vs. Time; $0.9\omega_{slip}$','fontsize',20,'Interpreter','latex')
xlabel('Time [s]', 'Interpreter', 'latex', 'fontsize', 20);
ylabel('$\lambda_n$ [N]', 'Interpreter', 'latex', 'fontsize', 30);
xlim(tspan)
grid on;
% saveas(gcf, 'q5cstick.png');

%plot (d)
figure;
plot(t,lambdat./lambdan,'LineWidth',2);
set(gcf,'color','w');
title('Force ratio vs. Time; $0.9\omega_{slip}$','fontsize',20,'Interpreter','latex')
xlabel('Time [s]', 'Interpreter', 'latex', 'fontsize', 20);
ylabel('$\frac{\lambda_t}{\lambda_n}$', 'Interpreter', 'latex', 'fontsize', 30);
xlim(tspan)
grid on;
yline(mu)
yline(-mu)
legend('ratio','ratio limits','fontsize',30,'location','ne')
% saveas(gcf, 'q5dstick.png');

w0 = wslip;
X0 = [0; R; 0; 0; 0; 0; 0; w0];  %  [x; y; theta; phi; dx; dy; dtheta; dphi];
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-8,'Events',@events_stick);         
[t,X,te,ye,ie] = ode45(@sys_stick, t_eval, X0, options); 
Lambda = zeros(length(t),2);
for i = 1:length(t)
    [~,Lambda(i,1:2)] = dyn_sol_stick(X(i,1:4)',X(i,5:8)',t(i));
end

%label
th = X(:,3);
the = ye(3);
ph = X(:,4);
phe = ye(4);
lambdan = Lambda(:,2);
lambdat = Lambda(:,1);

%plot (a)
figure;
h1 = plot(t,th*180/pi,'LineWidth',2); hold on
h2 = plot(t,ph*180/pi,'LineWidth',2);
plot(te,the*180/pi,'.','Color',h1.Color,'MarkerSize',25)
plot(te,phe*180/pi,'.','Color',h2.Color,'MarkerSize',25)
set(gcf,'color','w');
title('Angles vs. Time; $\omega_{slip}$','fontsize',20,'Interpreter','latex')
xlabel('Time [s]', 'Interpreter', 'latex', 'fontsize', 20);
ylabel('[$^{\circ}$]', 'Interpreter', 'latex', 'fontsize', 30);
legend('$\theta $','$\phi $','$\theta_{slip} $','$\phi_{slip} $','Interpreter','latex','fontsize',30,'location','ne')
xlim(tspan)
grid on;
% saveas(gcf, 'q5aslip.png');

%plot (c)
figure;
plot(t,lambdan,'LineWidth',2);
set(gcf,'color','w');
title('Normal Force vs. Time; $\omega_{slip}$','fontsize',20,'Interpreter','latex')
xlabel('Time [s]', 'Interpreter', 'latex', 'fontsize', 20);
ylabel('$\lambda_n$ [N]', 'Interpreter', 'latex', 'fontsize', 30);
xlim(tspan)
grid on;
% saveas(gcf, 'q5cslip.png');

%plot (d)
figure;
plot(t,lambdat./lambdan,'LineWidth',2);
set(gcf,'color','w');
title('Force ratio vs. Time; $\omega_{slip}$','fontsize',20,'Interpreter','latex')
xlabel('Time [s]', 'Interpreter', 'latex', 'fontsize', 20);
ylabel('$\frac{\lambda_t}{\lambda_n}$', 'Interpreter', 'latex', 'fontsize', 30);
xlim(tspan)
grid on;
yline(mu)
yline(-mu)
legend('ratio','ratio limits','fontsize',30,'location','ne')
% saveas(gcf, 'q5dslip.png');

% %plot (b)
% figure;
% h1 = plot(t,vt,'LineWidth',2);
% set(gcf,'color','w');
% title('Slip Velocity vs. Time; $0.9\omega_{slip}$','fontsize',20,'Interpreter','latex')
% xlabel('Time [s]', 'Interpreter', 'latex', 'fontsize', 20);
% ylabel('[$V_t$]', 'Interpreter', 'latex', 'fontsize', 30);
% xlim(tspan)
% grid on;
% % saveas(gcf, 'q5bstick.png');


%Checking plot
figure;
plot(tspan(1):dt:(remainingTime(1)-dt),finalX(:,1),'LineWidth',2); hold on
plot(tspan(1):dt:(remainingTime(1)-dt),finalX(:,2),'LineWidth',2);
set(gcf,'color','w');
title('x and y vs. Time; $\omega_{slip}$','fontsize',20,'Interpreter','latex')
xlabel('Time [s]', 'Interpreter', 'latex', 'fontsize', 20);
ylabel('[m]', 'Interpreter', 'latex', 'fontsize', 30);
xlim(tspan)
legend('x','y')
grid on;
% saveas(gcf, 'q5cslip.png');

%% Q6

wbreak = wslip;
separating = 0;
finalTime = 10;
while something()
    wbreak = wbreak+rez;
    currentTime = 0;
    currentX = [0; R; 0; 0; 0; 0; 0; wbreak];
    finalX = [];
    finalLambda = [];
    finalTimes = [];
    transitionTimes = [];
    transitionXs = [];
    
    %Check that we are not already slipping
    sticking = events_stick(remainingTime(1),currentX)<0;
    while currentTime<finalTime
        if sticking
            options = odeset('RelTol', 1e-8, 'AbsTol', 1e-8,'Events',@events_stick);         
            [t,X,te,ye,ie] = ode45(@sys_stick, [currentTime finalTime], currentX, options);
            Lambda = zeros(length(t),2);
            for i = 1:length(t)
                [~,Lambda(i,1:2)] = dyn_sol_stick(X(i,1:4)',X(i,5:8)',t(i));
            end

            currentTime = te;
            currentX = ye;
            finalX = [finalX;X(1:end-1,:)]; %transition state will be considered to belong to the next state
            finalLambda = [finalLambda;Lambda(1:end-1,:)];
            finalTimes = [finalTimes;t(1:end-1)];
            transitionTimes(end+1) = te;
            transitionXs(end+1,:) = ye;
            sgn_slip = sign(1.5-ie);
            sticking = 0;
        else
            options = odeset('RelTol', 1e-8, 'AbsTol', 1e-8,'Events',@events_slip);         
            [t,X,te,ye,ie] = ode45(@sys_slip, [currentTime finalTime], currentX, options);
            Lambda = zeros(length(t),2);
            for i = 1:length(t)
                [~,Lambda(i,2)] = dyn_sol_slip(X(i,1:4)',X(i,5:8)',t(i));
                Lambda(i,1) = -sgn_slip*mu*Lambda(i,2);
            end

            currentTime = te;
            currentX = ye;
            finalX = [finalX;X(1:end-1,:)];
            finalLambda = [finalLambda;Lambda(1:end-1,:)];
            finalTimes = [finalTimes;t(1:end-1)];
            transitionTimes(end+1) = te;
            transitionXs(end+1,:) = ye;
            
            

            %using ie:
            %if we are going back to sticking, sticking = 1
            %if we are separating, separating = 1; break
            
        end



    end
end
w0 = 0.9*wbreak;
X0 = [0; 0; 0; 0; 0; 0; 0; w0];  %  [x; y; theta; phi; dx; dy; dtheta; dphi];
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-8,'Events',@events_stick);         
[t, X,te,ye,ie] = ode45(@sys_stick, t_eval, X0, options); 
Lambda = zeros(length(t),2);
for i = 1:length(t)
    [~,Lambda(i,1:2)] = dyn_sol_stick(X(i,1:4)',X(i,5:8)',t(i));
end


