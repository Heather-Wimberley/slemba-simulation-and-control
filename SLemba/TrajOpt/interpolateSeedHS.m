%% Interpolate seed for larger N values

clear;
clc;

N0_new = 10; N1_new = 10; N2_new = 10;
N_new = N0_new + N1_new + N2_new;

d = 2;

speed = 1;
seed_file = "run_"+ floor(speed) + "p" + floor(mod(speed,1)*100) + "ms";
seed_file = "seed_1ms_new.mat";
seed = load("OscParamSolver\resultsOscParamSolver\" + seed_file);
seed = seed.out;

N0_old = seed.N0; N1_old = seed.N1; N2_old = seed.N2; 
N_old = N0_old + N1_old + N2_old;

x0 = seed.tst*ones(N_new*d-1,1);
x0 = [x0;seed.tsw*ones(N_new*d-1,1)];
x0 = [x0;seed.kx*ones(N_new*d-1,1)];
x0 = [x0;seed.T0];
x0 = [x0;seed.T1];
x0 = [x0;seed.T2];
x0 = [x0;(seed.T0/N0_new)*ones(N0_new,1)];
x0 = [x0;(seed.T1/N1_new)*ones(N1_new,1)];
x0 = [x0;(seed.T2/N2_new)*ones(N2_new,1)];
x0 = [x0;reshape((interp1(seed.q0',linspace(1,N0_old,N0_new*d)))',[],1)];
x0 = [x0;reshape((interp1(seed.dq0',linspace(1,N0_old,N0_new*d)))',[],1)];
x0 = [x0;reshape((interp1(seed.q1',linspace(1,N1_old,N1_new*d)))',[],1)];
x0 = [x0;reshape((interp1(seed.dq1',linspace(1,N1_old,N1_new*d)))',[],1)];
x0 = [x0;reshape((interp1(seed.q2',linspace(1,N2_old,N2_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.dq2',linspace(1,N2_old,N2_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.cpg0',linspace(1,N0_old,N0_new*d)))',[],1)];
x0 = [x0;reshape((interp1(seed.dcpg0',linspace(1,N0_old,N0_new*d)))',[],1)];
x0 = [x0;reshape((interp1(seed.cpg1',linspace(1,N1_old,N1_new*d)))',[],1)];
x0 = [x0;reshape((interp1(seed.dcpg1',linspace(1,N1_old,N1_new*d)))',[],1)];
x0 = [x0;reshape((interp1(seed.cpg2',linspace(1,N2_old,N2_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.dcpg2',linspace(1,N2_old,N2_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.u',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.u_slack',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.u_x',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.u_y',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.lambda_grf',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.lambda_fend',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.P_xpos',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.P_xneg',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.P_ypos',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.P_yneg',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.x_pos',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.x_neg',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.y_pos',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.y_neg',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.b_posux',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.b_negux',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.b_posuy',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.b_posuy',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.P_fende',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.P_fendr',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.P_grfx_pos',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.P_grfx_neg',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.P_grfy',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.P_fric',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.a_pistonr',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.b_pistonr',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.a_pistone',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.b_pistone',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.a_foot',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.b_foot',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.a_friction',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.b_friction',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.a_slip_p',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.b_slip_p',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.a_slip_n',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.b_slip_n',linspace(1,N_old,N_new*d-1)))',[],1)];
x0 = [x0;reshape((interp1(seed.gamma',linspace(1,N_old,N_new*d-1)))',[],1)];

seed.x0 = x0;
out = seed;
file = "interp_" + floor(speed) + "p" + floor(mod(speed,1)*100) + "ms_" + N_new + ".mat";
save("OscParamSolver\resultsOscHS\" + file,"out");

%% Function to take in array and interpolate
% function out = interpolate(arr,N_old,N_new)
% interp1(seed.q0(1,:),linspace(1,N0_old,N0_new))
% end