clear;clc;
T=1/1000; %Sampling Interval in Seconds
t=zeros(1,1000);
index=0;

%Gains
k1=3.0;
k2=8.0;
k3=-1.5;

%Goal
theta=pi/2;

for index=0:1:7
    
    %Initialize arrays for system states
    rho=zeros(1,1000);
    alpha=zeros(1,1000);
    beta=zeros(1,1000);
    x=zeros(1,1000);
    y=zeros(1,1000);
    
    %Initial Conditions all in radians, index=0 is pure pursuit
    rho(1)=100;
    alpha(1)=0; %45 deg
    beta(1)=index*pi/4; %45 deg
    %Convert to cartesian form
    x(1)=rho(1)*cos(beta(1));
    y(1)=rho(1)*sin(beta(1));
    
    k=1;
    for n=2:1:1000
        
        t(n)=(n-1)*T;
        %Update state variables
        rho(n)=rho(n-1)+k*T*(-k1*rho(n-1)*cos(alpha(n-1)));
        alpha(n)=alpha(n-1)+k*T*(k1*sin(alpha(n-1))-k2*alpha(n-1)-k3*beta(n-1));
        beta(n)=beta(n-1)+k*T*(-k1*sin(alpha(n-1))+theta);
        
        %Conversion to cartesian form
        x(n)=rho(n)*cos(beta(n));
        y(n)=rho(n)*sin(beta(n));
        if k<=10
            k=k*2;
        elseif k<=20
            k=k+1;
        end
        
        %Use some bound to stop simulation as states approach zero but
        % never necessarily reach zero.
        %     if x(n) <= 0.001
        %         break;
        %     end
        %     if y(n) <= 0.001
        %         break;
        %     end
        if rho(n) <= 0.0001
            break;
        end
        %         if alpha(n) <= 0.001
        %             break;
        %         end
        %         if beta(n) <= 0.001
        %             break;
        %         end
    end
    
    %Convert all angles to degrees for plotting purposes only:
    for n=1:1:1000
        alpha(n)=alpha(n)*180/pi;
        beta(n)=beta(n)*180/pi;
    end
    
    figure(1)
    hold on
    title('Y vs X')
    xlabel('X Position (m)')
    ylabel('Y Position (m)')
    plot(x,y)
    pbaspect([1 1 1])
    
    figure(2)
    hold on
    title('Rho vs Time');
    xlabel('Time (m)')
    ylabel('Distance (m)')
    plot(t,rho,'.')
    
    %     figure(3)
    %     hold on
    %     title('Alpha vs Time')
    %     xlabel('Time (seconds)')
    %     ylabel('Alpha (degrees)')
    %     plot(t,alpha,'*')
    %
    %     figure(4)
    %     hold on
    %     title('Beta vs Time')
    %     xlabel('Time (seconds)')
    %     ylabel('Beta (degrees)')
    %     plot(t,beta,'*')
end