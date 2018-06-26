clc;clear;
close all;

% figure(1)
hold on
axis([0 600 0 400]);
set(gca,'PlotBoxAspectRatio',[6 4 1]);

r=250;
xc=300;
yc=0;
t = 0 : .01 : pi; 
x = r * cos(t) + xc; 
y = r * sin(t) + yc; 
plot(x, y,'k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);

xc=300;
yc=400;
t = 0 : .01 : pi; 
x = r * cos(t) + xc; 
y = -r * sin(t) + yc; 
plot(x, y,'k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);

r=632;
xc=0;
yc=0;
t = 0 : .01 : pi/2; 
x = r * cos(t) + xc; 
y = r * sin(t) + yc; 
plot(x, y,'k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);

figure(2)
mu=0;
sigma=25;
hold on
axis([0 600 0 400]);
set(gca,'PlotBoxAspectRatio',[6 4 1]);

r=250;
xc=300;
yc=0;
t = 0 : .01 : pi; 
len = size(t);
x = r * cos(t) + xc; 
y = r * sin(t) + yc; 
x=normrnd(mu,sigma,1,len(2))+x;
y=normrnd(mu,sigma,1,len(2))+y;
plot(x, y,'.k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);

xc=300;
yc=400;
t = 0 : .01 : pi; 
x = r * cos(t) + xc; 
y = -r * sin(t) + yc; 
x=normrnd(mu,sigma,1,len(2))+x;
y=normrnd(mu,sigma,1,len(2))+y;
plot(x, y,'.k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);

r=632;
xc=0;
yc=0;
t = 0 : .005 : pi/2; 
len = size(t);
x = r * cos(t) + xc; 
y = r * sin(t) + yc; 
x=normrnd(mu,sigma,1,len(2))+x;
y=normrnd(mu,sigma,1,len(2))+y;
plot(x, y,'.k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);

circleplot(530,200,20,pi)

figure(3)
hold on
axis([0 600 0 400]);
set(gca,'PlotBoxAspectRatio',[6 4 1]);
m = 530;
n = 200;
sample=50;

re=70;

% 下面半圆重新采样
tmpx = zeros(sample);
tmpy = zeros(sample);
ct=1;
r=250;
xc=300;
yc=0;
while 1
    if ct>sample
        break;
    end
    t = 0 : .001 : pi; 
    len = size(t);
    x = r * cos(t) + xc;
    y = r * sin(t) + yc; 
    x=normrnd(mu,sigma,1,len(2))+x;
    y=normrnd(mu,sigma,1,len(2))+y;
    dis = ((x-m).^2+(y-n).^2).^0.5;
    for i=1:length(dis)
        if ct>sample
            break;
        end
        if dis(i)<re
            tmpx(ct)=x(i);
            tmpy(ct)=y(i);
            ct=ct+1;
        end
    end
end
plot(tmpx, tmpy,'.k','LineWidth',2)

% 上半圆采样
tmpx = zeros(sample);
tmpy = zeros(sample);
ct=1;
r=250;
xc=300;
yc=400;
while 1
    if ct>sample
        break;
    end
    t = 0 : .001 : pi; 
    len = size(t);
    x = r * cos(t) + xc;
    y = -r * sin(t) + yc; 
    x=normrnd(mu,sigma,1,len(2))+x;
    y=normrnd(mu,sigma,1,len(2))+y;
    dis = ((x-m).^2+(y-n).^2).^0.5;
    for i=1:length(dis)
        if ct>sample
            break;
        end
        if dis(i)<re
            tmpx(ct)=x(i);
            tmpy(ct)=y(i);
            ct=ct+1;
        end
    end
end
plot(tmpx, tmpy,'.k','LineWidth',2)

% 大圆重新采样
tmpx = zeros(sample);
tmpy = zeros(sample);
ct=1;
r=632;
xc=0;
yc=0;
while 1
    if ct>sample
        break;
    end
    t = 0 : .001 : pi/2; 
    len = size(t);
    x = r * cos(t) + xc; 
    y = r * sin(t) + yc; 
    x=normrnd(mu,sigma,1,len(2))+x;
    y=normrnd(mu,sigma,1,len(2))+y;
    dis = ((x-m).^2+(y-n).^2).^0.5;
    for i=1:length(dis)
        if ct>sample
            break;
        end
        if dis(i)<re
            tmpx(ct)=x(i);
            tmpy(ct)=y(i);
            ct=ct+1;
        end
    end
end
plot(tmpx, tmpy,'.k','LineWidth',2)
circleplot(m,n,20,pi)

saveas(1,'fig1.png');
saveas(2,'fig2.png');
saveas(3,'fig3.png');

function circleplot(xc, yc, r, theta) 
t = 0 : .01 : 2*pi; 
x = r * cos(t) + xc; 
y = r * sin(t) + yc; 
plot(x, y,'r','LineWidth',2)
t2 = 0 : .01 : r; 
x = t2 * cos(theta) + xc; 
y = t2 * sin(theta) + yc; 
plot(x, y,'r','LineWidth',2)
end
