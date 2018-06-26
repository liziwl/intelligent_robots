clear;clc;
step=100;
T=1/step; %Sampling Interval in Seconds

x_init = 0;
y_init = 0;
theta_init = -3*pi/4;
omega=3;
velocity=8;
R=15;

x=zeros(1,step*2);
y=zeros(1,step*2);
theta=zeros(1,step*2);
ICCx=zeros(1,step*2);
ICCy=zeros(1,step*2);

x(1)=x_init;
y(1)=y_init;
theta(1)=theta_init;
ICCx(1)= x(1) - R*sin(theta(1));
ICCy(1)= y(1) + R*cos(theta(1));

for n=2:1:step
    [x(n),y(n),theta(n)]=update(x(n-1),y(n-1),theta(n-1),ICCx(n-1),ICCy(n-1),omega,T);
    ICCx(n)= x(n) - R*sin(theta(n));
    ICCy(n)= y(n) + R*cos(theta(n));
end

% Notice that I inverse the theta and the operator in the ICCx. Then It can
% turn right.
theta(100)=-theta(100);
for n=101:1:step*2
    [x(n),y(n),theta(n)]=update(x(n-1),y(n-1),theta(n-1),ICCx(n-1),ICCy(n-1),omega,T);
    ICCx(n)= x(n) + R*sin(theta(n));
    ICCy(n)= y(n) + R*cos(theta(n));
end

figure(1)
hold on
title('Y vs X')
xlabel('X Position (m)')
ylabel('Y Position (m)')
plot(x,y,'.')

function [x1, y1, theta1]=update(x, y ,theta,iccx,iccy,omega,t)
out=[cos(omega*t),-sin(omega*t),0;sin(omega*t),cos(omega*t),0;0,0,1]*[x-iccx;y-iccy;theta]+[iccx;iccy;omega*t];
x1 = out(1);
y1 = out(2);
theta1 = out(3);
end