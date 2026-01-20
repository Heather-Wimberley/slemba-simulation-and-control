function [phi_d,dphi_d,kp,kd,ue,ur,dt_start_out,state_out,dx_filtered,dy_lift_out] = CPG_states_Hopf(time,q,slip,foot,y_osc,x_osc,dx_osc,kx,uprev,front)
    % basic raibert controller with no height control
    % CPG has 3 states: 1 is retract swing back, 2 is retract swing
    % forwards, 3 is prefire, 4 is extend swing back

    % if foot is on floor: state = 1 else state = 0;

    % state variables
    x = q(1); y = q(2); th = q(3); l = q(4);
    dx = q(5); dy = q(6); dth = q(7); dl = q(8);
    phi = slip(1); r = slip(2);
    dphi = slip(3); dr = slip(4);

    if (front)
        direction = -1;
    else
        direction = 1;
    end

    % persistent variables
    persistent state dt_start ue_prev ur_prev dx_calc dy_lift dy_land dy_max dy_min first_jump;
    if(time==0)
        state = States.Flight;
        dt_start = -100;
        ue_prev = uprev(1);
        ur_prev = uprev(2);
        dx_calc = dx;
        first_jump = 0;
    end
    
    y_foot = foot(2);
 
    % variables for control
    phi_d = 0; dphi_d = 0; kp = 0; kd = 0;
    ue = 0; ur = 0;


    % constants
    filter = 0.9985;
    dx_calc = dx*(1-filter) + dx_calc*filter;
    %state switching
    switch(state)
        case States.Flight
            if(y_osc<=0)
                state = States.Stance;
            end
        case States.Stance
            if(y_osc>0)
                state = States.Flight;
            end
    end

    % set command
    osc_tol = -1e-4;

    phi_d = direction*x_osc*kx + pi/2;
    dphi_d = direction*dx_osc*kx;
    if (y_osc>osc_tol)
        % - fire based on angle of osc - 
        % th_osc = atan(abs(y_osc)/abs(x_osc));
        % if (x_osc>=0||(x_osc<0 && (pi/2-th_osc)<e))

        % - fire based on xosc position - 
        if(x_osc>0)

        % if(phi_d<(pi/2 + e*kx))
        % if(dy>=0)
            ue = 0; ur = 1;
        else
            % if (time>1)
                ue = 1; ur = 1;
            % else
            %     ue = 0; ur = 1;
            % end
        end
    else
        ue = 1; ur = 0;
    end
    kp = 250;
    kd = 10;
    
    % check for piston state change
    if(ue~=ue_prev||ur~=ur_prev)
        dt_start = time;
    end
    ue_prev = ue; ur_prev = ur;
    state_out = state;
    dt_start_out = dt_start;
    dx_filtered = dx_calc;
    dy_lift_out = dy_lift;
    % dy_lift_out = (abs(kx*-1.6 + 1.82) + abs(kx*5.8 -2.85))/2;
    % dy_lift_out = (abs(kx^2*17.8392 - 7.8769*kx + 2.3614) + abs(kx^2*1.05 + 5.1055*kx - 2.7560))/2;
end