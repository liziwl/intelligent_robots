clc;clear;
close all;

figure(1)
hold on
motionModel = robotics.OdometryMotionModel;
motionModel.Noise = [0.02 0.02 0.005 0.005];

previousPoses =  zeros(500,3);
currentOdom = [0 0 0];
currentPoses = motionModel(previousPoses, currentOdom);
plot(currentPoses(:,1),currentPoses(:,2),'.')
circleplot(currentOdom(1), currentOdom(2), 0.1,0)

shift = [1 1 pi/2];
previousPoses = currentPoses;
currentOdom = currentOdom + shift;
currentPoses = motionModel(previousPoses, currentOdom);
plot(currentPoses(:,1),currentPoses(:,2),'.')
rect = [0.8,0.95,0.4,0.03];
rectangle('Position',rect,'FaceColor','w','EdgeColor','b');
circleplot(currentOdom(1), currentOdom(2), 0.1,pi/2)



function circleplot(xc, yc, r, theta)
t = 0 : .01 : 2*pi;
x = r * cos(t) + xc;
y = r * sin(t) + yc;
plot(x, y,'k','LineWidth',2)
t2 = 0 : .01 : r;
x = t2 * cos(theta) + xc;
y = t2 * sin(theta) + yc;
plot(x, y,'k','LineWidth',2)
axis square; grid
end

function [flag] = inrect(rect)
if (rect(1)<pos(1) && pos(1) <rect(1)+rect(3) && rect(2)<pos(2) && pos(2) <rect(2)+rect(4))
    flag = 1;
else
    flag = 0;
end
end