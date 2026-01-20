function traj = simulateMonoped(init,param)

% persistent initLast TrajLast
% 
% if isequal(init,initLast)
%     traj = TrajLast;
% else
% 
%     initLast = init;

    xosc0 = init.x_osc;
    yosc0 = init.y_osc;
    % xosc0 = param.x_osc;
    % yosc0 = param.y_osc;
    y0 = init.y;
    tsw = init.tsw;
    dx0 = init.dx;
    
    % fprintf("xosc: %d",xosc0); fprintf(", yosc: %d",yosc0); fprintf(", y0: %d",y0); fprintf(", tsw: %d",tsw); fprintf(", dx0: %d",dx0); fprintf("\n");
    
    nGrid = param.nGrid;
    tst = param.tst;
    kx = param.kx;
    front = param.front;

    [dx_osc,~] = CPG_Oscillator(xosc0,yosc0,1,0,tst,tsw);
    dth0 = -dx_osc*kx;

    phi0 = -xosc0*kx + pi/2;
    
    % Set up initial conditions for ode45
    x0 = 0; th0 = th_calc(phi0,0); l0 = 0;
    dy0 = 0; dl0 = 0; %dth0 = 0;
    
    CPG0 = [xosc0,yosc0];
    q0 = [x0,y0,th0,l0];
    dq0 = [dx0,dy0,dth0,dl0];
    F0 = [0,-453];
    X0 = [q0,dq0,CPG0,F0];
    tspan = [0 param.time];
    % tspan = [0 3];
    osc_param = [tst;tsw;kx];
    options = odeset('RelTol',1e-10,'AbsTol',1e-10);

    uprev = [0;1];
    
    % Run a simulation
    sol = ode113(@(t,X) monopedKinematicsForce(t,X,osc_param,uprev,front),tspan,X0,options);
    % fprintf("\n");

    % Extract the solution on uniform grid:
    temp.t = linspace(sol.x(1), sol.x(end), nGrid);
    z = deval(sol,temp.t);
    temp.x = z(1,:); 
    temp.y = z(2,:);
    temp.th = z(3,:);
    temp.l = z(4,:);
    temp.dx = z(5,:); 
    temp.dy = z(6,:);
    temp.dth = z(7,:);
    temp.dl = z(8,:);
    temp.x_osc = z(9,:);
    temp.y_osc = z(10,:);
    temp.dx_osc = gradient(temp.x_osc,(sol.x(end)/nGrid));
    temp.dy_osc = gradient(temp.y_osc,(sol.x(end)/nGrid));
    temp.Fe = z(11,:); 
    temp.Fr = z(12,:);

    traj = temp;

    % tstart = 2;
    % istart = round(length(temp.t)*tstart/tspan(2));
    % traj.t = temp.t(istart:end);
    % traj.x = temp.x(istart:end);
    % traj.y = temp.y(istart:end);
    % traj.th = temp.th(istart:end);
    % traj.l = temp.l(istart:end);
    % traj.dx = temp.dx(istart:end);
    % traj.dy = temp.dy(istart:end);
    % traj.dth = temp.dth(istart:end);
    % traj.dl = temp.dl(istart:end);
    % traj.x_osc = temp.x_osc(istart:end);
    % traj.y_osc = temp.y_osc(istart:end);
    % traj.dx_osc = temp.dx_osc(istart:end);
    % traj.dy_osc = temp.dy_osc(istart:end);

    % % get the torque at each time step
    % tau = zeros(1,length(traj.t));
    % f = zeros(1,length(traj.t));
    % 
    % for i = 1:length(traj.t)
    %     x = traj.x(i); y = traj.y(i); th = traj.th(i); l = traj.l(i);
    %     dx = traj.dx(i); dy = traj.dy(i); dth = traj.dth(i); dl = traj.dl(i);
    %     x_osc = traj.x_osc(i); y_osc = traj.y_osc(i);
    % 
    %     % osc_param contains tst, tsw
    %     tst = osc_param(1);
    %     tsw = osc_param(2);
    % 
    %     % calculate thk and tha
    %     thk = thk_calc(th,l);
    %     dthk = dthk_calc(th,l,dth,dl);
    %     tha = tha_calc(th,l);
    %     dtha = dtha_calc(th,l,dth,dl);
    % 
    %     % get foot dynamics and feed them into the grf equation
    %     foot_dynamics = foot_Func(x,y,th,l,thk,tha,dx,dy,dth,dl,dthk,dtha);
    % 
    %     % get slip model
    %     slip = zeros(4);
    %     slip(1) = phi_calc(th,l);
    %     slip(2) = r_calc(th,l);
    %     slip(3) = dphi_calc(th,l,dth,dl);
    %     slip(4) = dr_calc(th,l,dth,dl);
    % 
    %     % update oscilating values
    %     [dx_osc,~] = CPG_Oscillator_Mod(x_osc,y_osc,foot_dynamics(2),dy,tst,tsw);
    % 
    %     q = [x,y,th,l,dx,dy,dth,dl];
    % 
    %     [phi_d,dphi_d,kp,kd,ue,ur,dt_start,~] = CPG_states_Hopf_mod(traj.t(i),q,slip,foot_dynamics,y_osc,x_osc,dx_osc,kx);
    %     th_d = max(th_calc(phi_d,l),0);
    %     if (th_d==0)
    %         dth_d = max(dth_calc(phi_d,l,dphi_d,dl),0);
    %     else
    %         dth_d = dth_calc(phi_d,l,dphi_d,dl);
    %     end
    % 
    %     % get output
    %     tau(i) = - kp*(th - th_d) - kd*(dth - dth_d);
    %     f(i) = F_calc((traj.t(i)-dt_start),ue,ur,l,dl);
    % end
    % 
    % traj.tau = tau;
    % traj.Fp = f;

%     TrajLast = traj;
% end
end