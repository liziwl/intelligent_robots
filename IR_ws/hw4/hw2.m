clc;clear;
close all;

n = [0.02 0.02 0 0; ...
    0.02 0 0 0.02;...
    0 0.02 0.02 0];

for i = 1:3
    figure(i)
    hold on
    motionModel = robotics.OdometryMotionModel;
    motionModel.Noise = n(i,:);

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
    circleplot(currentOdom(1), currentOdom(2), 0.1,pi/2) 
end

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
