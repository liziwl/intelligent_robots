clear;clc;
format compact;
close all;
% 下边界
Ax=[-100,100];
Ay=[-50,-20];
% 上边界
Bx=[-90,100];
By=[50,60];
% 左边界
Cx=[-100,-90];
Cy=[-50,50];
% 右边界
Dx=[100,100];
Dy=[-20,60];

bound_x=[Ax,Bx,Cx,Dx];
bound_y=[Ay,By,Cy,Dy];

figure(1)
hold on;
title('Y vs X')
plot(Ax,Ay,'b')
plot(Bx,By,'b')
plot(Cx,Cy,'b')
plot(Dx,Dy,'b')

rho=100;
t=[0:0.01:2*pi];
theta=[0:pi/8:2*pi];
x=50*cos(t);
y=10+20*sin(t);
% plot(x,y)

for i=1:629
    flag=zeros(1,17);
    disp(i);
    for j=1:17
        pos=[x(i);y(i)];
        posr=[cos(theta(j)),-sin(theta(j));sin(theta(j)),cos(theta(j))]*[rho;0]+pos;
        px=[pos(1),posr(1)];
        py=[pos(2),posr(2)];
        for k=0:3
            [solx, soly]=dcross(bound_x(1+2*k:2+2*k),bound_y(1+2*k:2+2*k),px,py);
            flag(j)=isvalid(bound_x(1+2*k:2+2*k),bound_y(1+2*k:2+2*k),px,py,solx,soly);
            if flag(j)
                figure(1)
                hold on;
                plot(solx,soly,'.')
                figure(2)
                hold on;
                plot(solx,soly,'.k')
            end
        end
    end
    pause(0);
end

function flag=isvalid(x1,y1,x2,y2,solx,soly)
bias=0.01;
flag1= min(x1)-bias<solx && solx<bias+max(x1) && min(y1)-bias<soly && soly<bias+max(y1);
flag2= min(x2)-bias<solx && solx<bias+max(x2) && min(y2)-bias<soly && soly<bias+max(y2);
flag=flag1 && flag2;
end

function [solx, soly]=dcross(x1,y1,x2,y2)
A=[y1(2)-y1(1),x1(2)-x1(1);y2(2)-y2(1),x2(2)-x2(1)];
b=[x1(1)*(y1(2)-y1(1))-y1(1)*(x1(2)-x1(1));x2(1)*(y2(2)-y2(1))-y2(1)*(x2(2)-x2(1))];
x=A\b;
solx=x(1);
soly=-x(2);
end