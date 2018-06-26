clear;clc;
SatellitePosition=[17746 17572 7365 1;12127 -9774 21091 1;13324 -18178 14392 1;14000 -13073 19058 1;19376 -15756 -7365 1;zeros(19, 4)];
scatter3(SatellitePosition(1:5,1:1),SatellitePosition(1:5,2:2),SatellitePosition(1:5,3:3),'*')
hold on;
UserPosition=[6400 0 0 ];
scatter3(UserPosition(1),UserPosition(2),UserPosition(3),'.')

Prange=CalculatePseudoRange(SatellitePosition, UserPosition);

[CalUserPosition, OK]=CalculateUserPosition2(SatellitePosition, Prange);

function Prange=CalculatePseudoRange(SatellitePosition,UserPosition) %计算机模拟伪距测量
c=3e5; %光速，单位：km/s；
DeltaT=1e-4; %钟差为1e-4 数量级秒，假设卫星钟间时钟一致，DeltaT=Tu-Ts；钟差不宜超过3e-4，否则不收敛；
VisSatNum=0;
%首先找出可以观测到的卫星数量
SatellitePosNew=[];
for k=1:24
    if SatellitePosition(k,4)==1
        VisSatNum=VisSatNum+1;
        SatellitePosNew=[SatellitePosNew; SatellitePosition(k,1:3)];
    end %if
end %for
Prange=ones(1,VisSatNum);

for n=1:VisSatNum
    Prange(1,n)=sqrt( (SatellitePosNew(n,:)-UserPosition) *(SatellitePosNew(n,:)-UserPosition)' + c*DeltaT );
end
end

function [CalUserPosition,CalculateOK]=CalculateUserPosition2(SatellitePosition,Prange)
c=3e5; %光速，单位：km/s；
DeltaT=1e-3; %钟差为1e-4 数量级秒，假设卫星钟间时钟一致，DeltaT=Tu-Ts；钟差不宜超过3e-4，否则不收敛；
VisSatNum=0;
CalculateOK=1;
%首先找出可以接收到的卫星，多于4颗继续运算，否则返回
SatellitePosNew=[];
for k=1:24
    if SatellitePosition(k,4)==1
        VisSatNum=VisSatNum+1;
        SatellitePosNew=[SatellitePosNew; SatellitePosition(k,1:3)];
    end
end
if VisSatNum<4 %不足4 颗可见卫星
    CalculateOK=0;
    CalUserPosition=[0 0 0];
    return
end
XYZ0=[0 0 0]; %给用户位置赋初值
CalculateRecord=XYZ0; %此变量用于保存每一步迭代计算的中间结果
DeltaT0=0; %时钟差初始值
Wxyz=SatellitePosNew; %卫星位置坐标
Error=1000;
ComputeTime=0;
while (Error>0.01) && (ComputeTime<1000) %开始迭代运算
    ComputeTime=ComputeTime+1;
    R=ones(1,VisSatNum);
    for n=1:VisSatNum
        R(1,n)=sqrt( (Wxyz(n,:)-XYZ0) * (Wxyz(n,:)-XYZ0)' ) + DeltaT0*c;
    end %for
    DeltaP=R-Prange;
    A=ones(VisSatNum,3);
    for n=1:VisSatNum
        A(n,:)=(Wxyz(n,:)-XYZ0)./R(1,n);
    end
    H=[A ones(VisSatNum,1)];
    DeltaX=inv(H'*H) * H' * DeltaP'; %最小二乘法求卫星位置
    TempDeltaX=DeltaX(1:3,:);
    Error=max(abs(TempDeltaX));
    XYZ0=XYZ0+DeltaX(1:3,:)';
    scatter3(XYZ0(1),XYZ0(2),XYZ0(3),'o')
    draw(XYZ0,SatellitePosition(1:5,1:1),SatellitePosition(1:5,2:2),SatellitePosition(1:5,3:3));
    if ComputeTime<10
        CalculateRecord=[CalculateRecord; XYZ0];
    end
    DeltaT0=DeltaX(4,1)/(-c);
end %while
if ComputeTime==1000
    CalUserPosition=[0 0 0];
    CalculateOK=0;
else
    CalUserPosition=[XYZ0; CalculateRecord];
end
end

function draw(XYZ0, sx,sy,sz)
plot3([XYZ0(1),sx(1)],[XYZ0(2),sy(1)],[XYZ0(3),sz(1)]);
plot3([XYZ0(1),sx(2)],[XYZ0(2),sy(2)],[XYZ0(3),sz(2)]);
plot3([XYZ0(1),sx(3)],[XYZ0(2),sy(3)],[XYZ0(3),sz(3)]);
plot3([XYZ0(1),sx(4)],[XYZ0(2),sy(4)],[XYZ0(3),sz(4)]);
plot3([XYZ0(1),sx(5)],[XYZ0(2),sy(5)],[XYZ0(3),sz(5)]);
end