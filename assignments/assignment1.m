% Assignment 1
% DH table
% direct kinematics
% inverse kinematics
% Jacobians (geometric and analytical)
% By hand, and cross-checking with Robotics toolbox

%%
%showdetails(myRobot.robot);
%config = homeConfiguration(myRobot.robot);
%myRobot.setAllConfig(config);
%myRobot.setAllConfig([pi/3;-0.05;pi/3]);
%show(myRobot.robot,config);
%myRobot.show
%%
close all;
disp('DH Table');
disp(myRobot.DH);
disp('Direct Kinematics');
disp(simplify(myRobot.allT(:,:,end)));

disp('Inverse Kinematics');
disp(ik());

disp('Geometric Jacobian');
disp(myRobot.computeJ);
disp('Analytical Jacobian');
disp(myRobot.Ja);


myRobot.setAllConfig([pi/3;-0.05;-pi/3]);

myRobot.show
disp('Set configuration [pi/3;-0.05;-pi/3] to cross check with toolbox');
disp('Direct kinematics toolbox');
disp(myRobot.toolboxT);
disp('Direct kinematics computed');
disp(myRobot.setValues(myRobot.allT(:,:,end)));
disp('Inverse kinematics toolbox');
disp(myRobot.toolboxIk);
disp('Inverse kinematics computed')
disp(myRobot.setValues(myRobot.inverseKinematics'));
disp('Geometric Jacobian toolbox');
disp(myRobot.toolboxJg);
disp('Geometric Jacobian computed')
disp(myRobot.setValues(myRobot.J));
disp('Analitical Jacobian toolbox');
disp(myRobot.toolboxJa);

