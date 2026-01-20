%% Trajectory Optimisation Parameters
% all boundary and initialisation values for trajectory optimisation

% swing time
init.tsw = 0.45;
LB.tsw = 0; % overwritten in traj opt to be tst
UB.tsw = 1;

% starting condition (q0)
x0 = 0; y0 = 0.5; th0 = th_calc(pi/2,0); l0 = 0;
dx0 = 0.5; dy0 = 0; dth0 = 0; dl0 = 0;
x_osc0 = 0; y_osc0 = 1;
Fe0 = 0; Fr0 = -453;

% init.q0 = [x0;y0;th0;l0;dx0;dy0;dth0;dl0;x_osc0;y_osc0;Fe0;Fr0];
init.q0 = [x0;y0;th0;l0;dx0;dy0;dth0;dl0;Fe0;Fr0];
init.cpg0 = [x_osc0;y_osc0];

% Moment of impact condition (q1)
x1 = 0; y1 = r_calc(th_calc(pi/2,0.05),0.05); th1 = th_calc(pi/2,0.05); l1 = 0.05;
dx1 = 0; dy1 = -3; dth1 = 0; dl1 = 0;
x_osc1 = -1; y_osc1 = 0;
Fe1 = 529; Fr1 = -453;

% init.q1 = [x1;y1;th1;l1;dx1;dy1;dth1;dl1;x_osc1;y_osc1;Fe1;Fr1];
init.q1 = [x1;y1;th1;l1;dx1;dy1;dth1;dl1;Fe1;Fr1];
init.cpg1 = [x_osc1;y_osc1];

% Take off condition (q2)
x2 = 0; y2 = 0.4; th2 = 0.5; l2 = 0.07;
dx2 = 0; dy2 = 3; dth2 = 0; dl2 = 2;
x_osc2 = 1; y_osc2 = 0;
Fe2 = 529; Fr2 = 0;

% init.q2 = [x2;y2;th2;l2;dx2;dy2;dth2;dl2;x_osc2;y_osc2;Fe2;Fr2];
init.q2 = [x2;y2;th2;l2;dx2;dy2;dth2;dl2;Fe2;Fr2];
init.cpg2 = [x_osc2;y_osc2];

% Lower and Upper Bounds of Generalised coordinates
x_lb = -10; y_lb = -1; th_lb = 0; l_lb = 0;
dx_lb = -inf; dy_lb = -inf; dth_lb = -inf; dl_lb = -inf;
x_osc_lb = -1.3; y_osc_lb = -1.3;
Fe_lb = -10; Fr_lb = -463;
% Fe_lb = 0; Fr_lb = -453;

% LB.q = [x_lb;y_lb;th_lb;l_lb;dx_lb;dy_lb;dth_lb;dl_lb;x_osc_lb;y_osc_lb;Fe_lb;Fr_lb];
LB.q = [x_lb;y_lb;th_lb;l_lb;dx_lb;dy_lb;dth_lb;dl_lb;Fe_lb;Fr_lb];
LB.osc = [x_osc_lb;y_osc_lb];

x_ub = 10; y_ub = 2; th_ub = pi; l_ub = 0.07;
dx_ub = inf; dy_ub = inf; dth_ub = inf; dl_ub = inf;
x_osc_ub = 1.3; y_osc_ub = 1.3;
Fe_ub = 539; Fr_ub = 10;
% Fe_ub = 529; Fr_ub = 0;

% UB.q = [x_ub;y_ub;th_ub;l_ub;dx_ub;dy_ub;dth_ub;dl_ub;x_osc_ub;y_osc_ub;Fe_ub;Fr_ub];
UB.q = [x_ub;y_ub;th_ub;l_ub;dx_ub;dy_ub;dth_ub;dl_ub;Fe_ub;Fr_ub];
UB.osc = [x_osc_ub;y_osc_ub];

% upper and lower bounds of input
tau_lb = -38; ue_lb = -1e-3; ur_lb = -1e-3;
% tau_lb = 0; ue_lb = 0; ur_lb = 0;

LB.u = [tau_lb;ue_lb;ur_lb];
% LB.u = [ue_lb;ur_lb];

tau_ub = 38; ue_ub = 1 + 1e-3; ur_ub = 1 + 1e-3;
% tau_ub = 0; ue_ub = 0; ur_ub = 0;

UB.u = [tau_ub;ue_ub;ur_ub];
% UB.u = [ue_ub;ur_ub];

tau0 = 0; ue0 = 1; ur0 = 1;
init.u0 = [tau0;ue0;ur0];
tau1 = 0; ue1 = 1; ur1 = 0;
init.u1 = [tau1;ue1;ur1];
tau2 = 0; ue2 = 0; ur2 = 1;
init.u2 = [tau2;ue2;ur2];

% intial guess and upper and lower bounds of time intervals
init.T0 = 0.15; init.T1 = 0.08; init.T2 = 0.15;

UB.T = 1; LB.T = 1e-3;