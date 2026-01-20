%% Solve for CPG parameters for SLemba using IPOPT
% give a desired average speed

%% Setup
clc;
clear;

import casadi.*;

N0 = 10; N1 = 10; N2 = 10;
N = N0 + N1 + N2;

d = 2;

N_hs = N*d - 1;

N0_hs = N0*d;
N1_hs = N1*d;
N2_hs = N2*d - 1;

opti = createOptiOscParamSolverHermiteSimpson(N,N0,N1,N2,d); % note x0[1:3] are [tst,tsw,kx] as 1xN matrices
% 
% s = opti.solve();

%% Change vAvg (default is 1m/s)

% % speed = linspace(0.2,4,40);
% % % speed = linspace(1.27,4,30);
speed = 1;
% 
for vAvgVal = speed
% load seed
seed_file = "interp_" + floor(speed) + "p" + floor(mod(speed,1)*100) + "ms_" + N + ".mat";
% seed_file = "run_1p95ms.mat";
% seed_file = "seed_1ms_new_40.mat";
seed = load("OscParamSolver\resultsOscHS\" + seed_file);
seed = seed.out;

% vAvgVal = 1;


x0 = seed.x0; lam_g0 = seed.lam_g0;

try
    opti.set_initial(opti.x,x0); 
catch 
    disp("Seed wrong x0 size");
end

try
    opti.set_initial(opti.lam_g,lam_g0);
catch
    disp("Seed wrong lam_g0 size");
end

vAvg = opti.p; opti.set_value(vAvg,vAvgVal); 
s = opti.solve();

%% Sort results
% % create sol value with all opti results
x0 = opti.value(opti.x); lam_g0 = opti.value(opti.lam_g);

% sol.x0 = x0; sol.lam_g0 = lam_g0;

sol.vAvg = opti.value(opti.p);
index = 1;
sol.tst = x0(index); index = index + N_hs;
sol.tsw = x0(index); index = index + N_hs;
sol.kx = x0(index); index = index + N_hs;
sol.T0 = x0(index); index = index + 1;
sol.T1 = x0(index); index = index + 1;
sol.T2 = x0(index); index = index + 1;
sol.h0 = x0(index:index+N0-1); index = index + N0;
sol.h1 = x0(index:index+N1-1); index = index + N1;
sol.h2 = x0(index:index+N2-1); index = index + N2;
sol.q0 = reshape(x0(index:index+10*N0_hs-1),10,[]); index = index + 10*N0_hs;
sol.dq0 = reshape(x0(index:index+10*N0_hs-1),10,[]); index = index + 10*N0_hs;
sol.q1 = reshape(x0(index:index+10*N1_hs-1),10,[]); index = index + 10*N1_hs;
sol.dq1 = reshape(x0(index:index+10*N1_hs-1),10,[]); index = index + 10*N1_hs;
sol.q2 = reshape(x0(index:index+10*N2_hs-1),10,[]); index = index + 10*N2_hs;
sol.dq2 = reshape(x0(index:index+10*N2_hs-1),10,[]); index = index + 10*N2_hs;
sol.cpg0 = reshape(x0(index:index+2*N0_hs-1),2,[]); index = index + 2*N0_hs;
sol.dcpg0 = reshape(x0(index:index+2*N0_hs-1),2,[]); index = index + 2*N0_hs;
sol.cpg1 = reshape(x0(index:index+2*N1_hs-1),2,[]); index = index + 2*N1_hs;
sol.dcpg1 = reshape(x0(index:index+2*N1_hs-1),2,[]); index = index + 2*N1_hs;
sol.cpg2 = reshape(x0(index:index+2*N2_hs-1),2,[]); index = index + 2*N2_hs;
sol.dcpg2 = reshape(x0(index:index+2*N2_hs-1),2,[]); index = index + 2*N2_hs;
sol.u = reshape(x0(index:index+3*N_hs-1),3,[]); index = index + 3*N_hs;
sol.u_slack = reshape(x0(index:index+3*N_hs-1),3,[]); index = index + 3*N_hs;
sol.u_x = x0(index:index + N_hs - 1); index = index + N_hs;
sol.u_y = x0(index:index + N_hs - 1); index = index + N_hs;
sol.lambda_grf = reshape(x0(index:index+3*N_hs-1),3,[]); index = index + 3*N_hs;
sol.lambda_fend = reshape(x0(index:index+2*N_hs-1),2,[]); index = index + 2*N_hs;
sol.P_xpos = x0(index:index + N_hs - 1); index = index + N_hs;
sol.P_xneg = x0(index:index + N_hs - 1); index = index + N_hs;
sol.P_ypos = x0(index:index + N_hs - 1); index = index + N_hs;
sol.P_yneg = x0(index:index + N_hs - 1); index = index + N_hs;
sol.x_pos = x0(index:index + N_hs - 1); index = index + N_hs;
sol.x_neg = x0(index:index + N_hs - 1); index = index + N_hs;
sol.y_pos = x0(index:index + N_hs - 1); index = index + N_hs;
sol.y_neg = x0(index:index + N_hs - 1); index = index + N_hs;
sol.b_posux = x0(index:index + N_hs - 1); index = index + N_hs;
sol.b_negux = x0(index:index + N_hs - 1); index = index + N_hs;
sol.b_posuy = x0(index:index + N_hs - 1); index = index + N_hs;
sol.b_neguy = x0(index:index + N_hs - 1); index = index + N_hs;
sol.P_fende = x0(index:index + N_hs - 1); index = index + N_hs;
sol.P_fendr = x0(index:index + N_hs - 1); index = index + N_hs;
sol.P_grfx_pos = x0(index:index + N_hs - 1); index = index + N_hs;
sol.P_grfx_neg = x0(index:index + N_hs - 1); index = index + N_hs;
sol.P_grfy = x0(index:index + N_hs - 1); index = index + N_hs;
sol.P_fric = x0(index:index + N_hs - 1); index = index + N_hs;
sol.a_pistonr = x0(index:index + N_hs - 1); index = index + N_hs;
sol.b_pistonr = x0(index:index + N_hs - 1); index = index + N_hs;
sol.a_pistone = x0(index:index + N_hs - 1); index = index + N_hs;
sol.b_pistone = x0(index:index + N_hs - 1); index = index + N_hs;
sol.a_foot = x0(index:index + N_hs - 1); index = index + N_hs;
sol.b_foot = x0(index:index + N_hs - 1); index = index + N_hs;
sol.a_friction = x0(index:index + N_hs - 1); index = index + N_hs;
sol.b_friction = x0(index:index + N_hs - 1); index = index + N_hs;
sol.a_slip_p = x0(index:index + N_hs - 1); index = index + N_hs;
sol.b_slip_p = x0(index:index + N_hs - 1); index = index + N_hs;
sol.a_slip_n = x0(index:index + N_hs - 1); index = index + N_hs;
sol.b_slip_n = x0(index:index + N_hs - 1); index = index + N_hs;
sol.gamma = x0(index:index + N_hs - 1); index = index + N_hs;

h_temp = [sol.h0;sol.h1;sol.h2];

% remove mesh points
fields = fieldnames(sol); % Get all field names

for i = 1:numel(fields)
    arr = sol.(fields{i});
    
    if isvector(arr)
        % For 1D vectors (row or column)
        sol.(fields{i}) = arr(1:2:end);
        
    elseif ismatrix(arr)
        % For 2D arrays — remove every second column
        sol.(fields{i}) = arr(:, 1:2:end);
        
    else
        warning('Field "%s" is not a 1D or 2D array. Skipping.', fields{i});
    end
end

sol.x0 = x0; sol.lam_g0 = lam_g0;

sol.h = h_temp;
sol.q = [sol.q0,sol.q1,sol.q2];
% sol.dq = [sol.dq0,sol.dq1,sol.dq2];
sol.cpg = [sol.cpg0,sol.cpg1,sol.cpg2];
sol.dcpg = [sol.dcpg0,sol.dcpg1,sol.dcpg2];

sol.N0 = N0; sol.N1 = N1; sol.N2 = N2; sol.N = N;

out = sol;

%% Save Results

% filename = "seed_1ms";
filename = "run_"+ floor(vAvgVal) + "p" + floor(mod(vAvgVal,1)*100) + "ms";
save("OscParamSolver\resultsOscHS\"+filename+".mat","out");

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

end