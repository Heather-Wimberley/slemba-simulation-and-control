function t_out = speedTorque(t_in, w)
    t_max = 38; %Nm
    t_rated = 9.1; %Nm
    w_max = 218/60*2*pi; %rad/s
    w_rated = 177*2*pi/60; %rad/s
    t_upper = min(((w-w_max)*t_rated)/(w_rated-w_max), t_max); % Torque upper bound
    t_lower = max(((w+w_max)*t_rated)/(w_rated-w_max), -t_max); % Torque lower bound
    t_out = max(t_lower, min(t_upper, t_in));
end
 

