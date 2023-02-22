classdef Link < handle

    properties
        type %box or cyl
        mass
        a
        b
        c_h
        tvec
        pli %position of CoM wrt base frame
        pj %position of the previous joint wrt base frame
        idx %index of the joint
        robot
        qi
        dqi
        ddqi
        u
    end
    
    methods
        function obj = Link(type, mass, a, b, c_h, tvec)
            % type ("box" or "cyl")
            % box case: a(length) b(height) c_h(c,width)
            % cyl case: a(outer radius) 0 c_h(h,length)
            % tvec (translation vector)
            obj.type = type;
            obj.mass = mass;
            obj.a = a;
            obj.b = b;
            obj.c_h = c_h;
            obj.tvec= tvec;
              
        end
        
        function Ic = inertiaCoM(obj)
            %Inertia matrix wrt center of mass
            m = obj.mass;
            c = obj.c_h;
            h = obj.c_h;
            if obj.type == "box"
                %body inertia vector
               Ic = [1/12*m*(obj.b^2+obj.a^2)
                  1/12*m*(obj.a^2+c^2)
                  1/12*m*(obj.b^2+c^2)];
            else
                Ic = [1/2*m*(obj.a^2+obj.b^2)
                      1/2*m*(3*(obj.a^2+obj.b^2)+h^2)
                      1/2*m*(3*(obj.a^2+obj.b^2)+h^2)];
            end
            %body inertia matrix 
            Ic = diag(Ic);
        end
        
        function It = translatedInertia(obj)
            T = obj.robot.getTransform(obj.idx);
            r = -T(1:3,1:3)'*obj.tvec;
            It = obj.inertiaCoM + obj.mass*(r'*r*eye(3)-r*r');
        end
        
        function setPosition(obj, idx, robot, qi, dqi, ddqi)
            T = robot.getTransform(idx+1); %CoM is computed from the end of the link
            R = T(1:3,1:3);
            %save position of Center of mass wrt base frame
            obj.pli = R*obj.tvec+T(1:3, 4);
            T2 = robot.getTransform(idx);
            %pj is the position of the previous joint wrt base frame
            obj.pj = T2(1:3, 4); %pj-1
            obj.idx = idx;
            obj.robot = robot;
            obj.qi = qi;
            obj.dqi = dqi;
            obj.ddqi = ddqi;
        end
        
        function Jp = partialJacobian(obj)            
            Jp = sym(zeros(6, obj.robot.N));
            for i=1:obj.idx
                Z = obj.robot.jacobianZ(i);
                if obj.robot.links(i).type == "box"
                    col = [Z;[0;0;0]];
                else
                    C = cross(Z, obj.pli-obj.robot.links(i).pj);
                    col = [C;Z];
                end
                Jp(:, i) = col;
            end
        end

        function B = overallInertia(obj)
            m = obj.mass;
            J = obj.partialJacobian;
            Jp = J(1:3, :);
            Jo = J(4:6, :);
            T = obj.robot.getTransform(obj.idx+1);
            R = T(1:3,1:3);
            B = m*(Jp'*Jp)+Jo'*R*obj.translatedInertia*R'*Jo;
        end
        
        function u = potentialEnergy(obj)
            syms g real;
            g0 = [0;0;g];
            u = -obj.mass*g0'*obj.pli;
            obj.u = u;
        end

    end
end

