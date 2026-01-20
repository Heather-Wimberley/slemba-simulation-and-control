function out = kinematicsNoController(time,q)
    x = q(1); y = q(2); r = q(3);
    thf = q(4); lf = q(5);
    thb = q(6); lb = q(7);
    dq = q(8:14);
    dx = dq(1); dy = dq(2); dr = dq(3);
    dthf = dq(4); dlf = dq(5);
    dthb = dq(6); dlb = dq(7);

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
    
    phi_df = pi/2; phi_db = pi/2;
    dphi_df = 0; dphi_db = 0;

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

    uef = 1; urf = 0;
    ueb = 1; urb = 0;

    kp = 200;
    kd = 25;

    dt_start = 0;

    % get output
    tf = - kp*(thf - th_df) - kd*(dthf - dth_df);
    ff = F_calc((time-dt_start),uef,urf,lf,dlf);
    tb = - kp*(thb - th_db) - kd*(dthb - dth_db);
    fb = F_calc((time-dt_start),ueb,urb,lb,dlb);

    accel = accel_numeric([x;y;r;thf;lf;thkf;thaf;thb;lb;thkb;thab],[dx;dy;dr;dthf;dlf;dthkf;dthaf;dthb;dlb;dthkb;dthab],[tf;ff;tb;fb]);

    out = zeros(14,1);

    out(1) = dx; out(2) = dy; out(3) = dr; out(4) = dthf; out(5) = dlf; out(6) = dthb; out(7) = dlb;
    out(8:14) = [accel(1:5);accel(8:9)];

    % display the time that the solver has been running for
    persistent threshold;
    if (time == 0)
        threshold = 0;
    end

    if (time>threshold)
        if (threshold == 0)
            fprintf("Time = %.4f",time);
        else
            if (time<=10)
                fprintf("\b\b\b\b\b\b%.4f",time);
            else
                fprintf("\b\b\b\b\b\b\b%.4f",time);
            end
        end
        threshold = threshold + 0.001;
    end

end