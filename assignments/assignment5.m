% Assignment 5
% Dynamic model in the operational space

disp('B op');
disp(myRobot.Ba);
disp('C op * xd');
disp(myRobot.Ca);
disp('G op');
disp(myRobot.Ga);


%%

myRobot.setTrajectoryPoint([pi/3;-0.05;-pi/3], [0.1;0.1;0.1]);
disp('Set configuration [pi/3;-0.05;-pi/3] to see some values');
disp('B op');
disp(myRobot.setValueTrajectoryPoint(myRobot.Ba));
disp('C op * xd');
disp(myRobot.setValueTrajectoryPoint(myRobot.Ca));
disp('G op');
disp(myRobot.setValueTrajectoryPoint(myRobot.Ga));


