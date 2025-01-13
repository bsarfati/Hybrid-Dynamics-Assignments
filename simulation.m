%HW3 Ben Sarfati Ruigang Chen
clear all; clc; close all;

%% Task 1

r1 = [-1; 1]; 
r2 = [2;2];
alpha = [pi/4; 3*pi/4];
n1 = [cos(alpha(1)) sin(alpha(1))];
t1 = [-sin(alpha(1)) cos(alpha(1))];
n2 = [cos(alpha(2)) sin(alpha(2))];
t2 = [-sin(alpha(2)) cos(alpha(2))];

for mu = 0.4%:0.4:0.8
    gamma = atan(mu);
    [x_min,x_max] = fric_eq([r1 r2],alpha,mu*ones(2,1));
    
    xc_min = x_min(end);
    xc_max = x_max(end);
    n1Plot = [linspace(r1(1),r1(1)+4*n1(1),10);linspace(r1(2),r1(2)+4*n1(2),10)];
    n2Plot = [linspace(r2(1),r2(1)+4*n2(1),10);linspace(r2(2),r2(2)+4*n2(2),10)];
    t1Plot = [linspace(r1(1)-0.5*t1(1),r1(1)+0.5*t1(1),10);linspace(r1(2)-0.5*t1(2),r1(2)+0.5*t1(2),10)];
    t2Plot = [linspace(r2(1)-0.5*t2(1),r2(1)+0.5*t2(1),10);linspace(r2(2)-0.5*t2(2),r2(2)+0.5*t2(2),10)];
    %cone plots
    
    figure;
    plot(r1(1),r1(2),'k.','markersize',20); hold on;
    plot(r2(1),r2(2),'k.','markersize',20);
    plot(n1Plot(1,:),n1Plot(2,:),'b--','linewidth',2)
    plot(n2Plot(1,:),n2Plot(2,:),'b--','linewidth',2)
    plot(t1Plot(1,:),t1Plot(2,:),'k','linewidth',2)
    plot(t2Plot(1,:),t2Plot(2,:),'k','linewidth',2)
    axis equal
    yl = ylim;
    patch([xc_min,xc_max,xc_max,xc_min],[yl(1) yl(1) yl(2) yl(2)], 'black', 'FaceColor', 'green', 'FaceAlpha', 0.1);
    set(gcf,'color','w');
    title('Admissible COM Locations and Contact Visualization')
    
end