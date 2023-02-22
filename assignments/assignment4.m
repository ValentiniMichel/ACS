%Assignment4
%Newton-Euler Equation
zero = zeros(3,1);
syms g real;
g0 = [0;0;g];
tau = RNE(myRobot, myRobot.q, myRobot.dq, myRobot.ddq, g0);
G = RNE(myRobot, myRobot.q, zero, zero, g0);
C = RNE(myRobot,myRobot.q, myRobot.dq, zero, zero);
N = myRobot.N;
B = zeros(N,N, 'sym');

assume(B, 'real');
for i = 1:N
    ei = zeros(N, 1);
    ei(i) = 1;
    B(:,i) = RNE(myRobot, myRobot.q, zero, ei, zero);
end

%%
disp('B RNE');
disp(B);
disp('C RNE * dq');
disp(C);
disp('G RNE');
disp(G);
disp('TAU RNE');
disp(tau);


%%
myRobot.setTrajectoryPoint([pi/3;-0.05;-pi/3], [0.1;0.1;0.1]);
disp('Set configuration [pi/3;-0.05;-pi/3] to see some values');
disp('B RNE');
disp(myRobot.setValueTrajectoryPoint(B));
disp('C RNE * dq');
disp(myRobot.setValueTrajectoryPoint(C));
disp('G RNE');
disp(myRobot.setValueTrajectoryPoint(G));
disp('TAU RNE');
disp(myRobot.setValueTrajectoryPoint(tau));