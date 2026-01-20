function out = createOptiOscParamSolver(N,N0,N1,N2)
%CREATEOPTIOSCPARAMSOLVER create opti variable to solve for oscillator
%   Create the optimisation problem using SLemba controlled by a CPG. There
%   is a single parameter (average velocity) and NLP can be solved to get
%   the tst, tsw and kx of the CPG controller for that speed


%% Optimiser
import casadi.*

opti = casadi.Opti();

% % set number of nodes
% N0 = 10; N1 = 10; N2 = 10;
% N = N0 + N1 + N2;

% import integrator, intial variables and Upper and Lower Bounds
trajOptIntegrator;
trajOptParam;

kx_val = 0.08; tst_val = 0.08; tsw_guess = 0.33;
osc_param = [tst_val;tsw_guess;kx_val];

[initCPG,initUPos] = seedOscillator(init.cpg0,N,(tst_val+tsw_guess)/N,osc_param);

% initCPG0 = seedCreationCPG(init.cpg0,N0,init.T0/N0,init.q0,osc_param);
% initCPG1 = seedCreationCPG(init.cpg1,N1,init.T1/N1,init.q1,osc_param);
% initCPG2 = seedCreationCPG(init.cpg2,N2,init.T2/N2,init.q2,osc_param);

% get the initial seed using intial variables
initQ0 = seedCreationInput(init.q0,N0,init.T0/N0,init.u0);
initQ1 = seedCreationInput(init.q2,N1,init.T1/N1,init.u1);
initQ2 = seedCreationInput(init.q1,N2,init.T2/N2,init.u2);

initQ = seedCreation([init.q0;initCPG(:,1)],N,osc_param,(tst_val+tsw_guess)/N);
initQ0 = [init.q0,initQ(1:10,1:N0-1)];
initQ1 = initQ(1:10,N0:N0 + N1 -1);
initQ2 = initQ(1:10,N0 + N1:end);

%% Oscillator Parameters
% kx = opti.variable(); opti.set_initial(kx,kx_val); opti.subject_to(kx == kx_val);
% tst = opti.variable(); opti.set_initial(tst,tst_val); opti.subject_to(tst == tst_val);
% kx = opti.parameter(N); opti.set_value(kx,repmat(kx_val,N,1));
% tst = opti.parameter(N); opti.set_value(tst,repmat(tst_val,N,1));
tst = opti.variable(N); opti.set_initial(tst,repmat(tst_val,N,1)); opti.subject_to(repmat(1e-2,N,1)<=tst<=0.12*ones(N,1));
% tst = 0.1*ones(N,1);
tsw = opti.variable(N); opti.set_initial(tsw,repmat(tsw_guess,N,1)); opti.subject_to(repmat(1e-3,N,1)<=tsw<=ones(N,1));
kx = opti.variable(N); opti.set_initial(kx,repmat(kx_val,N,1)); opti.subject_to(repmat(0,N,1)<=kx<=0.5*ones(N,1));
% osc_param = [tst;tsw;kx];
% tsw = repmat(tsw_guess,N,1);
%tst = tst_val; kx = kx_val;% tsw = tsw_guess; 

% tsw_fit = load('TrajOpt_runs\fit2.mat');
% 
% coeff = coeffvalues(tsw_fit.trajopt_fit);
% 
% x_temp = tst(1); y_temp = kx(1);
% 
% opti.subject_to(tsw(1) == coeff(1) + coeff(2)*x_temp + coeff(3)*y_temp + coeff(4)*x_temp^2 + coeff(5)*x_temp*y_temp + coeff(6)*y_temp^2 + coeff(7)*x_temp^3 + coeff(8)*x_temp^2*y_temp + coeff(9)*x_temp*y_temp^2 + coeff(10)*y_temp^3 + coeff(11)*x_temp^4 + coeff(12)*x_temp^3*y_temp + coeff(13)*x_temp^2*y_temp^2 + coeff(14)*x_temp*y_temp^3 + coeff(15)*y_temp^4);

% opti.subject_to(tst<kx);

%% Create time variables
% T0 = opti.variable(N0); opti.set_initial(T0,init.T0*ones(N0,1)); opti.subject_to(LB.T*ones(N0,1)<=T0<=UB.T*ones(N0,1));
% T1 = opti.variable(N1); opti.set_initial(T1,init.T1*ones(N1,1)); opti.subject_to(LB.T*ones(N1,1)<=T1<=UB.T*ones(N1,1));
% T2 = opti.variable(N2); opti.set_initial(T2,init.T2*ones(N2,1)); opti.subject_to(LB.T*ones(N2,1)<=T2<=UB.T*ones(N2,1));

T0 = opti.variable(); opti.set_initial(T0,init.T0); opti.subject_to(LB.T<=T0<=UB.T);
T1 = opti.variable(); opti.set_initial(T1,init.T1); opti.subject_to(LB.T<=T1<=UB.T);
T2 = opti.variable(); opti.set_initial(T2,init.T2); opti.subject_to(LB.T<=T2<=UB.T);

% opti.subject_to(T1 == tst(1));
% % opti.subject_to(T0 == T2);
% opti.subject_to(T0 + T2 == tsw(1));
% opti.subject_to(0.8*T2 <= T0 <= 1.2*T2);
% % opti.subject_to(T0 == tsw(1)/2);
% % opti.subject_to(T2 == tsw(1)/2);
% % opti.subject_to(T0 + T1 + T2 == tst + tsw);

opti.subject_to(tst(1)*0.95 <= T1 <= tst(1)*1.05);
opti.subject_to(0.8*T2 <= T0 <= 1.2*T2);
opti.subject_to(T0 + T1 + T2 == tst(1) + tsw(1));

% nodes of T0
h0_global = T0/N0;

h0 = opti.variable(N0);
opti.set_initial(h0,repmat(init.T0/N0,N0,1));
opti.subject_to(repmat(h0_global*0.8,N0,1)<=h0<=repmat(h0_global*1.2,N0,1));
% opti.subject_to(h0_global*0.8<=h0<=h0_global*1.2);
opti.subject_to(sum(h0) == T0);

% nodes of T1
h1_global = T1/N1;

h1 = opti.variable(N1);
opti.set_initial(h1,repmat(init.T1/N1,N1,1));
opti.subject_to(repmat(h1_global*0.8,N1,1)<=h1<=repmat(h1_global*1.2,N1,1));
% opti.subject_to(h1_global*0.8<=h1<=h1_global*1.2);
opti.subject_to(sum(h1) == T1);

% nodes of T2
h2_global = T2/(N2);

h2 = opti.variable(N2);
opti.set_initial(h2,repmat(init.T2/N2,N2,1));
opti.subject_to(repmat(h2_global*0.8,N2,1)<=h2<=repmat(h2_global*1.2,N2,1));
% opti.subject_to(h2_global*0.8<=h2<=h2_global*1.2);
opti.subject_to(sum(h2) == T2);

%% Kinematic Constraints
% q = [x,y,th,l,dx,dy,dth,dl,Fe,Fr]
q0 = opti.variable(10,N0); dq0 = opti.variable(10,N0); opti.set_initial(q0,initQ0);%[init.q0,initQ0]);
opti.subject_to(repmat(LB.q,1,N0)<=q0<=repmat(UB.q,1,N0));
% opti.subject_to(repmat(LB.q(1:3),1,N0)<=q0(1:3,:)<=repmat(UB.q(1:3),1,N0));
% opti.subject_to(repmat(LB.q(5:end),1,N0)<=q0(5:end,:)<=repmat(UB.q(5:end),1,N0));
% opti.subject_to(repmat(LB.q(4),1,N0)<=q0(4)<repmat(UB.q(4),1,N0));

q1 = opti.variable(10,N1); dq1 = opti.variable(10,N1); opti.set_initial(q1,initQ1);%[init.q1,initQ1]);
opti.subject_to(repmat(LB.q,1,N1)<=q1<=repmat(UB.q,1,N1));
% opti.subject_to(repmat(LB.q(1:3),1,N1)<=q1(1:3,:)<=repmat(UB.q(1:3),1,N1));
% opti.subject_to(repmat(LB.q(5:end),1,N1)<=q1(5:end,:)<=repmat(UB.q(5:end),1,N1));
% opti.subject_to(repmat(LB.q(4),1,N1)<=q1(4)<repmat(UB.q(4),1,N1));

q2 = opti.variable(10,N2); dq2 = opti.variable(10,N2); opti.set_initial(q2,initQ2);%[init.q2,initQ2]);
opti.subject_to(repmat(LB.q,1,N2)<=q2<=repmat(UB.q,1,N2));
% opti.subject_to(repmat(LB.q(1:3),1,N2)<=q2(1:3,:)<=repmat(UB.q(1:3),1,N2));
% opti.subject_to(repmat(LB.q(5:end),1,N2)<=q2(5:end,:)<=repmat(UB.q(5:end),1,N2));
% opti.subject_to(repmat(LB.q(4),1,N2)<=q2(4)<repmat(UB.q(4),1,N2));

% cpg = [x_osc,y_osc]
% cpg0 = opti.variable(2,N0); dcpg0 = opti.variable(2,N0); opti.set_initial(cpg0,[init.cpg0,initCPG0]);
cpg0 = opti.variable(2,N0); dcpg0 = opti.variable(2,N0); opti.set_initial(cpg0,[init.cpg0,initCPG(:,1:N0-1)]);
opti.subject_to(-1.3*ones(2,N0)<=cpg0<=1.3*ones(2,N0));
% cpg1 = opti.variable(2,N1); dcpg1 = opti.variable(2,N1); opti.set_initial(cpg1,[init.cpg1,initCPG1]);
cpg1 = opti.variable(2,N1); dcpg1 = opti.variable(2,N1); opti.set_initial(cpg1,initCPG(:,N0:N0+N1-1));
opti.subject_to(-1.3*ones(2,N1)<=cpg1<=1.3*ones(2,N1));
% cpg2 = opti.variable(2,N2); dcpg2 = opti.variable(2,N2); opti.set_initial(cpg2,[init.cpg2,initCPG2]);
cpg2 = opti.variable(2,N2); dcpg2 = opti.variable(2,N2); opti.set_initial(cpg2,initCPG(:,N0+N1:end));
opti.subject_to(-1.3*ones(2,N2)<=cpg2<=1.3*ones(2,N2));

% intial state
opti.subject_to(q0(1,1) == 0); % x == 0
% opti.subject_to(0.35 <= q0(2,1) <= 0.8); % y == 0.5
opti.subject_to(q0(3,1) == th_calc(kx(1)*cpg0(1,1) + pi/2,0)); % th == 0.61
opti.subject_to(q0(4,1) == 0); % l == 0
% opti.subject_to(kx*2 <= q0(5,1) <= kx*15); % dx == 0
opti.subject_to(q0(6,1) == 0); % dy == 0
% opti.subject_to(q0(7,1) == 0); % dth == 0
% opti.subject_to(q0(8,1) == 0); % dl == 0
% opti.subject_to(q0(9,1) == 0); % Fe
% opti.subject_to(q0(10,1) == -453); % Fr

% opti.subject_to(cpg0(1,1) == 0);
% opti.subject_to(cpg0(2,1) == 1);
opti.subject_to(-0.4 <= cpg0(1,1) <= 0.4);
opti.subject_to(cpg0(2,1) >= 0.9);

% inputs for whole traj
u = opti.variable(3,N); opti.subject_to(repmat(LB.u,1,N)<=u<=repmat(UB.u,1,N));
u_slack = opti.variable(3,N); opti.subject_to(repmat(LB.u,1,N)<=u_slack<=repmat(UB.u,1,N)); % slack variable for output of mapping

% state of cpg (pos = 1, neg = 0)
u_x = opti.variable(N); opti.subject_to(zeros(N,1)<=u_x<=ones(N,1));
opti.set_initial(u_x,[0,initUPos(1,:)]);
u_y = opti.variable(N); opti.subject_to(zeros(N,1)<=u_y<=ones(N,1));
opti.set_initial(u_y,[1,initUPos(2,:)]);

% % speed torque curve
% t_max = 38; %Nm
% t_rated = 9.1; %Nm
% w_max = 218/60*2*pi; %rad/s
% w_rated = 177*2*pi/60; %rad/s

% contact force for entire traj
lambda_grf = opti.variable(3,N); % grfx_pos, grfx_neg, grfy
lambda_fend = opti.variable(2,N); % fendr, fende

% Collocation

% implicit formulation
%% Phase 1: Swing 1
for k = 1:N0
    lambda = [lambda_grf(1,k)-lambda_grf(2,k);lambda_grf(3,k);lambda_fend(:,k)];

    q_sys = num2cell(q0(1:end-2,k));
    foot_dynamics = foot_Func(q_sys{:});

    opti.subject_to(dq0(:,k) == dq_ode_in_comp(q0(:,k),u(:,k),lambda));
    opti.subject_to(dcpg0(:,k) == ode_osc(cpg0(:,k),foot_dynamics(2),foot_dynamics(4),tst(k),tsw(k)));

    if k>1
        opti.subject_to(q0(:,k) == q0(:,k-1) + h0(k-1)*dq0(:,k));
        opti.subject_to(cpg0(:,k) == cpg0(:,k-1) + h0(k-1)*dcpg0(:,k));
    end

    % % foot is always above or on floor
    % opti.subject_to(u(:,k) == CPG_states_Hopf(cpg0(:,k),dcpg0(:,k),q0(:,k),dq0(:,k),kx));

    % no foot contact
    opti.subject_to(lambda_grf(3,k)<=0);

    % opti.subject_to(foot_dynamics(2)>1e-3);

    % opti.subject_to(cpg0(2,:)>0);
end

% state condition between nodes
opti.subject_to(q1(:,1) == q0(:,end) + h0(end)*dq1(:,1));
opti.subject_to(cpg1(:,1) == cpg0(:,end) + h0(end)*dcpg1(:,1));

% cpg switches y at this point (remove foot feedback)
% opti.subject_to(cpg0(2,end)>=0);
% opti.subject_to(cpg1(2,1)<=0);
opti.subject_to(cpg1(2,1)==0);

%% Phase 2: Stance
for k1 = 1:N1
    k = k1 + N0;
    lambda = [lambda_grf(1,k)-lambda_grf(2,k);lambda_grf(3,k);lambda_fend(:,k)];

    q_sys = num2cell(q1(1:end-2,k1));
    foot_dynamics = foot_Func(q_sys{:});

    opti.subject_to(dq1(:,k1) == dq_ode_in_comp(q1(:,k1),u(:,k),lambda));
    opti.subject_to(dcpg1(:,k1) == ode_osc(cpg1(:,k1),foot_dynamics(2),foot_dynamics(4),tst(k),tsw(k)));
    if k1>1
        opti.subject_to(q1(:,k1) == q1(:,k1-1) + h1(k1-1)*dq1(:,k1));
        opti.subject_to(cpg1(:,k1) == cpg1(:,k1-1) + h1(k1-1)*dcpg1(:,k1));
    end

    % if k1<floor(N1/2) && k1>1
    %     opti.subject_to(cpg1(2,k1)<0);
    % end

    % % foot is always above or on floor
    % q_sys = num2cell(q1(1:end-4,k1));
    % foot_dynamics = foot_Func(q_sys{:});
    % 
    opti.subject_to(foot_dynamics(2)<=0);

    % set inputs equal to ones from cpg
    % opti.subject_to(u(:,k) == CPG_states_Hopf(cpg1(:,k1),dcpg1(:,k1),q1(:,k1),dq1(:,k1),kx));

    % always has compliance
    % opti.subject_to(q1(4,k1) > 0);
    % opti.subject_to(q1(4,k1) > UB.q(4)*0.1);

    % foot contact
    opti.subject_to(lambda_grf(3,k)>0);
end

% state condition between nodes
opti.subject_to(q2(:,1) == q1(:,end) + h1(end)*dq2(:,1));
opti.subject_to(cpg2(:,1) == cpg1(:,end) + h1(end)*dcpg2(:,1));
% 
% opti.subject_to(cpg1(2,end) <= 0);
% opti.subject_to(cpg1(2,end) >= -0.2);
opti.subject_to(q1(4,end)<UB.q(4));
opti.subject_to(q2(4,1)<UB.q(4));

%% Phase 3: Swing 2
for k2 = 1:N2
    k = k2 + N0 + N1;
    lambda = [lambda_grf(1,k)-lambda_grf(2,k);lambda_grf(3,k);lambda_fend(:,k)];

    q_sys = num2cell(q2(1:end-2,k2));
    foot_dynamics = foot_Func(q_sys{:});

    opti.subject_to(dq2(:,k2) == dq_ode_in_comp(q2(:,k2),u(:,k),lambda));
    opti.subject_to(dcpg2(:,k2) == ode_osc(cpg2(:,k2),foot_dynamics(2),foot_dynamics(4),tst(k),tsw(k)));
    if k2>1
        opti.subject_to(q2(:,k2) == q2(:,k2-1) + h2(k2-1)*dq2(:,k2));
        opti.subject_to(cpg2(:,k2) == cpg2(:,k2-1) + h2(k2-1)*dcpg2(:,k2));
    end

    % % foot is always above or on floor
    % q_sys = num2cell(q2(1:end-4,k2));
    % foot_dynamics = foot_Func(q_sys{:});
    % 
    % opti.subject_to(foot_dynamics(2)>1e-3);

    % % set inputs equal to ones from cpg
    % opti.subject_to(u(:,k) == CPG_states_Hopf(cpg2(:,k2),dcpg2(:,k2),q2(:,k2),dq2(:,k2),kx));

    % no foot contact
    opti.subject_to(lambda_grf(3,k)<=0);

    opti.subject_to(lambda_fend(2,k) <=0);
end


% final state
opti.subject_to(q0(2,1) == q2(2,end));
opti.subject_to(q0(3,1) == q2(3,end)); 
opti.subject_to(q0(4,1) == q2(4,end)); 
opti.subject_to(q0(5,1) == q2(5,end)); 
opti.subject_to(q0(6,1) == q2(6,end)); % dy == 0
opti.subject_to(q0(7,1) == q2(7,end)); % dth == 0
opti.subject_to(q0(8,1) == q2(8,end)); % dl == 0
opti.subject_to(q0(9,1) == q2(9,end)); % x_osc == 0
opti.subject_to(q0(10,1) == q2(10,end)); % y_osc == 0
opti.subject_to(cpg0(1,1) == cpg2(1,end)); % Fe == 0
opti.subject_to(cpg0(2,1) == cpg2(2,end)); % Fr == 0
% opti.subject_to(cpg2(2,end)>0); % Fr == 0

% opti.subject_to(tst(1)<0.1);

% speed constraint
vAvg = opti.parameter();
opti.set_value(vAvg,1);
opti.subject_to(q2(1,end)/(T0 + T1 + T2) == vAvg);

opti.subject_to(u == u_slack);

%% Constrain parameters

for k = 1:N-1
    opti.subject_to(kx(k) == kx(k+1));
    opti.subject_to(tst(k) == tst(k+1));
    opti.subject_to(tsw(k) == tsw(k+1));
    % if(k<N0)
    %     opti.subject_to(T0(k) == T0(k+1));
    % end
    % if(k<N1)
    %     opti.subject_to(T1(k) == T1(k+1));
    % end
    % if(k<N2)
    %     opti.subject_to(T2(k) == T2(k+1));
    % end
end

q = [q0,q1,q2];
dq = [dq0,dq1,dq2];
h = [h0;h1;h2];
cpg = [cpg0,cpg1,cpg2];
dcpg = [dcpg0,dcpg1,dcpg2];

%% Controller
% Piston Complementarity Constraints
P_xpos = opti.variable(N); opti.subject_to(P_xpos >= zeros(N,1));
P_xneg = opti.variable(N); opti.subject_to(P_xneg >= zeros(N,1));
P_ypos = opti.variable(N); opti.subject_to(P_ypos >= zeros(N,1));
P_yneg = opti.variable(N); opti.subject_to(P_yneg >= zeros(N,1));

x_pos = opti.variable(N); opti.subject_to(x_pos >= zeros(N,1));
x_neg = opti.variable(N); opti.subject_to(x_neg >= zeros(N,1));
y_pos = opti.variable(N); opti.subject_to(y_pos >= zeros(N,1));
y_neg = opti.variable(N); opti.subject_to(y_neg >= zeros(N,1));

b_posux = opti.variable(N); opti.subject_to(b_posux >= zeros(N,1));
b_negux = opti.variable(N); opti.subject_to(b_negux >= zeros(N,1));

b_posuy = opti.variable(N); opti.subject_to(b_posuy >= zeros(N,1));
b_neguy = opti.variable(N); opti.subject_to(b_neguy >= zeros(N,1));

for k = 1:N
    opti.subject_to(cpg(1,k) == x_pos(k) - x_neg(k));
    opti.subject_to(b_posux(k) == u_x(k));
    opti.subject_to(b_negux(k) == (1-u_x(k)));
    
    opti.subject_to(x_neg(k)*b_posux(k) <= P_xpos(k));
    opti.subject_to(x_pos(k)*b_negux(k) <= P_xneg(k));

    opti.subject_to(cpg(2,k) == y_pos(k) - y_neg(k));
    opti.subject_to(b_posuy(k) == u_y(k));
    opti.subject_to(b_neguy(k) == (1-u_y(k)));
    
    opti.subject_to(y_neg(k)*b_posuy(k) <= P_ypos(k));
    opti.subject_to(y_pos(k)*b_neguy(k) <= P_yneg(k));

    % constraint u
    opti.subject_to(u_slack(3,k) == u_y(k));
    opti.subject_to(u_slack(2,k) == 1 - u_y(k)*u_x(k));
    opti.subject_to(u_slack(1,k) == CPG_states_Torque(cpg(:,k),dcpg(:,k),q(:,k),dq(:,k),kx(k)));
end

%% Complimentarity
P_fende = opti.variable(N); P_fendr = opti.variable(N);
P_grfx_pos = opti.variable(N); P_grfx_neg = opti.variable(N); P_grfy = opti.variable(N); P_fric = opti.variable(N);
opti.subject_to(P_fendr>=zeros(N,1));
opti.subject_to(P_fende>=zeros(N,1));
opti.subject_to(P_grfx_pos>=zeros(N,1));
opti.subject_to(P_grfx_neg>=zeros(N,1));
opti.subject_to(P_grfy>=zeros(N,1));
opti.subject_to(P_fric>=zeros(N,1));

% complemntarity slack variables
a_pistonr = opti.variable(1,N); opti.subject_to(a_pistonr>=zeros(1,N));
b_pistonr = opti.variable(1,N); opti.subject_to(b_pistonr>=zeros(1,N));
a_pistone = opti.variable(1,N); opti.subject_to(a_pistone>=zeros(1,N));
b_pistone = opti.variable(1,N); opti.subject_to(b_pistone>=zeros(1,N));

a_foot = opti.variable(1,N); opti.subject_to(a_foot>=zeros(1,N));
b_foot = opti.variable(1,N); opti.subject_to(b_foot>=zeros(1,N));
a_friction = opti.variable(1,N); opti.subject_to(a_friction>=zeros(1,N));
b_friction = opti.variable(1,N); opti.subject_to(b_friction>=zeros(1,N));
a_slip_p = opti.variable(1,N); opti.subject_to(a_slip_p>=zeros(1,N));
b_slip_p = opti.variable(1,N); opti.subject_to(b_slip_p>=zeros(1,N));
a_slip_n = opti.variable(1,N); opti.subject_to(a_slip_n>=zeros(1,N));
b_slip_n = opti.variable(1,N); opti.subject_to(b_slip_n>=zeros(1,N));

% Posa Method
gamma = opti.variable(1,N); opti.subject_to(gamma>=zeros(1,N));

for k = 1:N
    % foot position
    q_sys = num2cell(q(1:end-2,k));
    foot_dynamics = foot_Func(q_sys{:});

    % foot position future
    if k<N
        q_sys_future = num2cell(q(1:end-2,k+1));
    else
        q_end = q(:,end-1) + h(end-1)*dq(:,end);
        q_sys_future = num2cell(q_end(1:end-2));
    end    
    foot_dynamics_future = foot_Func(q_sys_future{:});

    y_foot = foot_dynamics_future(2); dx_foot = foot_dynamics(3);
    
    %% piston end stop Compl
    if k<N
        q_lr = q(4,k+1); % penetration of piston while retracting
        q_le = 0.07 - q(4,k+1); % penetration of piston while extending
    else
        q_end = q(:,end-1) + h(end-1)*dq(:,end);
        q_lr = q_end(4);
        q_le = 0.07 - q_end(4);
    end

    opti.subject_to(lambda_fend(1,k) >= 0);
    opti.subject_to(lambda_fend(2,k) >= 0);

    opti.subject_to(q_lr == a_pistonr(k)); 
    opti.subject_to(lambda_fend(1,k) == b_pistonr(k));
    opti.subject_to(q_le == a_pistone(k)); 
    opti.subject_to(lambda_fend(2,k) == b_pistone(k));
    
    % lambda lower bounds
    opti.subject_to(lambda_grf(1,k) >= 0);
    opti.subject_to(lambda_grf(2,k) >= 0);
    opti.subject_to(lambda_grf(3,k) >= 0);

    % Posa method
    mu = 1;
    opti.subject_to(y_foot == a_foot(k)); 
    opti.subject_to(lambda_grf(3,k) == b_foot(k));
    opti.subject_to(lambda_grf(1,k) + lambda_grf(2,k) + a_friction(k) == mu*lambda_grf(3,k));
    opti.subject_to(b_friction(k) == gamma(k));
    opti.subject_to(gamma(k) + dx_foot == a_slip_p(k));
    opti.subject_to(lambda_grf(1,k) == b_slip_p(k));
    opti.subject_to(gamma(k) - dx_foot == a_slip_n(k));
    opti.subject_to(lambda_grf(2,k) == b_slip_n(k));

    % Penalty Constraints
    opti.subject_to(a_pistonr(k)*b_pistonr(k) <= P_fendr(k));
    opti.subject_to(a_pistone(k)*b_pistone(k) <= P_fende(k));
    opti.subject_to(a_foot(k)*b_foot(k) <= P_grfy(k));
    opti.subject_to(a_friction(k)*b_friction(k) <= P_fric(k));
    opti.subject_to(a_slip_p(k)*b_slip_p(k) <= P_grfx_pos(k));
    opti.subject_to(a_slip_n(k)*b_slip_n(k) <= P_grfx_neg(k));
end

%% Manchester method
rho = 1e-1;
opti.subject_to(P_xpos < rho*ones(N,1));
opti.subject_to(P_xneg < rho*ones(N,1));
opti.subject_to(P_ypos < rho*ones(N,1));
opti.subject_to(P_yneg < rho*ones(N,1));
opti.subject_to(P_fendr < rho*ones(N,1));
opti.subject_to(P_fende < rho*ones(N,1));
opti.subject_to(P_grfx_pos < rho*ones(N,1));
opti.subject_to(P_grfx_neg < rho*ones(N,1));
opti.subject_to(P_grfy < rho*ones(N,1));
opti.subject_to(P_fric < rho*ones(N,1));

%% Cost
% 
J = 0;
J_comp = sum(P_fendr) + sum(P_fende);
J_comp = J_comp + sum(P_grfx_pos) + sum(P_grfx_neg) + sum(P_grfy) + sum(P_fric);
J_comp = J_comp + sum(P_xpos) + sum(P_xneg) + sum(P_ypos) + sum(P_yneg);

% J_bin = sum(P_xbin) + sum(P_ybin);
% J = transpose(P_fendr)*P_fendr + transpose(P_fende)*P_fende;
% J = J + transpose(P_grfx_pos)*P_grfx_pos + transpose(P_grfx_neg)*P_grfx_neg + transpose(P_grfy)*P_grfy + transpose(P_fric)*P_fric;
row = 1e3;%1e3;

% periodicity constraints

% J_p = sum((q0(2:end,1)-q2(2:end,end))./q0(2:end,1));
% J_p = J_p + sum((cpg0(:,1)-cpg2(:,end))./cpg0(:,1));
% scale_qp = [1e0;1e0;1e-1;1e1;1e1;1e1;1e1;1e2;1e2];
% scale_cpgp = [1e0;1e0];

J_p = 0;
% scale_qp = ones(9,1); scale_cpgp = ones(2,1);
% J_p = sum(((q0(2:end,1)-q2(2:end,end))./scale_qp).^2);
% J_p = J_p + sum(((cpg0(:,1)-cpg2(:,end))./scale_cpgp).^2);
parameters_monoped;

m_avg = Boom.Connector.mass + Body.mass + Motor.Cover.mass + Femur.mass + Tibia.mass + Piston.Body.mass + Piston.Rod.mass;

% cost on actuation
J_u = 0;
J_u = J_u + sum(u(1,:)/(40).^2);
% J_u = J_u + 1e3*sum((u(2,:).*h').^2);
% J_u = J_u + sum((1e1*kx).^2);
J_u = J_u + sum((tst/0.1).^2);

opti.minimize(row*J_comp + J_p + J_u);

%% Run Solver

% Solver options
opts = struct;
opts.ipopt.max_iter = 1e5;
opts.ipopt.tol = 1e-6;
opts.ipopt.acceptable_tol = 1e-4;
opts.ipopt.hessian_approximation = 'limited-memory';
opts.ipopt.limited_memory_max_history = 5;
opts.ipopt.mu_strategy = 'adaptive';
opts.ipopt.linear_solver = 'ma97';
opts.detect_simple_bounds = true;
opti.solver('ipopt',opts);

out = opti;
end

