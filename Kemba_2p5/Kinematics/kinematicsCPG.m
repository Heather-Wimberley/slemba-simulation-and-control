function out = kinematicsCPG(time,q,osc_param)
% get the derivative of the generalised terms (dq and ddq) using a CPG
% controller

    % break up generalised coordinates
    x = q(1); y = q(2); r = q(3);
    thf = q(4); lf = q(5);
    thb = q(6); lb = q(7);
    dq = q(8:14);
    dx = dq(1); dy = dq(2); dr = dq(3);
    dthf = dq(4); dlf = dq(5);
    dthb = dq(6); dlb = dq(7);

    % break up oscillator terms
    osc = q(15:18);
    x_oscf = osc(1); y_oscf = osc(2);
    x_oscb = osc(3); y_oscb = osc(4);
    tstf = osc_param(1); tswf = osc_param(2);
    tstb = osc_param(3); tswb = osc_param(4);
    kx = osc_param(5);

    c = [0,osc_param(6);osc_param(7),0];

    % calculate thk and tha
    thkf = thk_calc(thf,lf);
    dthkf = dthk_calc(thf,lf,dthf,dlf);
    thaf = tha_calc(thf,lf);
    dthaf = dtha_calc(thf,lf,dthf,dlf);

    thkb = thk_calc(thb,lb);
    dthkb = dthk_calc(thb,lb,dthb,dlb);
    thab = tha_calc(thb,lb);
    dthab = dtha_calc(thb,lb,dthb,dlb);

    % get foot dynamics and feed them into the grf equation
    foot_dynamics = foot_Func(x,y,r,thf,lf,thkf,thaf,thb,lb,thkb,thab,dx,dy,dr,dthf,dlf,dthkf,dthaf,dthb,dlb,dthkb,dthab);
    footf = foot_dynamics(:,1);
    footb = foot_dynamics(:,2);

    %% Front leg controller
    
    uprevf = [0;1];

    % get slip model
    slipf = zeros(4);
    slipf(1) = phi_calc(thf,lf);
    slipf(2) = r_calc(thf,lf);
    slipf(3) = dphi_calc(thf,lf,dthf,dlf);
    slipf(4) = dr_calc(thf,lf,dthf,dlf);

    % update oscilating values
    [dx_oscf,dy_oscf] = CPG_Oscillator(x_oscf,y_oscf,footf(2),footf(4),tstf,tswf,c(1,2),[x_oscb;y_oscb]);

    [phi_df,dphi_df,kpf,kdf,uef,urf,dt_startf] = CPG_states_Hopf_front(time,q,slipf,footf,y_oscf,x_oscf,dx_oscf,kx,uprevf);

    %% Back leg controller

    uprevb = [0;1];

    % get slip model
    slipb = zeros(4);
    slipb(1) = phi_calc(thb,lb);
    slipb(2) = r_calc(thb,lb);
    slipb(3) = dphi_calc(thb,lb,dthb,dlb);
    slipb(4) = dr_calc(thb,lb,dthb,dlb);

    % update oscilating values
    [dx_oscb,dy_oscb] = CPG_Oscillator(x_oscb,y_oscb,footb(2),footb(4),tstb,tswb,c(2,1),[x_oscf;y_oscf]);

    [phi_db,dphi_db,kpb,kdb,ueb,urb,dt_startb] = CPG_states_Hopf_back(time,q,slipb,footb,y_oscb,x_oscb,dx_oscb,kx,uprevb);


    th_df = max(th_calc(phi_df,lf),0);
    if (th_df==0)
        dth_df = max(dth_calc(phi_df,lf,dphi_df,dlf),0);
    else
        dth_df = dth_calc(phi_df,lf,dphi_df,dlf);
    end

    th_db = max(th_calc(phi_db,lb),0);
    if (th_db==0)
        dth_db = max(dth_calc(phi_db,lb,dphi_db,dlb),0);
    else
        dth_db = dth_calc(phi_db,lb,dphi_db,dlb);
    end

    % get output
    % tf = speedTorque(- kpf*(thf - th_df) - kdf*(dthf - dth_df),dthf);
    tf = - kpf*(thf - th_df) - kdf*(dthf - dth_df);
    ff = F_calc((time-dt_startf),uef,urf,lf,dlf);
    % tb = speedTorque(- kpb*(thb - th_db) - kdb*(dthb - dth_db),dthb);
    tb = - kpb*(thb - th_db) - kdb*(dthb - dth_db);
    fb = F_calc((time-dt_startb),ueb,urb,lb,dlb);

    accel = accel_numeric([x;y;r;thf;lf;thkf;thaf;thb;lb;thkb;thab],[dx;dy;dr;dthf;dlf;dthkf;dthaf;dthb;dlb;dthkb;dthab],[tf;ff;tb;fb]);

    out = zeros(18,1);

    out(1) = dx; out(2) = dy; out(3) = dr; out(4) = dthf; out(5) = dlf; out(6) = dthb; out(7) = dlb;
    out(8:14) = [accel(1:5);accel(8:9)];
    out(15) = dx_oscf; out(16) = dy_oscf; out(17) = dx_oscb; out(18) = dy_oscb;

    % % display the time that the solver has been running for
    % persistent threshold;
    % if (time == 0)
    %     threshold = 0;
    % end
    % 
    % if (time>threshold)
    %     if (threshold == 0)
    %         fprintf("Time = %.4f",time);
    %     else
    %         if (time<=10)
    %             fprintf("\b\b\b\b\b\b%.4f",time);
    %         else
    %             fprintf("\b\b\b\b\b\b\b%.4f",time);
    %         end
    %     end
    %     threshold = threshold + 0.001;
    % end

end