function traj = simulateFull(init,param)

    % extract decision variables
    % if exist('init.tstb','var') == 1
    try
        xoscf0 = init.x_oscf;
        yoscf0 = init.y_oscf;
        xoscb0 = init.x_oscb;
        yoscb0 = init.y_oscb;
        y0 = init.y;
        r0 = init.r;
        tstb = init.tstb;
        tswf = init.tswf;
        tswb = init.tswb;
        dx0 = init.dx;
        dr0 = init.dr;
            
        nGrid = param.nGrid;
        tstf = param.tst;
        kx = param.kx;
        c = param.c;
    
        [dx_oscf,~] = CPG_Oscillator(xoscf0,yoscf0,1,0,tstf,tswf,c(1,2),[xoscb0;yoscb0]);
        dthf0 = -dx_oscf*kx;
        phif0 = -xoscf0*kx + pi/2;
        [dx_oscb,~] = CPG_Oscillator(xoscb0,yoscb0,1,0,tstb,tswb,c(2,1),[xoscf0;yoscf0]);
        dthb0 = dx_oscb*kx;
        phib0 = xoscb0*kx + pi/2;
        
        % Set up initial conditions for ode
        x0 = 0; thf0 = th_calc(phif0,0); lf0 = 0; thb0 = th_calc(phib0,0); lb0 = 0;
        dy0 = 0; dlf0 = 0; dlb0 = 0;
    % else
    catch
        y0 = init.y;
        r0 = init.r;
        dx0 = init.dx;
        dr0 = init.dr;
        xoscf0 = init.x_oscf;
        yoscf0 = init.y_oscf;
        xoscb0 = init.x_oscb;
        yoscb0 = init.y_oscb;

        nGrid = param.nGrid;
        tstf = param.tstf;
        tstb = param.tstb;
        tswf = param.tswf;
        tswb = param.tswb;
        kx = param.kx;
        c = [0,init.c;-init.c,0];

        [dx_oscf,~] = CPG_Oscillator(xoscf0,yoscf0,1,0,tstf,tswf,c(1,2),[xoscb0;yoscb0]);
        dthf0 = -dx_oscf*kx;
        phif0 = -xoscf0*kx + pi/2;
        [dx_oscb,~] = CPG_Oscillator(xoscb0,yoscb0,1,0,tstb,tswb,c(2,1),[xoscf0;yoscf0]);
        dthb0 = dx_oscb*kx;
        phib0 = xoscb0*kx + pi/2;

        % Set up initial conditions for ode
        x0 = 0; thf0 = th_calc(phif0,0); lf0 = 0; thb0 = th_calc(phib0,0); lb0 = 0;
        dy0 = 0; dlf0 = 0; dlb0 = 0;
    end
    
    CPG0 = [xoscf0,yoscf0,xoscb0,yoscb0];
    q0 = [x0,y0,r0,thf0,lf0,thb0,lb0];
    dq0 = [dx0,dy0,dr0,dthf0,dlf0,dthb0,dlb0];  
    X0 = [q0,dq0,CPG0];
    tspan = [0 param.time];
    % tspan = [0 3];
    osc_param = [tstf;tswf;tstb;tswb;kx;c(1,2);c(2,1)];
    options = odeset('RelTol',1e-10,'AbsTol',1e-10);
    options = odeset('RelTol',1e-4,'AbsTol',1e-4);
    
    % Run a simulation
    sol = ode113(@(t,X) kinematicsCPG(t,X,osc_param),tspan,X0,options);
    % fprintf("\n");

    % Extract the solution on uniform grid:
    temp.t = linspace(sol.x(1), sol.x(end), nGrid);
    z = deval(sol,temp.t);
    temp.x = z(1,:); 
    temp.y = z(2,:);
    temp.r = z(3,:);
    temp.thf = z(4,:);
    temp.lf = z(5,:);
    temp.thb = z(6,:);
    temp.lb = z(7,:);
    temp.dx = z(8,:); 
    temp.dy = z(9,:);
    temp.dr = z(10,:);
    temp.dthf = z(11,:);
    temp.dlf = z(12,:);
    temp.dthb = z(13,:);
    temp.dlb = z(14,:);
    temp.x_oscf = z(15,:);
    temp.y_oscf = z(16,:);
    temp.x_oscb = z(17,:);
    temp.y_oscb = z(18,:);
    temp.dx_oscf = gradient(temp.x_oscf,(sol.x(end)/nGrid));
    temp.dy_oscf = gradient(temp.y_oscf,(sol.x(end)/nGrid));
    temp.dx_oscb = gradient(temp.x_oscb,(sol.x(end)/nGrid));
    temp.dy_oscb = gradient(temp.y_oscb,(sol.x(end)/nGrid));

    traj = temp;
end