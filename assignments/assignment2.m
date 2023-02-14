% Assignment 2
% Compute the kinetic energy

disp('Kinetic energy');
disp(myRobot.kineticEnergy());

disp('Potential Energy');
disp(myRobot.potentialEnergy);

%%
myRobot.setTrajectoryPoint([pi/3;-0.05;-pi/3], [0.1;0.1;0.1]);
disp('Set configuration [pi/3;-0.05;-pi/3] to see some values');
disp('Kinetic energy');
disp(myRobot.setValueTrajectoryPoint(myRobot.kineticEnergy()));
disp('Potential Energy');
disp(myRobot.setValues(myRobot.potentialEnergy()));