function [M,B,G,W,Wtilde] = dynamics_mat(q,q_d)

    m = 4;
    mh = 1.8;
    Ic = 0;
    l = 0.8;
    g = 10;
    a = deg2rad(1.5);

    % x = q(1);
    % y = q(2);
    th1 = q(3);
    th2 = q(4);
    % x_d = q_d(1);
    % y_d = q_d(2);
    th1_d = q_d(3);
    th2_d = q_d(4);

    M = zeros(4,4);
    M(1,1) = 2*m+mh;
    M(2,2) = M(1,1);
    M(3,1) = (3*m+2*mh)*l*cos(th1);
    M(1,3) = M(3,1);
    M(3,2) = -(3*m+2*mh)*l*sin(th1);
    M(2,3) = M(3,2);
    M(4,1) = l*m*cos(th2);
    M(1,4) = M(4,1);
    M(4,2) = l*m*sin(th2);
    M(2,4) = M(4,2);
    M(4,4) = m*l^2+Ic;
%     M(3,4) = 2*m*l^2*cos(th1+th2)-Ic;%RC says +Ic
    M(3,4) = 2*m*l^2*cos(th1+th2);
    M(4,3) = M(3,4);
%     M(3,3) = M(4,4)+4*(m+mh)*l^2+Ic; %RC says -Ic
    M(3,3) = M(4,4)+4*(m+mh)*l^2; %RC says -Ic

    B = zeros(4,1);
%     B(1) = -l*((th1_d)^2*sin(th1)*(3*m+2*mh)+(th2_d)^2*sin(th2)*(3*m+2*mh));
    B(1) = -l*((th1_d)^2*sin(th1)*(3*m+2*mh)+(th2_d)^2*sin(th2)*m);
%     B(2) = -l*((th1_d)^2*cos(th1)*(3*m+2*mh)-(th2_d)^2*cos(th2)*(3*m+2*mh));
    B(2) = -l*((th1_d)^2*cos(th1)*(3*m+2*mh)-(th2_d)^2*cos(th2)*m);
    B(3) = -2*m*l^2*(th2_d)^2*sin(th1+th2);
    B(4) = -2*m*l^2*(th1_d)^2*sin(th1+th2);
    
    G = zeros(4,1);
    G(1) = -g*sin(a)*(2*m+mh);
    G(2) = g*cos(a)*(2*m+mh);
    G(3) = -g*l*sin(a+th1)*(3*m+2*mh);
    G(4) = -m*g*l*sin(a-th2);

    wt = [1 0 0 0];
    wn = [0 1 0 0];
    W = [wt;wn];
    
    wtildet = [1 0 2*l*cos(th1) 2*l*cos(th2)];
    wtilden = [0 1 -2*l*sin(th1) 2*l*sin(th2)];
    Wtilde = [wtildet;wtilden];
    
end