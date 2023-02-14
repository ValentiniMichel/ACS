%Assignment3 
%Equation of motion
myRobot.computeLagrangian();
disp('B');
disp(myRobot.B);
disp('C');
disp(myRobot.C*myRobot.dq);
disp('G');
disp(myRobot.G);
disp('TAU');
disp(myRobot.TAU);

%%
myRobot.setTrajectoryPoint([pi/3;-0.05;-pi/3], [0.1;0.1;0.1]);

disp('Set configuration [pi/3;-0.05;-pi/3] to see some values');
disp('B');
disp(myRobot.setValueTrajectoryPoint(myRobot.B));
disp('C');
disp(myRobot.setValueTrajectoryPoint(myRobot.C*myRobot.dq));
disp('G');
disp(myRobot.setValueTrajectoryPoint(myRobot.G));
disp('TAU');
disp(myRobot.setValueTrajectoryPoint(myRobot.TAU));

