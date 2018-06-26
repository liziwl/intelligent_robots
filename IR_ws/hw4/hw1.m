clc;clear;
close all;
motionModel = robotics.OdometryMotionModel;
motionModel.Noise = [0.005 0.005 0  0];

previousPoses =  zeros(500,3);
currentOdom = [0 0 0];
currentPoses = motionModel(previousPoses, currentOdom);
plot(currentPoses(:,1),currentPoses(:,2),'.')
trace = [currentOdom;];

shift = [0.5 0 0];
hold on;
for i = 1:3
    previousPoses = currentPoses;
    currentOdom = currentOdom + shift;
    trace = [trace;currentOdom];
    currentPoses = motionModel(previousPoses, currentOdom);
    plot(currentPoses(:,1),currentPoses(:,2),'.')
end

shift = [0 0.5 0];
for i = 1:3
    previousPoses = currentPoses;
    currentOdom = currentOdom + shift;
    trace = [trace;currentOdom];
    currentPoses = motionModel(previousPoses, currentOdom);
    plot(currentPoses(:,1),currentPoses(:,2),'.')
end

shift = [-0.5 0 0];
for i = 1:5
    previousPoses = currentPoses;
    currentOdom = currentOdom + shift;
    trace = [trace;currentOdom];
    currentPoses = motionModel(previousPoses, currentOdom);
    plot(currentPoses(:,1),currentPoses(:,2),'.')
end

plot(trace(:,1),trace(:,2),'r','LineWidth',1)

