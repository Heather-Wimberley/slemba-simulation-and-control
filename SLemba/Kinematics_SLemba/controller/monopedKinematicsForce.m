function out = monopedKinematicsForce(time,q,osc_param,uprev,front)
    % persistent dy_lift

    x = q(1); y = q(2); th = q(3); l = q(4);
    dx = q(5); dy = q(6); dth = q(7); dl = q(8);
    x_osc = q(9); y_osc = q(10);
    Fe = q(11); Fr = q(12);

    % if((1-1e-2<x_osc) && (x_osc<1+1e-2) && (-1e-2<y_osc) && (y_osc<1e-2))
    %     dy_lift = dy;
    % end

    % osc_param contains tst, tsw, kx
    tst = osc_param(1);
    tsw = osc_param(2);
    kx = osc_param(3);

    % calculate thk and tha
    thk = thk_calc(th,l);
    dthk = dthk_calc(th,l,dth,dl);
    tha = tha_calc(th,l);
    dtha = dtha_calc(th,l,dth,dl);

    % get foot dynamics and feed them into the grf equation
    foot_dynamics = foot_Func(x,y,th,l,thk,tha,dx,dy,dth,dl,dthk,dtha);

    % grf = grf_calc(foot_dynamics);
    % grf_t = grf(1); grf_n = grf(2);
    % 
    % % get end reaction force using peneration method from paper
    % f_end = end_calc(l,dl);

    % get slip model
    slip = zeros(4);
    slip(1) = phi_calc(th,l);
    slip(2) = r_calc(th,l);
    slip(3) = dphi_calc(th,l,dth,dl);
    slip(4) = dr_calc(th,l,dth,dl);

    % update oscilating values
    [dx_osc,dy_osc] = CPG_Oscillator(x_osc,y_osc,foot_dynamics(2),foot_dynamics(4),tst,tsw);

    [phi_d,dphi_d,kp,kd,ue,ur,dt_start,state,dx_filtered] = CPG_states_Hopf(time,q,slip,foot_dynamics,y_osc,x_osc,dx_osc,kx,uprev,front);

    % Testing
    % ----------------------------------------------------------
    phi_d = pi/2; dphi_d = 0;
    % ue = 0; ur = 0; kp = 250; kd = 5;
    ue = 1; ur = 0; kp = 0; kd = 0;
    % if (foot_dynamics(2)>0)
    %     ue = 1; ur = 1;
    % else
    %     ue = 1; ur = 0;
    % end
    dt_start = -100;
    % ----------------------------------------------------------

    th_d = max(th_calc(phi_d,l),0);
    if (th_d==0)
        dth_d = max(dth_calc(phi_d,l,dphi_d,dl),0);
    else
        dth_d = dth_calc(phi_d,l,dphi_d,dl);
    end

    % get output
    t = - kp*(th - th_d) - kd*(dth - dth_d);
    f = F_calc_dF(Fe,Fr,ue,ur,dl);
    % f = F_calc((time-dt_start),ue,ur,l,dl);

    t = 2;

    % % calculate constraint force
    % constraint = constraint_Func(x,y,th,l,thk,tha,dx,dy,dth,dl,dthk,dtha,t,f,grf_t,grf_n,f_end);
    % f_cx = constraint(1); f_cy = constraint(2);
    % 
    % % acceleration of the system
    % accel = accel_Func(x,y,th,l,thk,tha,dx,dy,dth,dl,dthk,dtha,t,f,f_cx,f_cy,grf_t,grf_n,f_end);
    accel = accel_numeric([x;y;th;l;thk;tha],[dx;dy;dth;dl;dthk;dtha],[t;f]);
    dF = dF_calc([Fe,Fr],ue,ur,l);

    out = zeros(12,1);

    out(1) = dx; out(2) = dy; out(3) = dth; out(4) = dl;
    out(5:8) = [accel(1:4)];
    out(9) = dx_osc; out(10) = dy_osc;
    out(11:12) = dF;

    % display the time that the solver has been running for
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