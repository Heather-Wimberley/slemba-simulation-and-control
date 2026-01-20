function [initCPG,initPos] = seedOscillator(q0,N,h,osc_param)
    import casadi.*;

    hsym = MX.sym('hsym');
    tst = MX.sym('tst');
    tsw = MX.sym('tsw');

    %% Integrator
    
    opts = struct();
    opts.abstol = 1e-8;       % Absolute tolerance
    opts.reltol = 1e-8;      % Relative tolerance
    opts.linear_solver = 'csparse';
    opts.linear_multistep_method = 'bdf';
    % opts.max_num_steps = 5000;
    opts.sensitivity_method = 'forward';

    q = MX.sym('q',2,1);
    dq_sys = hsym*CPG_Oscillator(q,0,0,tst,tsw);

    dae_syst = struct('x',q,'p',[tst,tsw,hsym],'ode',dq_sys);
    F_sys = integrator('F', 'cvodes', dae_syst,0,1,opts);

    %% Get all points
    res = F_sys('x0',q,'p',[osc_param(1:2)',h]);
    q0_next = res.xf;
    F0 = Function('F',{q},{q0_next},{'q'},{'q_next'});
    sim = F0.mapaccum(N-1);
    cpg = full(sim(q0));

    %% Get positive or negative
    xpos = zeros(length(cpg),1);

    for k = 1:length(xpos)
        if (cpg(1,k)>0)
            xpos(k) = 1;
        end
    end

    ypos = zeros(length(cpg),1);

    for k = 1:length(ypos)
        if (cpg(2,k)>0)
            ypos(k) = 1;
        end
    end

    initCPG = cpg; initPos = [xpos,ypos]';

end