% file to read results from
filename = "TrajOpt_runs/run1.mat";

% filename = "PSO_runs/run1.mat";

load(filename);

Simulink.sdi.setRunNamingRule('Simscape_' + string(out.init.dx) + 'ms');

% load('OscParamsolver/fits/fit1.mat');
% trajopt_dyFit = temp.trajopt_dyFit;

% fit.coeff = coeffvalues(trajopt_dyFit);

% temp = load('fitdy1.mat');
% trajopt_dyFit = temp.trajopt_dyFit;

% starting positions to modify
out.tstInit.CPG = [out.cpg(1,1),out.cpg(2,1)];
Boom.y0 = out.init.y;
% Boom.y0 = 1.5;
% Boom.y0 = 0.45;
Boom.Pitch.q0 = asin((Boom.y0 - Boom.pitchHeightOffset)/Boom.pitchRadius); % rad
Boom.Pitch.dq0 = 0;

% out.init.dx = 0;
Boom.Yaw.dq0 = out.init.dx/Boom.yawRadius;

Hip.q0 = -out.init.th;
Hip.dq0 = -out.init.dth;
% Hip.q0 = -th_calc(pi/2,0);
% Hip.dq0 = 0;

CPG.tst = out.tst(1);
CPG.tsw = out.tsw(1);
CPG.kx = out.kx(1);
