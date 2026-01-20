function out = seedCreation(q0,N,osc_param,h_param)
    import casadi.*

    h = MX.sym('h');
    tst = MX.sym('tst');
    tsw = MX.sym('tsw');
    kx = MX.sym('kx');

    %% Integrator
    
    opts = struct();
    opts.abstol = 1e-8;       % Absolute tolerance
    % opts.abstol = [1e-6; 1e-6; 1e-6; 1e-6; 1e-3; 1e-3; 1e-3; 1e-3; 1e-2; 1e-2; 1e-2; 1e-2];
    opts.reltol = 1e-8;      % Relative tolerance
    opts.linear_solver = 'csparse';
    opts.linear_multistep_method = 'bdf';
    % opts.max_num_steps = 5000;
    opts.sensitivity_method = 'forward';

    q = MX.sym('q',12,1);
    dq_sys = h*monopedKinematics(q,[tst,tsw,kx]);

    dae_syst = struct('x',q,'p',[tst,tsw,kx,h],'ode',dq_sys);
    F_sys = integrator('F', 'cvodes', dae_syst,0,1,opts);

    %% Get all points
    res = F_sys('x0',q,'p',[osc_param;h_param]);
    q0_next = res.xf;
    
    F0 = Function('F',{q},{q0_next},{'q'},{'q_next'});
    
    sim = F0.mapaccum(N-1);

    out = full(sim(q0));
end