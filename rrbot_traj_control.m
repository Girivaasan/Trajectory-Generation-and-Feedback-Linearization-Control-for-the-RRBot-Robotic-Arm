clear; close; clc;
% ROS Setup
rosinit;
syms theta1 theta2 theta1_dot theta2_dot theta1_ddot theta2_ddot 'Real';
m1 = 1; m2 = 1 ; l1 = 1; l2 = 1; I1 = 0.084; I2 = 0.084; r1 = 0.45; 
r2 = 0.45; g = 9.81;
K = [15.7106   -1.5411    6.9196    0.1269;
    2.4190   16.3121    0.1276    7.0804];

j1_effort = rospublisher('/rrbot/joint1_effort_controller/command');
j2_effort = rospublisher('/rrbot/joint2_effort_controller/command');
JointStates = rossubscriber('/rrbot/joint_states');
tau1 = rosmessage(j1_effort);
tau2 = rosmessage(j2_effort);
tau1.Data = 0;
tau2.Data = 0;
send(j1_effort,tau1);
send(j2_effort,tau2);
client = rossvcclient('/gazebo/set_model_configuration');
req = rosmessage(client);
req.ModelName = 'rrbot';
req.UrdfParamName = 'robot_description';
req.JointNames = {'joint1','joint2'};
req.JointPositions = [deg2rad(200), deg2rad(125)];
resp = call(client,req,'Timeout',3);
tic;
t = 0;

theta1_l = [];
theta2_l = [];
theta1_dot_l = [];
theta2_dot_l = [];
theta1_des = [];
theta2_des = [];
theta1_d_des = [];
theta2_d_des = [];
theta1_dd_des = [];
theta2_dd_des = [];

timeT = [];
T1 = [];
T2 = [];
  
while(t < 10)
    t = toc;
    timeT(end+1) = t;
    % read the joint states
    jointData = receive(JointStates);
    % inspect the "jointData" variable in MATLAB to get familiar with its structure
    % implement your state feedback controller below
    
    %K1 = [23.5850,5.8875,5.1470,2.6108];
    %K2 = [5.8875,4.9875,1.5443,0.9770];
    cstate = [wrapTo2Pi(jointData.Position(1));wrapTo2Pi(jointData.Position(2));jointData.Velocity(1);jointData.Velocity(2)];
    % sample the time, joint state values, and calculated torques here to be plotted at the end
    theta1 = jointData.Position(1);
    theta1_l(end+1) = theta1;
    theta2= jointData.Position(2);
    theta2_l(end+1) = theta2;
    theta1_dot = jointData.Velocity(1);
    theta1_dot_l(end+1) = theta1_dot;
    theta2_dot = jointData.Velocity(2);
    theta2_dot_l(end+1) = theta2_dot;
   
    
    M = [(m1*r1^2 + I1 + I2 + (m2*(2*l1^2 + 4*cos(theta2)*l1*r2 + 2*r2^2))/2)   (I2 + (m2*(2*r2^2 + 2*l1*cos(theta2)*r2))/2); (I2 + (m2*(2*r2^2 + 2*l1*cos(theta2)*r2))/2)   (m2*r2^2 + I2)];
    G = [- g*m2*(r2*sin(theta1 + theta2) + l1*sin(theta1)) - g*m1*r1*sin(theta1);
                                          -g*m2*r2*sin(theta1 + theta2)];
    C = [-(m2*theta2_dot*(4*l1*r2*theta1_dot*sin(theta2) + 2*l1*r2*theta2_dot*sin(theta2)))/2; l1*m2*r2*theta1_dot^2*sin(theta2)];
    a1 = [3.1416; 0; -0.0942; 0.0063];
    a2 = [1.5708; 0; -0.0471; 0.0031];
    theta1_des = a1' * [1  t  t*t  t*t*t]';
    theta1_d_des = a1' * [0  1   2*t  3*t*t]';
    theta1_dd_des = a1' * [0  0  2  6*t]';

    theta2_des = a2' * [1  t  t*t  t*t*t]';
    theta2_d_des = a2' * [0  1  2*t  3*t*t]';
    theta2_dd_des = a2' * [0  0  2  6*t]';
    
    theta_des = [theta1_des;theta2_des];
    theta_d_des = [theta1_d_des;theta2_d_des];
    theta_dd_des = [theta1_dd_des;theta2_dd_des];

    des_theta = [theta_des;theta_d_des];
    theta = [theta1;theta2;theta1_dot;theta2_dot];
    v = ((-K)*(theta - des_theta)) + theta_dd_des;
    T = M*v + C + G;

    tau1.Data = T(1);
    tau2.Data = T(2);
    T1(end+1) = tau1.Data;
    T2(end+1) = tau2.Data;
    send(j1_effort,tau1);
    send(j2_effort,tau2); 
    
end

tau1.Data = 0;
tau2.Data = 0;
send(j1_effort,tau1);
send(j2_effort,tau2);

rosshutdown;

%Plots
figure;
subplot(3,2,1);
plot(timeT,theta1_l);
title('Theta1');
xlabel('Time (t)');
ylabel('Theta1 (rad) ');

subplot(3,2,2);
plot(timeT,theta2_l);
title('Theta2');
xlabel('Time (t)');
ylabel('Theta2 (rad)');

subplot(3,2,3);
plot(timeT,theta1_dot_l);
title('Theta1-dot');
xlabel('Time (t)');
ylabel('Theta1 - dot (rad/s)');

subplot(3,2,4);
plot(timeT,theta2_dot_l);
title('Theta2-dot');
xlabel('Time (t)');
ylabel('Theta2 - dot (rad/s)');

subplot(3,2,5);
plot(timeT,T1);
title('T1');
xlabel('Time (t)');
ylabel('N-m');

subplot(3,2,6);
plot(timeT,T2);
title('T2');
xlabel('Time (t)');
ylabel('N-m');

