classdef MyRobot < handle
    
    properties
        robot
        config
        DH
        allT
        innerT
        N
        Jg
        J
        q
        dq
        ddq
        B
        l1
        l2
        l3
        l4
        phi
        links
        idx
        trajectoryPoint
        C
        G
        TAU
        TAU_RNE
    end
    
    methods
        function obj = MyRobot(urdfFile, DH, links)
            obj.robot = importrobot(urdfFile);
            obj.config = homeConfiguration(obj.robot);
            obj.DH = DH;
            obj.computeDirectKinematics();
            obj.q = sym('q', [3 1], 'real'); % ABORTO
            obj.dq = sym('dq', [3 1], 'real'); % BIG ABORTO
            obj.ddq = sym('ddq', [3 1], 'real'); % GIGA ABORTO
            obj.N = length(links);
            obj.setLinks(links);
        end
       
        function names = frameNames(obj)
            names = obj.config.JointName;
        end

        function show(obj, figNum)
            if nargin == 2
                figure(figNum);
            else
                figure;
            end
            show(obj.robot,obj.config);
            xlim([-1 1]);
            ylim([-1 1]);
            zlim([0 1]);
        end     
        
        function computeDirectKinematics(obj)
            rows = size(obj.DH, 1);
            Ti = sym(zeros(4,4,rows));
            piM = sym ("piM", 'real');            
            
            obj.innerT = sym(zeros(4,4,rows));         
            %create rotate matrix for y rotation 
            Ae = [cos(piM) 0 sin(piM)   0;
                   0         1     0    0;
                   -sin(piM) 0  cos(piM)    0;
                   0         0     0    1;
                 ];
            for i=1:rows
                %take rotation and traslation for x and z from DH
                a = obj.DH(i, 1);
                alpha = obj.DH(i, 2);
                d = obj.DH(i, 3);
                theta = obj.DH(i, 4);
                %create matrix T
                T = [cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha) a*cos(theta)
                     sin(theta) cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta)
                     0 sin(alpha) cos(alpha) d
                     0 0 0 1];
                obj.innerT(:,:, i) = T;
                if i > 1
                    Ti(:,:,i) = Ti(:,:,i-1) * T;
                else 
                    Ti(:,:,i) = T;
                end
            end
            Ti(:,:,i) = Ti(:,:,i) * Ae;
            obj.allT = Ti;
        end
        
        function config = inverseKinematics(obj)
            [config1, config2] = ik;
            T = obj.allT(:,:,end);
            Px = T(1,4);
            Py = T(2,4);
            Pz = T(3,4);      
            config = subs(config1);            
            config = obj.setValues(config);
        end

        %function Jg = JacobianG(obj)
        %    syms a1 a3 d2 q1 q3
        %    dB = sym("dB");
        %    c1 = cos(q1);
        %    s1 = sin(q1);
        
        %    c3 = cos(q3);
        %    s3 = sin(q3);
            
        %    c13 = cos(q1 + q3);
        %    s13 = sin(q1 + q3);
            
        %    S = [0 -1 0; 1 0 0; 0 0 0];
        %    Jg = [[0;0;1;S*[a3*c13 + a1*c1; a3*s13+a1*s1; d2+q1]], [0;0;0;0;0;1], [[0;0;1;S*[a3*c13;a3*s13;0]]]];
        %    obj.J=Jg;
        %end
        
        %function t = Ta(obj)
        %    syms phi theta real;
        %    T = [0 -sin(phi) cos(phi)*sin(theta)
        %        0 cos(phi) sin(phi)*sin(theta)
        %        1 0 cos(theta)];
        %    t = [eye(3) zeros(3)
        %          zeros(3) T];
        %end
        
        %function ja = Ja(obj)
        %    Ta = obj.Ta;
        %    ja = inv(Ta)*obj.JacobianG();
        %    ja = simplify(ja);
        %end
        
        %function ja = Ja(obj)
        %    syms a1 a3 d2 q1 q3
        %    c1 = cos(q1);
        %    s1 = sin(q1);
        
        %    c4 = cos(q3);
        %    s4 = sin(q3);
            
        %    c13 = cos(q1 + q3);
        %    s13 = sin(q1 + q3);

        %    ja = [[-a3*s13 - a1*s1; a3*c13 + a1*c1; 0], [0;0;1], [-a3*s13;a3*c13;0]];           
        %end

        function P = diffP(obj, frameIdx, refIdx)
            T1 = obj.getTransform(frameIdx);
            T2 = obj.getTransform(refIdx);
            P = T2(1:3, 4) - T1(1:3, 4);
        end

        function J = geometricJacobian(obj, frameIdx)
            totalCols = min([obj.N, frameIdx]);
            J = sym(zeros(6, totalCols));
            for i=1:totalCols
                type = obj.robot.Bodies{i}.Joint.Type;
                Z = obj.jacobianZ(i);
                if type == "prismatic"
                    col = [Z;0;0;0];
                else
                    P = obj.diffP(i, frameIdx);
                    C = cross(Z,P);
                    col = [C;Z];
                end
                J(:, i) = col;
            end
        end
        
        function JG=computeJ(obj)
            obj.J = obj.geometricJacobian(4);
            JG=obj.J;
        end
        
        function t = Ta(obj)
            syms phi theta real;
            T = [0 -sin(phi) cos(phi)*sin(theta)
                0 cos(phi) sin(phi)*sin(theta)
                1 0 cos(theta)];
            t = [eye(3) zeros(3)
                  zeros(3) T];
        end
        
        function ja = Ja(obj)
            Ta = obj.Ta;
            ja = inv(Ta)*obj.J;
        end


        function details(obj)
            showdetails(obj.robot)
        end
        function setSingleConfig(obj, jointIdx, jointValue)
            obj.config(jointIdx).JointPosition = jointValue;
        end

        function setAllConfig(obj,jointValues)
            for i=1:length(jointValues)
               obj.setSingleConfig(i, jointValues(i));
            end
        end

        function T = toolboxT(obj)
            T = getTransform(obj.robot,obj.config,'ee','base_link');
        end
        
        function T = getTransform(obj, frameIdx)
            T = obj.allT(:,:,frameIdx);
        end

        function ik = toolboxIk(obj)
            tform = obj.toolboxT;
            ik = inverseKinematics('RigidBodyTree', obj.robot);
            weights = [0.25 0.25 0.25 1 1 1];
            [configSoln,solnInfo] = ik('ee', tform, weights, obj.config);
            ik = [configSoln.JointPosition];
        end
        
        function Jg = toolboxJg(obj)
            Jg = geometricJacobian(obj.robot,obj.config,'ee');
        end
         
        function Ja = toolboxJa(obj)
            syms d0 d2 a1 a3 q1 q2 q3
            
            pe = [
                a3*cos(q1+q3)+a1*cos(q1); 
                a3*sin(q1+q3)+a1*sin(q1);
                d0+d2+q2; 
                q2+q3
            ];
            Ja_tool = jacobian(pe, [q1;q2;q3]);
            Ja = simplify(Ja_tool);
        end

        function valueVar = setValues(obj, var)
            Value;
            var = subs(var, obj.q, [obj.config.JointPosition]');
            valueVar = subs(var);
            valueVar = vpa(valueVar, 4);
        end

        %second assignment 
        function k = kineticEnergy(obj)
            obj.computeLagrangian();
            k = simplify(0.5*obj.dq'*obj.B*obj.dq);
            k = vpa(k, 4);
        end

        function u = potentialEnergy(obj)
            u = 0;
            for i = 1:obj.N
                u = u + obj.links(i).potentialEnergy;
            end
            u = vpa(u, 4);
        end

        function computeB(obj)
            B = sym(zeros(obj.N,obj.N));
            for i=1:obj.N
                l = obj.links(i);
                B = B + l.overallInertia();
            end
            obj.B = B;
        end

        function setLinks(obj, links)
            obj.links = links;
            for i=1:obj.N
                obj.links(i).setPosition(i, obj, obj.q(i), obj.dq(i), obj.ddq(i));
            end
            obj.computeLagrangian;
        end
        

        function Z = jacobianZ(obj, frameIdx)
            T = obj.getTransform(frameIdx);
            Z = T(1:3,3);
        end

        function setTrajectoryPoint(obj, q, dq)
            Value;
            obj.trajectoryPoint.q = q;
            if nargin == 2
                dq = zeros(obj.N, 1);
            end     
            obj.trajectoryPoint.dq = dq;
        end
        
        function valueVar = setValueTrajectoryPoint(obj, var)
            Value;
            var = subs(var, [obj.q; obj.dq], [obj.trajectoryPoint.q; obj.trajectoryPoint.dq]);

            valueVar = subs(var);
            valueVar = vpa(valueVar, 4);
        end
        
        function valueVar = setValueFast(obj, var)
            Value;
            var = subs(var);
            valueVar = subs(var);
            valueVar = vpa(valueVar, 4);
        end
        %assignment 3

        function computeLagrangian(obj)
            obj.computeB;
            obj.computeC;
            obj.computeG;
            obj.TAU = obj.B * obj.ddq + obj.C*obj.dq + obj.G;
        end

        function cijk = CIJK(obj, i, j, k)
            B = obj.B;
            %dBij/dqk
            dk = diff(B(i,j), obj.q(k));
            %dBik/dqj
            dj = diff(B(i,k), obj.q(j));
            %dBjk/dqi
            di = diff(B(j,k), obj.q(i));
            cijk = (dk+dj-di)/2;
        end
        
        function cij = CIJ(obj, i, j)
            cij = 0;
            for k = i:obj.N
                cij = cij + obj.CIJK(i,j,k)*obj.dq(k);
            end
        end
        
        function computeC(obj)
            C = sym(zeros(obj.N,obj.N));
            for i = 1:obj.N
                for j = 1:obj.N
                    C(i, j) = obj.CIJ(i, j);
                end
            end
            obj.C = C;
        end

        function computeG(obj)
            G = sym(zeros(obj.N, 1));
            syms g real;
            g0 = [0;0;g];
            for i = 1:obj.N
                g = 0;
                for j = 1:obj.N
                    lj = obj.links(j);
                    Jp = lj.partialJacobian();
                    g = g + lj.mass*g0'*Jp(1:3, i);
                end
                G(i) = g;
            end
            obj.G = -G;
        end
        %assignment 5

        function [ba, baNew] = Ba(obj)
            obj.computeJ();
            Ja = obj.Ja;
            ba = pinv(Ja')*obj.B*pinv(Ja);           
        end

        function ca = Ca(obj)
            Ja = obj.Ja;
            dJa = diff(Ja);
            ca = pinv(Ja')*obj.C*obj.dq-obj.Ba*dJa*obj.dq;
        end
        
        function ga = Ga(obj)
            ga = pinv(obj.Ja')*obj.G;
        end

        % assignment 6

        function ddq = fwdDyn(obj) 
            tau = sym('tau', [obj.N 1]);
            %calculate inverse formula for ddq 
            ddq = inv(obj.B) * (tau - obj.C*obj.dq - obj.G);
            obj.ddq=ddq;
        end
        
        function ddq = fwdDynRNE(obj,dq,B,C,G) 
            tau = sym('tau', [obj.N 1]);
            %calculate inverse formula for ddq 
            ddq = inv(B) * (tau - C*dq - G);
            obj.ddq=ddq;
        end
    end
end

