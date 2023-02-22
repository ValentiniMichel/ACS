function tau = RNE(myRobot,q,dq,ddq,g0)
    links = myRobot.links;
    N = length(links);
    w = zeros(N, N+1,'sym');
    assume(w, 'real');
    ddp = zeros(N,N+1,'sym');
    assume(ddp, 'real');
    ddp(:,1) = -g0;
    dw = zeros(N,N+1,'sym');
    assume(dw, 'real');
    ddpc = zeros(N,N+1,'sym');
    assume(ddpc, 'real');
    z0 = [0;0;1];
    innerT = myRobot.innerT;
    
    for i = 2:length(links)+1
        T = innerT(:,:, i);
        R = T(1:3,1:3); %r_{i}^i-1
        r = T(1:3, 4);
        rc = links(i-1).tvec;   %translation vector
        w(:,i) = R'*w(:,i-1);
        dw(:,i) = R'*dw(:,i-1);
        if links(i-1).type == "cyl"
            w(:,i) = w(:,i)+R'*dq(i-1)*z0;
            dw(:,i) = dw(:,i)+R'*(ddq(i-1)*z0+cross(dq(i-1)*w(:,i-1),z0));
        end
        ddp(:,i) = R'*ddp(:,i-1)+cross(dw(:,i), r)+cross(w(:,i),cross(w(:,i), r));
        if links(i-1).type == "box"
            ddp(:,i) = ddp(:,i)+R'*ddq(i-1)*z0+cross(2*dq(i-1)*w(:,i),R'*z0);
        end
        ddpc(:,i) = ddp(:,i)+cross(dw(:,i),rc)+cross(w(:,i), cross(w(:,i), rc));
    end
    
    f = zeros(N,N+1,'sym');
    assume(f, 'real');
    mu = zeros(N,N+1, 'sym');
    assume(mu, 'real');
    tau = zeros(N, 1, 'sym');
    assume(tau, 'real');
    for i = N:-1:1
        T = innerT(:,:, i);
        Tm1 = innerT(:,:, i+1);
        R = T(1:3,1:3);
        Rm1 = Tm1(1:3,1:3);
        r = Tm1(1:3, 4);
        I = links(i).translatedInertia;
        rc = links(i).tvec;
        m = links(i).mass;
        j = i+1; %index for previously saved
        f(:,i) = R*f(:,i+1)+m*ddpc(:,j);
        mu(:,i) = -cross(f(:,i), r+rc)+R*mu(:,i+1)+cross(R*f(:,i+1), rc)+I*dw(:,j)+cross(w(:,j), I*w(:,j));
        if links(i).type == "box"
            tau(i) = f(:,i)'*Rm1'*z0;
        else
            tau(i) = mu(:,i)'*Rm1'*z0;
        end
    end
    tau = simplify(tau);
end

