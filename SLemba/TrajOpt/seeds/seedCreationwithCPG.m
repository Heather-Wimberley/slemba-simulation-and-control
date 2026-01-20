function out = seedCreationCPG(q_osc,N,h0,q_sys,osc_param)
    import casadi.*

    h = MX.sym('h');

    %% Integrator
    
    opts = struct();
    opts.abstol = 1e-8;       % Absolute tolerance
    % opts.abstol = [1e-6; 1e-6; 1e-6; 1e-6; 1e-3; 1e-3; 1e-3; 1e-3; 1e-2; 1e-2; 1e-2; 1e-2];
    opts.reltol = 1e-8;      % Relative tolerance
    opts.linear_solver = 'csparse';
    opts.linear_multistep_method = 'bdf';
    % opts.max_num_steps = 5000;
    opts.sensitivity_method = 'forward';
    q_sys = num2cell(q_sys(1:end-2));
    foot_dynamics = foot_Func(q_sys{:});

    q = MX.sym('q',2,1);
    dq_osc = h*CPG_Oscillator(q,foot_dynamics(2),foot_dynamics(4),osc_param(1),osc_param(2));

    dae_osc = struct('x',q,'p',h,'ode',dq_osc);
    F_osc = integrator('F', 'cvodes', dae_osc,0,1,opts);

    %% Get all points
    res = F_osc('x0',q,'p',h0);
    q_osc_next = res.xf;
    
    F0 = Function('F',{q},{q_osc_next},{'q'},{'q_next'});
    
    sim = F0.mapaccum(N-1);

    out = full(sim(q_osc));
end