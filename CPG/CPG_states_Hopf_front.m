function [phi_d,dphi_d,kp,kd,ue,ur,dt_start_out] = CPG_states_Hopf_front(time,q,slip,foot,y_osc,x_osc,dx_osc,kx,uprev)
    % basic raibert controller with no height control
    % CPG has 3 states: 1 is retract swing back, 2 is retract swing
    % forwards, 3 is prefire, 4 is extend swing back

    % if foot is on floor: state = 1 else state = 0;

    % state variables
    x = q(1); y = q(2); th = q(3); l = q(4);
    dx = q(5); dy = q(6); dth = q(7); dl = q(8);
    phi = slip(1); r = slip(2);
    dphi = slip(3); dr = slip(4);

    % persistent variables
    persistent dt_start ue_prev ur_prev;
    if(time==0)
        dt_start = -100;
        ue_prev = uprev(1);
        ur_prev = uprev(2);
    end
    
    y_foot = foot(2);
 
    % variables for control
    phi_d = 0; dphi_d = 0; kp = 0; kd = 0;
    ue = 0; ur = 0;
    
    e = 0;%0.4;
    phi_d = -x_osc*kx + pi/2;
    dphi_d = -dx_osc*kx;
    if (y_osc>0)
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
    dt_start_out = dt_start;
end