%% Solve for CPG parameters for SLemba using IPOPT
% give a desired average speed

%% Setup
clc;
clear;

import casadi.*;

N0 = 30; N1 = 20; N2 = 20;
N = N0 + N1 + N2;

opti = createOptiOscParamSolver(N,N0,N1,N2); % note x0[1:3] are [tst,tsw,kx] as 1xN matrices

% s = opti.solve();

%% Change vAvg (default is 1m/s)

speed = linspace(1,0,15);
% speed = linspace(1.36,4,28);
speed1 = linspace(0,1,15);
speed2 = linspace(1,2,15);

speed = [speed1,speed2(2:end)];

speed = 1;

startVal = 1;
endVal = length(speed);

for i = startVal:endVal %length(speed)
vAvgVal = speed(i);

% load seed
% seed_file = "seed_1ms_new.mat";
% seed_file = "interp_1ms_70.mat";
% seed_file = "interp_1ms_90.mat";
% seed_file = "seed_2ms.mat";
% seed_file = "OscParamSolver\resultsOscParamSolver\" + "run_1p0ms.mat";
% 
try
    % seed_file = "OscParamSolver\resultsOscParamSolverAll\" + "run_"+ floor(speed(i)) + "p" + floor(mod(speed(i),1)*100) + "ms.mat";
% if i>1
%     seed_file = "OscParamSolver\resultsOscParamSolverAll\" + "run_"+ floor(speed(i-1)) + "p" + floor(mod(speed(i-1),1)*100) + "ms.mat";
% end

% seed_file = "l";
% seed_file = "seed_1ms_new_40.mat";
seed = load(seed_file);
seed = seed.out;
catch
seed_file = "seed_1ms_new.mat";
seed = load(seed_file);
seed = seed.out;
end

x0 = seed.x0; lam_g0 = seed.lam_g0;

% lam_g0 = [lam_g0(1:1267);0;0;lam_g0(1268:end)];

try
    opti.set_initial(opti.x,x0); 
catch 
    % disp("Seed wrong x0 size");
    opti.set_initial(opti.x,interpolateSeedInput(seed,N0,N1,N2));
end

try
    opti.set_initial(opti.lam_g,lam_g0);
catch
    disp("Seed wrong lam_g0 size");
end
vAvg = opti.p; opti.set_value(vAvg,vAvgVal); 
try
s = opti.solve();

%% Sort results
% % create sol value with all opti results
x0 = opti.value(opti.x); lam_g0 = opti.value(opti.lam_g);

sol.x0 = x0; sol.lam_g0 = lam_g0;

sol.vAvg = opti.value(opti.p);
index = 1;
sol.tst = x0(index); index = index + N;
sol.tsw = x0(index); index = index + N;
sol.kx = x0(index); index = index + N;
sol.T0 = x0(index); index = index + 1;
sol.T1 = x0(index); index = index + 1;
sol.T2 = x0(index); index = index + 1;
sol.h0 = x0(index:index+N0-1); index = index + N0;
sol.h1 = x0(index:index+N1-1); index = index + N1;
sol.h2 = x0(index:index+N2-1); index = index + N2;
sol.q0 = reshape(x0(index:index+10*N0-1),10,[]); index = index + 10*N0;
sol.dq0 = reshape(x0(index:index+10*N0-1),10,[]); index = index + 10*N0;
sol.q1 = reshape(x0(index:index+10*N1-1),10,[]); index = index + 10*N1;
sol.dq1 = reshape(x0(index:index+10*N1-1),10,[]); index = index + 10*N1;
sol.q2 = reshape(x0(index:index+10*N2-1),10,[]); index = index + 10*N2;
sol.dq2 = reshape(x0(index:index+10*N2-1),10,[]); index = index + 10*N2;
sol.cpg0 = reshape(x0(index:index+2*N0-1),2,[]); index = index + 2*N0;
sol.dcpg0 = reshape(x0(index:index+2*N0-1),2,[]); index = index + 2*N0;
sol.cpg1 = reshape(x0(index:index+2*N1-1),2,[]); index = index + 2*N1;
sol.dcpg1 = reshape(x0(index:index+2*N1-1),2,[]); index = index + 2*N1;
sol.cpg2 = reshape(x0(index:index+2*N2-1),2,[]); index = index + 2*N2;
sol.dcpg2 = reshape(x0(index:index+2*N2-1),2,[]); index = index + 2*N2;
sol.u = reshape(x0(index:index+3*N-1),3,[]); index = index + 3*N;
sol.u_slack = reshape(x0(index:index+3*N-1),3,[]); index = index + 3*N;
sol.u_x = x0(index:index + N - 1); index = index + N;
sol.u_y = x0(index:index + N - 1); index = index + N;
sol.lambda_grf = reshape(x0(index:index+3*N-1),3,[]); index = index + 3*N;
sol.lambda_fend = reshape(x0(index:index+2*N-1),2,[]); index = index + 2*N;
sol.P_xpos = x0(index:index + N - 1); index = index + N;
sol.P_xneg = x0(index:index + N - 1); index = index + N;
sol.P_ypos = x0(index:index + N - 1); index = index + N;
sol.P_yneg = x0(index:index + N - 1); index = index + N;
sol.x_pos = x0(index:index + N - 1); index = index + N;
sol.x_neg = x0(index:index + N - 1); index = index + N;
sol.y_pos = x0(index:index + N - 1); index = index + N;
sol.y_neg = x0(index:index + N - 1); index = index + N;
sol.b_posux = x0(index:index + N - 1); index = index + N;
sol.b_negux = x0(index:index + N - 1); index = index + N;
sol.b_posuy = x0(index:index + N - 1); index = index + N;
sol.b_neguy = x0(index:index + N - 1); index = index + N;
sol.P_fende = x0(index:index + N - 1); index = index + N;
sol.P_fendr = x0(index:index + N - 1); index = index + N;
sol.P_grfx_pos = x0(index:index + N - 1); index = index + N;
sol.P_grfx_neg = x0(index:index + N - 1); index = index + N;
sol.P_grfy = x0(index:index + N - 1); index = index + N;
sol.P_fric = x0(index:index + N - 1); index = index + N;
sol.a_pistonr = x0(index:index + N - 1); index = index + N;
sol.b_pistonr = x0(index:index + N - 1); index = index + N;
sol.a_pistone = x0(index:index + N - 1); index = index + N;
sol.b_pistone = x0(index:index + N - 1); index = index + N;
sol.a_foot = x0(index:index + N - 1); index = index + N;
sol.b_foot = x0(index:index + N - 1); index = index + N;
sol.a_friction = x0(index:index + N - 1); index = index + N;
sol.b_friction = x0(index:index + N - 1); index = index + N;
sol.a_slip_p = x0(index:index + N - 1); index = index + N;
sol.b_slip_p = x0(index:index + N - 1); index = index + N;
sol.a_slip_n = x0(index:index + N - 1); index = index + N;
sol.b_slip_n = x0(index:index + N - 1); index = index + N;
sol.gamma = x0(index:index + N - 1); index = index + N;

sol.h = [sol.h0;sol.h1;sol.h2];
sol.q = [sol.q0,sol.q1,sol.q2];
sol.dq = [sol.dq0,sol.dq1,sol.dq2];
sol.cpg = [sol.cpg0,sol.cpg1,sol.cpg2];
sol.dcpg = [sol.dcpg0,sol.dcpg1,sol.dcpg2];

sol.N0 = N0; sol.N1 = N1; sol.N2 = N2; sol.N = N;

time = 0;
for k = 1:length(sol.h)-1
    time = [time;time(end)+sol.h(k)];
end
sol.time = time;
out = sol;
% out.tst  = 0.1;

%% Save Results

% filename = "seed_1ms_30";
filename = "run_"+ floor(vAvgVal) + "p" + floor(mod(vAvgVal,1)*100) + "ms";
save("OscParamSolver\resultsOscParamSolverAll\"+filename+".mat","out");

% 
%% Plot
plot(sol.P_fende,'*');
hold on
plot(sol.P_fendr,'*');
plot(sol.P_grfx_pos,'*');
plot(sol.P_grfx_neg,'*');
plot(sol.P_grfy,'*');
plot(sol.P_fric,'*');
title('Contact Penalties')
legend('fende','fendr','grfx_p','grfx_n','grfy','fric');
hold off

figure
plot(sol.P_xpos,'*');
hold on 
plot(sol.P_xneg,'*');
plot(sol.P_ypos,'*');
plot(sol.P_yneg,'*');
title('CPG Penalties');
legend('xpos','xneg','ypos','yneg');
hold off
catch
end
end