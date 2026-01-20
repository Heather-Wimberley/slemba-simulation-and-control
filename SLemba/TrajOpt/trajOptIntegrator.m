%% Create the 2 integrators used in SLemba
import casadi.*

tst = MX.sym('tst');
tsw = MX.sym('tsw');
kx = MX.sym('kx');

tau = MX.sym('tau');
ue = MX.sym('ue');
ur = MX.sym('ur');

u = [tau,ue,ur];

grf_x_pos = MX.sym('grf_x_pos'); grf_x_neg = MX.sym('grf_x_neg'); grf_y = MX.sym('grf_y');
grf_x = MX.sym('grf_x');
fend_r = MX.sym('fend_r'); fend_e = MX.sym('fend_e');

lambda = [grf_x,grf_y,fend_r,fend_e];

osc_param = [tst,tsw,kx];

% dt (h) = T/N
% h0 = SX.sym('h0');
% h1 = SX.sym('h1');
% h2 = SX.sym('h2');
h = MX.sym('h');

x = MX.sym('x'); y = MX.sym('y'); th = MX.sym('th'); l = MX.sym('l');
dx = MX.sym('dx'); dy = MX.sym('dy'); dth = MX.sym('dth'); dl = MX.sym('dl');
x_osc = MX.sym('x_osc'); y_osc = MX.sym('y_osc');
Fe = MX.sym('Fe'); Fr = MX.sym('Fr');

q = [x;y;th;l;dx;dy;dth;dl;x_osc;y_osc;Fe;Fr];
q_in = [x;y;th;l;dx;dy;dth;dl;Fe;Fr];
q_in_comp = [x;y;th;l;dx;dy;dth;dl;Fe;Fr];

opts = struct();
opts.abstol = 1e-8;       % Absolute tolerance
% opts.abstol = [1e-6; 1e-6; 1e-6; 1e-6; 1e-3; 1e-3; 1e-3; 1e-3; 1e-2; 1e-2; 1e-2; 1e-2];
opts.reltol = 1e-8;      % Relative tolerance
opts.linear_solver = 'csparse';
opts.linear_multistep_method = 'bdf';
opts.max_num_steps = 1e5;
opts.max_step_size = 1e-3;
opts.sensitivity_method = 'forward';
% opts.sens_linsol = true;

%% System Integrator with Soft Contacts

% dq_sys = h*monopedKinematics(q,osc_param);
% ode_sys =  @(q,osc_param,lambda) monopedKinematicsComp(q,osc_param,lambda);
ode_osc = @(q,y_foot,dy_foot,tst,tsw) CPG_Oscillator(q,y_foot,dy_foot,tst,tsw);
% ode_osc = @(x,y,y_foot,dy_foot,tst,tsw) [0;0];

% ode_sys_in = @(q,osc_param,u,lambda)

param = [osc_param,h];
% dae_syst = struct('x',q,'p',param,'ode',dq_sys);
% F_sys = integrator('F', 'cvodes', dae_syst,0,1,opts);

dq_in = h*monopedKinematicsInput(q_in,u);

param_in = [h,u];
dae_in = struct('x',q_in,'p',param_in,'ode',dq_in);
F_in = integrator('F', 'cvodes', dae_in,0,1,opts);

dq_in_comp = h*monopedKinematicsInput_comp(q_in_comp,u,lambda);
dq_ode_in_comp = @(q_in_comp,u,lambda) monopedKinematicsInput_comp(q_in_comp,u,lambda);

param_in_comp = [h,u,lambda];
dae_in_comp = struct('x',q_in_comp,'p',param_in_comp,'ode',dq_in_comp);

cvodes = false;

if cvodes
    F_in_comp = integrator('F', 'cvodes', dae_in_comp,0,1,opts);
else
    % Fixed step Runge-Kutta 4 integrator
   M = 4; % RK4 steps per interval
   DT = 1/M;
   f = Function('f', {q_in_comp, [h, u, lambda]}, {dq_in_comp, 0});
   X0 = MX.sym('X0', 10);
   U = param_in_comp;
   X = X0;
   Q = 0;
   for j=1:M
       [k1, k1_q] = f(X, U);
       [k2, k2_q] = f(X + DT/2 * k1, U);
       [k3, k3_q] = f(X + DT/2 * k2, U);
       [k4, k4_q] = f(X + DT * k3, U);
       X=X+DT/6*(k1 +2*k2 +2*k3 +k4);
       Q = Q + DT/6*(k1_q + 2*k2_q + 2*k3_q + k4_q);
    end
    F_in_comp = Function('F', {X0, U}, {X, Q}, {'x0','p'}, {'xf', 'qf'});
end

%% Old Stuff
% %% Swing phase 1, unconstrained
% 
% dq_free1 = h0*monopedKinematics_free(q,osc_param);
% 
% param1 = [osc_param,h0];
% dae_free1 = struct('x',q,'p',param1,'ode',dq_free1);
% F_free1 = integrator('F', 'cvodes', dae_free1,0,1,opts);
% 
% % dq_freeCalc = @(q,osc_param) monopedKinematics_free(q,osc_param);
% 
% %% Stance phase, constrained
% 
% dq_constrain = h1*monopedKinematics_constrain(q,osc_param);
% 
% dae_constrain = struct('x',q,'p',[osc_param,h1],'ode',dq_constrain);
% F_constrain = integrator('F', 'cvodes', dae_constrain,0,1,opts);
% 
% %% Swing phase 2, unconstrained
% 
% dq_free2 = h2*monopedKinematics_free(q,osc_param);
% 
% dae_free2 = struct('x',q,'p',[osc_param,h2],'ode',dq_free2);
% F_free2 = integrator('F', 'cvodes', dae_free2,0,1,opts);